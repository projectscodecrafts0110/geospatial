<?php

declare(strict_types=1);
require_once __DIR__ . '/real_data_normalization.php';

function xlsx_cell_column(string $reference): int
{
    preg_match('/^[A-Z]+/', strtoupper($reference), $m); $n=0;
    foreach(str_split($m[0]??'') as $c)$n=$n*26+(ord($c)-64);
    return $n;
}

function xlsx_read_rows(string $path): array
{
    $zip=new ZipArchive(); if($zip->open($path)!==true)throw new RuntimeException('The workbook could not be opened.');
    $load=static function(string $xml):array{$dom=new DOMDocument();$dom->loadXML($xml,LIBXML_NONET);return[$dom,new DOMXPath($dom)];};
    $shared=[];$xml=$zip->getFromName('xl/sharedStrings.xml');
    if($xml!==false){[$dom,$xp]=$load($xml);foreach($xp->query('//*[local-name()="si"]') as $si){$value='';foreach($xp->query('.//*[local-name()="t"]',$si) as $text)$value.=$text->textContent;$shared[]=trim($value);}}
    [$wb,$wbXp]=$load((string)$zip->getFromName('xl/workbook.xml'));[$relDoc,$relXp]=$load((string)$zip->getFromName('xl/_rels/workbook.xml.rels'));$targets=[];foreach($relXp->query('//*[local-name()="Relationship"]') as $rel)$targets[$rel->getAttribute('Id')]=$rel->getAttribute('Target');$sheet=$wbXp->query('//*[local-name()="sheet"]')->item(0);$relId=$sheet?->getAttributeNS('http://schemas.openxmlformats.org/officeDocument/2006/relationships','id');$target=$targets[$relId]??'worksheets/sheet1.xml';$target=str_starts_with($target,'xl/')?$target:'xl/'.$target;
    [$doc,$xp]=$load((string)$zip->getFromName($target));$rows=[];
    foreach($xp->query('//*[local-name()="sheetData"]/*[local-name()="row"]') as $row){$values=[];foreach($xp->query('./*[local-name()="c"]',$row) as $cell){$col=xlsx_cell_column($cell->getAttribute('r'));$type=$cell->getAttribute('t');$v=$xp->query('./*[local-name()="v"]',$cell)->item(0);$value=$v?->textContent??'';if($type==='s'&&$value!=='')$value=$shared[(int)$value]??'';elseif($type==='inlineStr'){$t=$xp->query('.//*[local-name()="t"]',$cell)->item(0);$value=$t?->textContent??'';}$values[$col]=trim($value);} $rows[(int)$row->getAttribute('r')]=$values;}
    $zip->close();return $rows;
}

function family_import_header_map(array $rows): array
{
    $top=$rows[1]??[];$sub=$rows[2]??[];$norm=static fn($v)=>preg_replace('/[^a-z0-9]+/',' ',strtolower(trim((string)$v)));
    $find=static function(array $row,string $needle)use($norm):?int{foreach($row as $i=>$v)if(str_contains($norm($v),$needle))return(int)$i;return null;};
    $aff=$find($top,'ip affiliation');$head=$find($top,'head of the family');$spouse=$find($top,'spouse name');$region=$find($top,'region');
    if(!$aff||!$head||!$spouse||!$region)throw new RuntimeException('Required LCE family headers were not found.');
    return ['serial'=>1,'affiliation'=>$aff,'head_last'=>$head,'head_first'=>$head+1,'head_middle'=>$head+2,'head_suffix'=>$head+3,'head_sex'=>$head+4,'head_birthdate'=>$head+5,'spouse_last'=>$spouse,'spouse_first'=>$spouse+1,'spouse_middle'=>$spouse+2,'spouse_suffix'=>$spouse+3,'spouse_sex'=>$spouse+4,'spouse_birthdate'=>$spouse+5,'region'=>$region,'province'=>$region+1,'municipality_city'=>$region+2,'barangay'=>$region+3,'sitio_street'=>$region+4,'contact_number'=>$region+5,'id_type'=>$region+6,'id_number'=>$region+7,'remarks'=>$region+8];
}

function normalize_import_date(?string $raw): array
{
    $raw=normalize_source_text($raw);if($raw===null)return[null,null];
    if(is_numeric($raw)&&(float)$raw>1000){$date=(new DateTimeImmutable('1899-12-30'))->modify('+'.(int)$raw.' days')->format('Y-m-d');return[$date,null];}
    foreach(['d/m/Y','m/d/Y','F j, Y','M j, Y'] as $format){$date=parse_source_date($raw,$format);if($date)return[$date,null];}
    return[null,'unrecognized date'];
}

function family_import_preview(mysqli $conn,string $path): array
{
    $rows=xlsx_read_rows($path);$map=family_import_header_map($rows);$affRows=$conn->query("SELECT id,name FROM ip_affiliations WHERE status='active'")->fetch_all(MYSQLI_ASSOC);$aff=[];foreach($affRows as $a)$aff[strtolower($a['name'])]=$a;
    $result=['total'=>0,'valid'=>0,'warning'=>0,'invalid'=>0,'with_spouse'=>0,'without_spouse'=>0,'duplicates'=>0,'affiliations'=>[],'issues'=>[],'rows'=>[]];
    foreach($rows as $number=>$cells){if($number<=2)continue;$get=static fn($key)=>isset($cells[$map[$key]])?(string)$cells[$map[$key]]:null;$headLast=normalize_source_text($get('head_last'));$headFirst=normalize_source_text($get('head_first'));if($headLast===null&&$headFirst===null&&normalize_source_text($get('serial'))===null)continue;$result['total']++;
        $rawAff=normalize_source_text($get('affiliation'));$affiliation=$rawAff?$aff[strtolower($rawAff)]??null:null;$issues=[];$fatal=[];if(!$headLast)$fatal[]='head last name missing';if(!$headFirst)$fatal[]='head first name missing';if(!$affiliation)$fatal[]=$rawAff?'unknown affiliation':'affiliation missing';
        [$headDob,$headDateIssue]=normalize_import_date($get('head_birthdate'));[$spouseDob,$spouseDateIssue]=normalize_import_date($get('spouse_birthdate'));if($headDateIssue)$issues[]='head birthdate: '.$headDateIssue;if($spouseDateIssue)$issues[]='spouse birthdate: '.$spouseDateIssue;
        $headSex=normalize_source_sex($get('head_sex'));if(normalize_source_text($get('head_sex'))&&!$headSex)$issues[]='head sex not recognized';$spouseSex=normalize_source_sex($get('spouse_sex'));if(normalize_source_text($get('spouse_sex'))&&!$spouseSex)$issues[]='spouse sex not recognized';
        $spouse=['last_name'=>normalize_source_text($get('spouse_last')),'first_name'=>normalize_source_text($get('spouse_first')),'middle_name'=>normalize_source_text($get('spouse_middle')),'suffix'=>normalize_source_suffix($get('spouse_suffix')),'sex'=>$spouseSex,'birthdate'=>$spouseDob];$hasSpouse=count(array_filter($spouse,fn($v)=>$v!==null))>0;if($hasSpouse)$result['with_spouse']++;else$result['without_spouse']++;
        $duplicate=false;if($headLast&&$headFirst&&$affiliation){$stmt=$conn->prepare("SELECT COUNT(*) FROM ip_families f JOIN ip_family_members m ON m.family_id=f.id AND m.member_role='head' WHERE f.affiliation_id=? AND LOWER(m.last_name)=LOWER(?) AND LOWER(m.first_name)=LOWER(?)");$stmt->bind_param('iss',$affiliation['id'],$headLast,$headFirst);$stmt->execute();$duplicate=(int)$stmt->get_result()->fetch_row()[0]>0;if($duplicate){$issues[]='probable existing family duplicate';$result['duplicates']++;}}
        $status=$fatal?'invalid':($issues?'warning':'valid');$result[$status]++;if($rawAff)$result['affiliations'][$rawAff]=($result['affiliations'][$rawAff]??0)+1;if($fatal||$issues)$result['issues'][]=['row'=>$number,'status'=>$status,'issues'=>array_merge($fatal,$issues)];
        $result['rows'][]=['source_reference'=>'ROW-'.$number,'status'=>$status,'affiliation_id'=>$affiliation['id']??null,'family'=>['region'=>normalize_source_text($get('region')),'province'=>normalize_source_text($get('province')),'municipality_city'=>normalize_source_text($get('municipality_city')),'barangay'=>normalize_source_text($get('barangay')),'house_number'=>null,'sitio_street'=>normalize_source_text($get('sitio_street')),'contact_number'=>normalize_source_text($get('contact_number')),'id_type'=>normalize_source_text($get('id_type')),'id_number'=>normalize_source_text($get('id_number')),'remarks'=>normalize_source_text($get('remarks'))],'head'=>['last_name'=>$headLast,'first_name'=>$headFirst,'middle_name'=>normalize_source_text($get('head_middle')),'suffix'=>normalize_source_suffix($get('head_suffix')),'sex'=>$headSex,'birthdate'=>$headDob],'spouse'=>$hasSpouse?$spouse:null];
    }
    ksort($result['affiliations']);return$result;
}

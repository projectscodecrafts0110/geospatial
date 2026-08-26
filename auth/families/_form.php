<?php $head = $head ?? []; $spouse = $spouse ?? []; ?>
<form method="post" action="../../processes/family_action.php">
    <input type="hidden" name="id" value="<?= (int)($family['id'] ?? 0) ?>">
    <div class="card-box mb-3">
        <div class="section-title">Registry Classification</div>
        <p class="text-muted small mb-3">Affiliation describes the family; operational ownership controls authorized access.</p>
        <div class="row g-3">
            <div class="col-md-6"><label class="form-label">IP Affiliation</label><select name="affiliation_id" class="form-select"><option value="">Not recorded</option><?php foreach ($affiliations as $a): ?><option value="<?= $a['id'] ?>" <?= ((int)($family['affiliation_id'] ?? 0) === (int)$a['id']) ? 'selected' : '' ?>><?= e($a['name']) ?></option><?php endforeach; ?></select></div>
            <div class="col-md-6"><label class="form-label">Operational Ownership <span class="text-danger">*</span></label><?php if ($scope !== null): ?><input class="form-control" value="<?= e($scope) ?>" readonly><input type="hidden" name="owning_tribe" value="<?= e($scope) ?>"><?php else: ?><select class="form-select" name="owning_tribe" required><option value="">Select ownership scope</option><?php foreach ($tribes as $tribe): ?><option <?= ($family['owning_tribe'] ?? '') === $tribe ? 'selected' : '' ?>><?= e($tribe) ?></option><?php endforeach; ?></select><?php endif; ?></div>
        </div>
    </div>
    <div class="card-box mb-3">
        <div class="section-title">Household Address</div>
        <div class="row g-3"><?php foreach (['region'=>'Region','province'=>'Province','municipality_city'=>'Municipality / City','barangay'=>'Barangay','house_number'=>'House No.','sitio_street'=>'Sitio / Street'] as $name => $label): ?><div class="col-md-4"><label class="form-label"><?= $label ?></label><input class="form-control" name="<?= $name ?>" value="<?= e($family[$name] ?? '') ?>"></div><?php endforeach; ?></div>
    </div>
    <div class="card-box mb-3">
        <div class="section-title">Contact and Identification <span class="badge text-bg-light ms-2">Optional</span></div>
        <div class="row g-3">
            <div class="col-md-4"><label class="form-label">Contact Number</label><input class="form-control" name="contact_number" value="<?= e($family['contact_number'] ?? '') ?>"></div>
            <?php foreach (['id_type'=>'ID Type','id_number'=>'ID Number'] as $name => $label): ?><div class="col-md-4"><label class="form-label"><?= $label ?></label><input class="form-control" name="<?= $name ?>" value="<?= e($family[$name] ?? '') ?>"></div><?php endforeach; ?>
            <div class="col-12"><label class="form-label">Remarks</label><textarea class="form-control" rows="3" name="remarks"><?= e($family['remarks'] ?? '') ?></textarea></div>
        </div>
    </div>
    <?php foreach (['head'=>['Head of Family',true,$head],'spouse'=>['Spouse',false,$spouse]] as $prefix => [$title,$required,$person]): ?>
    <div class="card-box mb-3">
        <div class="section-title"><?= $title ?><?php if (!$required): ?><span class="badge text-bg-light ms-2">Optional</span><?php endif; ?></div>
        <?php if (!$required): ?><p class="text-muted small mb-3">Leave all fields blank when no spouse information is available.</p><?php endif; ?>
        <div class="row g-3">
            <div class="col-md-3"><label class="form-label">Last Name<?= $required ? ' *' : '' ?></label><input class="form-control" name="<?= $prefix ?>_last_name" value="<?= e($person['last_name'] ?? '') ?>" <?= $required ? 'required' : '' ?>></div>
            <div class="col-md-3"><label class="form-label">First Name<?= $required ? ' *' : '' ?></label><input class="form-control" name="<?= $prefix ?>_first_name" value="<?= e($person['first_name'] ?? '') ?>" <?= $required ? 'required' : '' ?>></div>
            <div class="col-md-2"><label class="form-label">Middle Name</label><input class="form-control" name="<?= $prefix ?>_middle_name" value="<?= e($person['middle_name'] ?? '') ?>"></div>
            <div class="col-md-1"><label class="form-label">Suffix</label><input class="form-control" name="<?= $prefix ?>_suffix" value="<?= e($person['suffix'] ?? '') ?>"></div>
            <div class="col-md-1"><label class="form-label">Sex</label><select class="form-select" name="<?= $prefix ?>_sex"><option value="">—</option><?php foreach (['Male','Female','Other'] as $sex): ?><option <?= ($person['sex'] ?? '') === $sex ? 'selected' : '' ?>><?= $sex ?></option><?php endforeach; ?></select></div>
            <div class="col-md-2"><label class="form-label">Birthday</label><input type="date" class="form-control" name="<?= $prefix ?>_birthdate" value="<?= e($person['birthdate'] ?? '') ?>"></div>
        </div>
    </div>
    <?php endforeach; ?>
    <div class="form-actions d-flex justify-content-end gap-2"><a class="btn btn-light border" href="../families.php">Cancel</a><button class="btn btn-success" type="submit"><i class="bi bi-check2-circle me-1" aria-hidden="true"></i>Save Family Record</button></div>
</form>

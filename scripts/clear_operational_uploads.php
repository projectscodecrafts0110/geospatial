<?php
declare(strict_types=1);

$workspace = realpath(__DIR__ . '/..');
$target = realpath($workspace . DIRECTORY_SEPARATOR . 'uploads' . DIRECTORY_SEPARATOR . 'case_attachments');
$allowedRoot = realpath($workspace . DIRECTORY_SEPARATOR . 'uploads');
$backup = $workspace . DIRECTORY_SEPARATOR . 'database' . DIRECTORY_SEPARATOR . 'attachments_before_fresh_start_2026_08_21.zip';

if ($workspace === false || $target === false || $allowedRoot === false) {
    throw new RuntimeException('Required workspace upload directories were not found.');
}
if (!str_starts_with($target . DIRECTORY_SEPARATOR, $allowedRoot . DIRECTORY_SEPARATOR)) {
    throw new RuntimeException('Refusing to operate outside the workspace uploads directory.');
}
if (!is_file($backup) || filesize($backup) === 0) {
    throw new RuntimeException('Verified attachment archive is required before cleanup.');
}

$removed = 0;
foreach (new DirectoryIterator($target) as $entry) {
    if (!$entry->isFile()) continue;
    if (!unlink($entry->getPathname())) {
        throw new RuntimeException('Could not remove upload: ' . $entry->getFilename());
    }
    $removed++;
}

echo "Removed $removed archived operational upload files.\n";

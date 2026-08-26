<div class="row g-3 mb-3">
    <?php foreach ([
        ['Total', $totalCases, ''],
        ['Pending', $pendingCases, 'text-secondary'],
        ['Ongoing', $ongoingCases, 'text-primary'],
        ['Under Review', $reviewCases, 'text-warning'],
        ['Resolved', $resolvedCases, 'text-success'],
    ] as [$label, $value, $class]): ?>
        <div class="col-md">
            <div class="card-box">
                <small><?= e($label) ?></small>
                <h3 class="<?= e($class) ?>"><?= (int) $value ?></h3>
            </div>
        </div>
    <?php endforeach; ?>
</div>

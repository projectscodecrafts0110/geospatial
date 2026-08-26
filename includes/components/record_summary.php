<div class="row g-3 mb-3">
    <?php foreach ([
        ['Total Records', $total, ''],
        ['Approved', $approved, 'text-success'],
        ['For Assessment', $assessment, 'text-warning'],
        ['Pending Approval', $forApproval, 'text-primary'],
    ] as [$label, $value, $class]): ?>
        <div class="col-md-3">
            <div class="card-box">
                <small class="text-muted"><?= e($label) ?></small>
                <h3 class="<?= e($class) ?>"><?= (int) $value ?></h3>
            </div>
        </div>
    <?php endforeach; ?>
</div>

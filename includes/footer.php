</div> <!-- content-area -->
</div> <!-- main-wrapper -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function toggleSidebar() {

        const sidebar = document.querySelector('.sidebar');

        if (!sidebar) return;

        sidebar.classList.toggle('show');
    }
</script>
<script>
document.querySelectorAll('form[method="post" i]').forEach(function (form) {
    if (form.querySelector('input[name="csrf_token"]')) return;
    var input = document.createElement('input');
    input.type = 'hidden';
    input.name = 'csrf_token';
    input.value = document.querySelector('meta[name="csrf-token"]')?.content || '';
    form.appendChild(input);
});
document.querySelectorAll('table.table').forEach(function (table) {
    if (table.parentElement.classList.contains('table-responsive')) return;
    var wrapper = document.createElement('div');
    wrapper.className = 'table-responsive';
    table.parentNode.insertBefore(wrapper, table);
    wrapper.appendChild(table);
});
document.querySelectorAll('.sidebar a, .offcanvas-body a').forEach(function (link) {
    try {
        var current = window.location.pathname.replace(/\/$/, '');
        var target = new URL(link.href, window.location.origin).pathname.replace(/\/$/, '');
        if (current === target || (target.endsWith('/dashboard.php') && current === target)) {
            link.classList.add('active');
            link.setAttribute('aria-current', 'page');
        }
    } catch (error) {}
});

// Give both controlled-import workflows the same visible, accessible progression.
if (/\/import\.php$/.test(window.location.pathname)) {
    var heading = document.querySelector('.page-heading');
    var hasPreview = new URLSearchParams(window.location.search).has('preview');
    var isComplete = new URLSearchParams(window.location.search).has('completed');
    var activeStep = isComplete ? 5 : (hasPreview ? 4 : 1);
    if (heading && !document.querySelector('.import-steps')) {
        var labels = ['Upload', 'Preview', 'Validate', 'Confirm', 'Complete'];
        var progress = document.createElement('nav');
        progress.className = 'import-steps';
        progress.setAttribute('aria-label', 'Import progress');
        progress.innerHTML = labels.map(function (label, index) {
            var step = index + 1;
            var state = step < activeStep ? ' complete' : (step === activeStep ? ' active' : '');
            var marker = step < activeStep ? '<i class="bi bi-check" aria-hidden="true"></i>' : step;
            return '<div class="import-step' + state + '"' + (step === activeStep ? ' aria-current="step"' : '') + '><span>' + marker + '</span>' + label + '</div>';
        }).join('');
        heading.insertAdjacentElement('afterend', progress);
    }
}
</script>
</body>

</html>

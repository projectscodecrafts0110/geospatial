<?php if (($_SESSION['role'] ?? '') !== 'admin') return; ?>
<style>
    .right-panel {
        background: #fff;
        height: calc(100vh - 60px);
        overflow: hidden;
    }

    /* scroll only the stream */
    .audit-stream {
        max-height: calc(100vh - 160px);
        overflow-y: auto;
        padding-right: 5px;
    }

    /* MOBILE VIEW */
    @media (max-width: 768px) {
        .right-panel {
            height: auto;
            position: relative;
            margin-top: 15px;
        }

        .audit-stream {
            max-height: 400px;
            /* fixed scroll box for mobile */
        }
    }
</style>

<div class="right-panel p-3">

    <div class="d-flex align-items-center justify-content-between mb-2">
        <h6 class="mb-0">Live Activity</h6>
        <span class="badge bg-light text-dark">Realtime</span>
    </div>

    <hr>

    <div id="auditStream" class="audit-stream">
        <!-- AJAX loads here -->
    </div>

</div>

<script>
    async function loadAudit() {
        try {
            const res = await fetch('<?= BASE_URL ?>/processes/audit_fetch.php');
            const data = await res.json();

            let html = '';

            const escapeHTML = value => String(value ?? '').replace(/[&<>'"]/g, char => ({'&':'&amp;','<':'&lt;','>':'&gt;',"'":'&#39;','"':'&quot;'}[char]));
            data.forEach(log => {

                let color = '#22c55e';

                if (log.type === 'warning') color = '#f59e0b';
                if (log.type === 'info') color = '#3b82f6';
                if (log.type === 'danger') color = '#ef4444';

                html += `
                <div class="mb-4">

                    <div class="d-flex gap-2 align-items-start">

                        <div style="width:8px;height:8px;border-radius:50%;background:${color};margin-top:6px;"></div>

                        <div class="flex-grow-1">

                            <div class="d-flex justify-content-between">
                                <div class="small fw-semibold">${escapeHTML(log.action)}</div>
                                <small class="text-muted">${timeAgo(log.created_at)}</small>
                            </div>

                            <div class="small">
                                ${escapeHTML(log.description)}
                            </div>

                            <div class="small text-muted">
                                ${escapeHTML(log.role)} - <b>${escapeHTML(log.username)}</b>
                            </div>

                        </div>

                    </div>

                </div>
            `;
            });

            document.getElementById('auditStream').innerHTML = html;

        } catch (err) {
            console.error("Audit load failed", err);
        }
    }
</script>
<script>
    function timeAgo(dateString) {
        const date = new Date(dateString);
        const now = new Date();

        const diff = Math.floor((now - date) / 1000);

        if (diff < 60) return diff + "s ago";
        if (diff < 3600) return Math.floor(diff / 60) + "m ago";
        if (diff < 86400) return Math.floor(diff / 3600) + "h ago";

        return Math.floor(diff / 86400) + "d ago";
    }
</script>
<script>
    loadAudit();
    setInterval(loadAudit, 5000); // refresh every 5 seconds
</script>

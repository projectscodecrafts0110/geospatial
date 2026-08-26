<style>
    .toast {
        opacity: 0;
        transform: scale(0.88) translateY(10px);
        filter: blur(3px);
        transition: all 0.75s cubic-bezier(0.19, 1, 0.22, 1);
        position: relative;
        overflow: hidden;
    }

    .toast.show {
        opacity: 1;
        transform: scale(1) translateY(0);
        filter: blur(0);
    }

    /* progress bar */
    .toast::after {
        content: "";
        position: absolute;
        bottom: 0;
        left: 0;
        height: 3px;
        width: 100%;
        background: rgba(255, 255, 255, 0.4);
        transform-origin: left;
        animation: shrink 3s linear forwards;
    }

    @keyframes shrink {
        from {
            transform: scaleX(1);
        }

        to {
            transform: scaleX(0);
        }
    }
</style>


<div class="toast-container position-fixed bottom-0 end-0 p-3" style="z-index: 9999;">

    <?php if (isset($_GET['update']) && $_GET['update'] == 'success'): ?>
        <div class="toast text-bg-success border-0 show" role="alert">
            <div class="d-flex">
                <div class="toast-body">
                    Updated successfully.
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto"
                    data-bs-dismiss="toast"></button>
            </div>
        </div>
    <?php elseif (isset($_GET['update']) && $_GET['update'] == 'error'): ?>
        <div class="toast text-bg-danger border-0 show" role="alert">
            <div class="d-flex">
                <div class="toast-body">
                    Failed to update.
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto"
                    data-bs-dismiss="toast"></button>
            </div>
        </div>
    <?php endif; ?>


    <?php if (isset($_GET['delete']) && $_GET['delete'] == 'success'): ?>
        <div class="toast text-bg-warning border-0 show" role="alert">
            <div class="d-flex">
                <div class="toast-body">
                    User deactivated successfully.
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto"
                    data-bs-dismiss="toast"></button>
            </div>
        </div>
    <?php endif; ?>


    <?php if (isset($_GET['reset']) && $_GET['reset'] == 'success'): ?>
        <div class="toast text-bg-primary border-0 show" role="alert">
            <div class="d-flex">
                <div class="toast-body">
                    Password reset to default (123456).
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto"
                    data-bs-dismiss="toast"></button>
            </div>
        </div>
    <?php endif; ?>

</div>


<script>
    setTimeout(() => {
        document.querySelectorAll('.toast').forEach(t => {
            t.classList.remove('show');

            // fully remove after animation ends
            setTimeout(() => t.remove(), 500);
        });
    }, 3000);
</script>
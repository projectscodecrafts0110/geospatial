<?php
require '../../includes/header.php';
require '../../includes/role_guard.php';
requireRole(['admin','assessor']);
require '../../includes/db.php';

$result = mysqli_query($conn, "SELECT p.*,(SELECT COUNT(*) FROM tax_declarations t WHERE t.parcel_id=p.id) AS tax_declaration_count FROM ip_land_parcels p");
$parcels = [];

while ($row = mysqli_fetch_assoc($result)) {
    $parcels[] = $row;
}
$taxByParcel=[];$taxResult=$conn->query("SELECT t.id,t.parcel_id,t.td_number,t.declaration_status,t.boundary_north,t.boundary_south,t.boundary_east,t.boundary_west,t.owner_family_id,f.family_reference FROM tax_declarations t LEFT JOIN ip_families f ON f.id=t.owner_family_id WHERE t.parcel_id IS NOT NULL ORDER BY t.effectivity_year DESC,t.id DESC");while($td=$taxResult->fetch_assoc()){$taxByParcel[(int)$td['parcel_id']][]=$td;}
?>

<link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css">

<style>
    .gis-panel {
        width: 280px;
        height: calc(100vh - 72px);
        position: fixed;
        right: 0;
        top: 72px;
        background: #fff;
        border-left: 1px solid #e5e7eb;
        padding: 15px;
        overflow-y: auto;
        z-index: 1010;
        box-sizing: border-box;
    }

    .panel-header {
        display: flex;
        flex-direction: column;
        gap: 2px;
    }

    #map {
        height: 75vh;
        border-radius: 10px;
        width: 100%;
        min-width: 0;
    }

    .legend span {
        display: inline-block;
        width: 10px;
        height: 10px;
        margin-right: 6px;
        border-radius: 50%;
    }

    @media (min-width: 1200px) {
        body:has(.gis-panel) .content-area {
            padding-right: 280px !important;
            box-sizing: border-box;
        }

        body:has(.gis-panel) .main {
            width: 100%;
            min-width: 0;
            max-width: none;
            margin-right: 0 !important;
            box-sizing: border-box;
            overflow-x: hidden;
        }
    }

    @media (max-width: 1199px) {

        #map {
            height: 60vh;
        }

        .gis-panel {
            position: static !important;
            width: 100% !important;
            height: auto !important;

            margin-top: 15px;
            margin-bottom: 30px;

            border-left: none;
            border-top: 1px solid #e5e7eb;

            border-radius: 10px;
            background: #fff;
            overflow: visible;
        }
    }
</style>

<div class="main">

    <div class="workspace-header">
        <div>
            <div class="eyebrow">Parcel Map</div><h1>Geospatial Evidence</h1>
            <p>Authoritative parcel geometry with linked Tax Declarations, family ownership references, and textual assessor boundaries.</p>
        </div>
    </div>

    <!-- LEGEND -->
    <div class="card-box mb-3 legend d-flex gap-3 flex-wrap">

        <div><span style="background:#22c55e"></span> Verified</div>
        <div><span style="background:#f59e0b"></span> Claimed</div>
        <div><span style="background:#ef4444"></span> Disputed</div>
        <div><span style="background:#6b7280"></span> Government</div>

    </div>

    <!-- MAP -->
    <div id="map"></div>
</div>
<div class="gis-panel">

    <div class="panel-header">
        <h6 class="mb-0">Parcel Details</h6>
        <small class="text-muted">Click a land parcel</small>
    </div>

    <hr>

    <div id="parcelDetails" class="small text-muted">
        No parcel selected
    </div>
</div>

<div class="modal fade" id="editParcelModal" tabindex="-1">
    <div class="modal-dialog">
        <form method="POST" action="../../processes/parcel_update.php" class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title">Edit Parcel</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">

                <input type="hidden" name="id" id="edit_id">

                <div class="mb-2">
                    <label>Land Name</label>
                    <input type="text" name="land_name" id="edit_name" class="form-control">
                </div>

                <div class="mb-2">
                    <label>Owner</label>
                    <input type="text" name="owner_name" id="edit_owner" class="form-control">
                </div>

                <div class="mb-2">
                    <label>Status</label>
                    <select name="status" id="edit_status" class="form-select">
                        <option value="claimed">Claimed</option>
                        <option value="verified">Verified</option>
                        <option value="disputed">Disputed</option>
                        <option value="government_owned">Government Owned</option>
                    </select>
                </div>

                <div class="mb-2">
                    <label>Reason for Edit</label>
                    <textarea name="reason" class="form-control" required></textarea>
                </div>

            </div>

            <div class="modal-footer">
                <button class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button class="btn btn-success">Save Changes</button>
            </div>

        </form>
    </div>
</div>


<script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
<script src="https://unpkg.com/leaflet.markercluster/dist/leaflet.markercluster.js"></script>
<script>
    var map = L.map('map').setView([18.4613108, 120.9035710], 14);

    /* =========================
       CADASTRAL BASEMAP
    ========================= */
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '&copy; OpenStreetMap contributors',
        maxZoom: 19
    }).addTo(map);

    /* =========================
       CLUSTER GROUP
    ========================= */
    var markers = L.markerClusterGroup({
        spiderfyOnMaxZoom: true,
        showCoverageOnHover: false,
        zoomToBoundsOnClick: true
    });

    /* =========================
       GLOBAL STATE
    ========================= */
    let selectedParcel = null;
    const initialParcelId = <?= (int)($_GET['parcel_id']??0) ?>;

    /* =========================
       COLOR FUNCTION
    ========================= */
    function getColor(status) {
        switch (status) {
            case 'verified':
                return '#22c55e';
            case 'claimed':
                return '#f59e0b';
            case 'disputed':
                return '#ef4444';
            case 'government_owned':
                return '#6b7280';
            default:
                return '#3b82f6';
        }
    }

    /* =========================
       RIGHT PANEL
    ========================= */
    function updateParcelPanel(data) {
        selectedParcel = data;

        document.getElementById('parcelDetails').innerHTML = `
        <div class="mb-2">
            <h6 class="mb-1">${data.name}</h6>
            <small class="text-muted">${data.location}</small>
        </div>

        <hr>

        <div><b>Owner:</b> ${data.owner}</div>
        <div><b>Type:</b> ${data.type}</div>
        <div><b>Status:</b> ${data.status}</div>
        <div><b>Tax Declarations:</b> ${data.taxDeclarations}</div>
        ${data.declarations.length ? `<div class="mt-2"><b>Recorded boundary references</b>${data.declarations.map(td => `<div class="border rounded p-2 mt-1"><a href="../tax_declarations/view.php?id=${td.id}">${escapeHtml(td.number)}</a> <small>(${escapeHtml(td.status)})</small>${td.family?`<div><span class="relationship-chip"><i class="bi bi-people-fill"></i>${escapeHtml(td.family)}</span></div>`:''}<div class="text-muted mt-1">N: ${escapeHtml(td.north || '—')} · S: ${escapeHtml(td.south || '—')} · E: ${escapeHtml(td.east || '—')} · W: ${escapeHtml(td.west || '—')}</div></div>`).join('')}</div>` : ''}
        <a class="btn btn-sm btn-outline-success w-100 mt-2" href="../tax_declarations.php?parcel_id=${data.id}">View Related Declarations</a>

        <hr>

        <?php if(($_SESSION['role']??'')==='admin'):?><button class="btn btn-sm btn-primary w-100 mt-2" onclick="openEditModal()">
            <i class="bi bi-pencil"></i> Edit Parcel
        </button><?php endif;?>
    `;
    }

    /* =========================
       EDIT MODAL
    ========================= */
    function openEditModal() {
        if (!selectedParcel) return;

        document.getElementById('edit_id').value = selectedParcel.id;
        document.getElementById('edit_name').value = selectedParcel.name;
        document.getElementById('edit_owner').value = selectedParcel.owner;
        document.getElementById('edit_status').value = selectedParcel.status;

        new bootstrap.Modal(document.getElementById('editParcelModal')).show();
    }

    function escapeHtml(value) { const d=document.createElement('div'); d.textContent=String(value??''); return d.innerHTML; }

    /* =========================
       LOAD PARCELS (SAFE SCOPE)
    ========================= */

    <?php foreach ($parcels as $p): ?>
            (function() {

                var parcel = {
                    id: <?= (int)$p['id'] ?>,
                    name: <?= json_encode($p['land_name']) ?>,
                    owner: <?= json_encode($p['owner_name']) ?>,
                    type: <?= json_encode($p['owner_type']) ?>,
                    status: <?= json_encode($p['ownership_status']) ?>,
                    location: <?= json_encode($p['barangay'] . ', ' . $p['municipality']) ?>,
                    taxDeclarations: <?= (int)$p['tax_declaration_count'] ?>,
                    declarations: <?= json_encode(array_map(static fn($td)=>['id'=>(int)$td['id'],'number'=>$td['td_number'],'status'=>$td['declaration_status'],'family'=>$td['family_reference'],'north'=>$td['boundary_north'],'south'=>$td['boundary_south'],'east'=>$td['boundary_east'],'west'=>$td['boundary_west']],$taxByParcel[(int)$p['id']]??[]),JSON_HEX_TAG|JSON_HEX_AMP|JSON_HEX_APOS|JSON_HEX_QUOT) ?>,
                    boundary: <?= $p['boundary_geojson'] ? json_encode(json_decode($p['boundary_geojson'])) : 'null' ?>
                };

                var layer;

                /* =========================
                   CADASTRAL RENDER
                ========================= */
                if (parcel.boundary) {

                    layer = L.geoJSON(parcel.boundary, {
                        style: {
                            color: getColor(parcel.status),
                            weight: 2,
                            fillColor: getColor(parcel.status),
                            fillOpacity: 0.25
                        }
                    });

                } else if (<?= $p['latitude'] !== null && $p['longitude'] !== null ? 'true' : 'false' ?>) {

                    layer = L.circleMarker(
                        [<?= $p['latitude'] ?>, <?= $p['longitude'] ?>], {
                            radius: 8,
                            color: getColor(parcel.status),
                            fillColor: getColor(parcel.status),
                            fillOpacity: 0.9
                        }
                    );

                } else { return; }

                /* =========================
                   ATTACH DATA
                ========================= */
                layer.parcelData = parcel;

                /* =========================
                   POPUP
                ========================= */
                layer.bindPopup(`
        <b>${parcel.name}</b><br>
        <small>${parcel.owner}</small>
        <hr>
        <b>Status:</b> ${parcel.status}<br>
        <b>Location:</b> ${parcel.location}
    `);

                /* =========================
                   CLICK EVENT
                ========================= */
                layer.on('click', function() {
                    updateParcelPanel(this.parcelData);
                });

                markers.addLayer(layer);
                if (parcel.id === initialParcelId) { updateParcelPanel(parcel); setTimeout(() => { if(layer.getBounds) map.fitBounds(layer.getBounds(),{maxZoom:18}); else map.setView(layer.getLatLng(),18); layer.openPopup(); }, 250); }

            })();
    <?php endforeach; ?>

    map.addLayer(markers);

    /* =========================
       CLUSTER CLICK VIEW
    ========================= */
    markers.on('clusterclick', function(a) {

        let items = [];

        a.layer.getAllChildMarkers().forEach(function(m) {

            let d = m.parcelData;

            items.push(`
            <div style="padding:8px 0;border-bottom:1px solid #eee;cursor:pointer"
                onclick='updateParcelPanel(${JSON.stringify(d)})'>

                <b>${d.name}</b><br>
                <small>${d.owner}</small><br>
                <small>Status: ${d.status}</small>

            </div>
        `);

        });

        L.popup()
            .setLatLng(a.latlng)
            .setContent(`
            <div style="max-height:250px;overflow:auto;width:260px">
                <h6 class="mb-2">Parcels in Cluster</h6>
                ${items.join('')}
            </div>
        `)
            .openOn(map);
    });
</script>

<?php include '../../includes/toast.php'; ?>
<?php require '../../includes/footer.php'; ?>

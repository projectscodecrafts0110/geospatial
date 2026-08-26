<?php
require_once __DIR__ . '/includes/security.php';
require_once __DIR__ . '/includes/db.php';
$publicSettings = system_settings($conn);
?>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Official Indigenous Peoples Rights Monitoring and Geospatial Information System of the Municipality of Adams, Ilocos Norte.">
    <title>IP Rights Monitoring System | LGU Adams</title>
    <link rel="icon" href="<?= e($publicSettings['logo_path']) ?>">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css">
    <link rel="stylesheet" href="assets/css/public.css?v=20260821">
</head>
<body>
<a class="skip-link" href="#main-content">Skip to main content</a>
<div class="gov-strip py-2"><div class="container d-flex justify-content-between gap-3"><span>Republic of the Philippines</span><span class="d-none d-sm-inline">Municipality of Adams, Ilocos Norte</span></div></div>
<nav class="navbar navbar-expand-lg public-nav sticky-top" aria-label="Public navigation">
    <div class="container py-2">
        <a class="navbar-brand d-flex align-items-center gap-3 me-4" href="index.php"><img class="brand-logo" src="<?= e($publicSettings['logo_path']) ?>" alt="LGU Adams seal"><span><span class="brand-kicker d-block">Local Government Unit of Adams</span><span class="brand-title d-block">IP Rights Monitoring System</span></span></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#publicNav" aria-controls="publicNav" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="publicNav"><div class="navbar-nav ms-auto align-items-lg-center gap-lg-2"><a class="nav-link" href="#services">System Services</a><a class="nav-link" href="#coverage">Coverage</a><a class="nav-link" href="#mandate">Mandate</a><a class="btn btn-civic ms-lg-2" href="login.php"><i class="bi bi-shield-lock me-2"></i>Authorized Login</a></div></div>
    </div>
</nav>
<main id="main-content">
    <section class="hero"><div class="container py-5">
        <div class="hero-eyebrow"><i class="bi bi-building"></i> Digital public service platform</div>
        <h1>Protecting Indigenous Peoples' rights through better information.</h1>
        <p class="lead">A secure, location-aware monitoring platform that helps the LGU document community records, coordinate case action, and support evidence-based decisions.</p>
        <div class="d-flex flex-wrap gap-3 mt-4 mb-5"><a class="btn btn-civic btn-lg" href="login.php"><i class="bi bi-box-arrow-in-right me-2"></i>Enter Secure Portal</a><a class="btn btn-civic-outline btn-lg" href="#services">Learn About the System</a></div>
        <div class="trust-row" aria-label="System principles"><span><i class="bi bi-check-circle-fill"></i>Role-based access</span><span><i class="bi bi-check-circle-fill"></i>Accountable case tracking</span><span><i class="bi bi-check-circle-fill"></i>Geospatial decision support</span></div>
    </div></section>
    <section class="section-shell" id="services"><div class="container">
        <div class="section-kicker">System services</div><h2 class="section-heading">One coordinated workspace for responsible public service.</h2><p class="section-copy mb-4">Designed for authorized LGU personnel and Indigenous Peoples representatives, the system brings essential monitoring workflows into a secure and traceable environment.</p>
        <div class="row g-3 mt-2">
            <div class="col-md-6 col-xl-3"><article class="service-card"><div class="service-icon"><i class="bi bi-person-vcard"></i></div><h3>IP Registry</h3><p>Maintain organized community records with clear review and approval workflows.</p></article></div>
            <div class="col-md-6 col-xl-3"><article class="service-card"><div class="service-icon"><i class="bi bi-folder-check"></i></div><h3>Case Monitoring</h3><p>Document concerns, involved persons, supporting files, assignments, and resolution progress.</p></article></div>
            <div class="col-md-6 col-xl-3"><article class="service-card"><div class="service-icon"><i class="bi bi-map"></i></div><h3>Geospatial Information</h3><p>View authorized land and location information to support planning and field coordination.</p></article></div>
            <div class="col-md-6 col-xl-3"><article class="service-card"><div class="service-icon"><i class="bi bi-journal-check"></i></div><h3>Accountability</h3><p>Support transparent operations through role controls, status history, and audit records.</p></article></div>
        </div>
    </div></section>
    <section class="section-shell pt-0" id="coverage"><div class="container"><div class="row g-4 align-items-stretch">
        <div class="col-lg-8"><div class="map-frame"><div id="publicMap" aria-label="Map showing the Municipality of Adams, Ilocos Norte"></div></div></div>
        <div class="col-lg-4"><div class="coverage-panel"><div class="section-kicker text-warning">Service coverage</div><h2 class="h3 fw-bold mt-2">Municipality of Adams</h2><p class="opacity-75">The public map indicates the municipal service area only. Protected registry, case, and parcel details remain inside the authorized portal.</p><div class="coverage-item"><small>Province</small><strong>Ilocos Norte</strong></div><div class="coverage-item"><small>Primary focus</small><strong>IP rights, records, cases, and land concerns</strong></div><div class="coverage-item"><small>Data protection</small><strong>Operational details are not publicly displayed</strong></div></div></div>
    </div></div></section>
    <section class="section-shell mandate" id="mandate"><div class="container"><div class="mandate-card"><div class="section-kicker">Public service mandate</div><h2 class="section-heading">Supporting rights-based and accountable local governance.</h2><p class="section-copy mb-0">The platform supports the Municipality of Adams in documenting, monitoring, and responding to matters affecting Indigenous Cultural Communities and Indigenous Peoples. It complements the principles of Republic Act No. 8371, or the Indigenous Peoples' Rights Act of 1997, by helping authorized personnel manage information consistently, protect sensitive records, and make informed decisions. The system is an administrative support tool and does not replace legally required consultation, validation, or due process.</p></div></div></section>
    <section class="access-cta"><div class="container d-lg-flex justify-content-between align-items-center gap-4 text-center text-lg-start"><div><div class="section-kicker text-warning">Authorized personnel</div><h2 class="h3 fw-bold mt-2 mb-2">Access the secure monitoring portal</h2><p class="mb-0 text-white-50">A valid LGU-issued account is required. System activity is protected and auditable.</p></div><a class="btn btn-light btn-lg fw-bold text-success mt-4 mt-lg-0" href="login.php">Proceed to Login <i class="bi bi-arrow-right ms-2"></i></a></div></section>
</main>
<footer class="public-footer"><div class="container d-md-flex justify-content-between align-items-center gap-3 text-center text-md-start"><span>© 2026 Local Government Unit of Adams, Ilocos Norte</span><span>Indigenous Peoples Rights Monitoring System</span></div></footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script><script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
<script>const publicMap=L.map('publicMap',{scrollWheelZoom:false}).setView([18.461,120.94],12);L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',{attribution:'&copy; OpenStreetMap contributors'}).addTo(publicMap);L.circle([18.461,120.94],{color:'#1f6840',fillColor:'#287e4e',fillOpacity:.13,weight:2,radius:4500}).addTo(publicMap).bindPopup('<strong>Municipality of Adams</strong><br>LGU service coverage area');</script>
</body></html>

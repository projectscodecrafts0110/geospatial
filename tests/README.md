# Test Suite

`npm test` recreates only `geo_case_test`, applies the Phase 1 foundation migration, runs focused transactional schema tests, seeds five role accounts, starts PHP's local server with test-only database environment variables, and runs Playwright against installed Chrome.

The setup script refuses to recreate a database whose name does not end in `_test`.

Test credentials exist only in the disposable database and must never be copied into production.

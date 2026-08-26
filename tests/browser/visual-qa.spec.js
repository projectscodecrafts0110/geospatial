const { test, expect } = require('@playwright/test');

const password = 'TestPassword!123';
const pages = [
  ['overview', 'auth/admin/dashboard.php'],
  ['people-registry', 'auth/admin/records.php'],
  ['families', 'auth/families.php'],
  ['family-form', 'auth/families/create.php'],
  ['cases', 'auth/admin/cases.php'],
  ['case-form', 'auth/admin/cases/create.php'],
  ['tax-declarations', 'auth/tax_declarations.php'],
  ['tax-form', 'auth/tax_declarations/create.php'],
  ['parcel-map', 'auth/admin/gis.php'],
  ['users', 'auth/admin/users.php'],
  ['audit-log', 'auth/admin/logs.php'],
  ['reports', 'auth/admin/reports.php'],
  ['settings', 'auth/admin/settings.php'],
  ['family-import', 'auth/families/import.php'],
  ['case-import', 'auth/admin/cases/import.php'],
];

test('institutional UI remains usable across reference viewports', async ({ page }) => {
  test.setTimeout(120000);
  await page.goto('login.php');
  await page.getByPlaceholder('Username').fill('admin_test');
  await page.getByPlaceholder('Password').fill(password);
  await page.getByRole('button', { name: 'Access System' }).click();

  for (const viewport of [
    { name: 'desktop', width: 1440, height: 1000 },
    { name: 'tablet', width: 768, height: 1024 },
    { name: 'mobile', width: 390, height: 844 },
  ]) {
    await page.setViewportSize({ width: viewport.width, height: viewport.height });
    for (const [name, route] of pages) {
      await page.goto(route, { waitUntil: 'domcontentloaded' });
      await expect(page.locator('body')).not.toContainText('Fatal error');
      const overflow = await page.evaluate(() => document.documentElement.scrollWidth - document.documentElement.clientWidth);
      expect(overflow, `${name} overflows ${viewport.name} by ${overflow}px`).toBeLessThanOrEqual(2);
      await page.screenshot({ path: `test-results/visual-qa/${viewport.name}-${name}.png`, fullPage: true });
    }
  }
});

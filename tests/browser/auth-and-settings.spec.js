const { test, expect } = require('@playwright/test');

const password = 'TestPassword!123';
const roles = [
  ['admin_test', '/auth/admin/dashboard.php'],
  ['leader_test', '/auth/tribe_leader/dashboard.php'],
  ['rep_test', '/auth/tribe_rep/dashboard.php'],
  ['assessor_test', '/auth/admin/cases.php'],
  ['staff_test', '/auth/admin/records.php'],
];

async function login(page, username) {
  await page.goto('login.php');
  await page.getByPlaceholder('Username').fill(username);
  await page.getByPlaceholder('Password').fill(password);
  await page.getByRole('button', { name: 'Access System' }).click();
}

test.beforeEach(async ({ page }) => {
  page.failedResources = [];
  page.on('response', response => { if (response.status() >= 400) page.failedResources.push(`${response.status()} ${response.url()}`); });
});

test.afterEach(async ({ page }) => {
  expect(page.failedResources, `Failed browser resources:\n${page.failedResources.join('\n')}`).toEqual([]);
});

for (const [username, destination] of roles) {
  test(`${username} authenticates and reaches its authorized landing page`, async ({ page }) => {
    await login(page, username);
    await expect(page).toHaveURL(new RegExp(destination.replaceAll('/', '\\/')));
    await expect(page.locator('body')).not.toContainText('Access denied');
  });
}

test('admin can update theme settings and upload a validated logo', async ({ page }) => {
  await login(page, 'admin_test');
  await page.goto('auth/admin/settings.php');
  await expect(page.getByRole('heading', { name: 'System Settings' })).toBeVisible();
  await page.locator('#theme_primary').fill('#2457A7');
  await page.locator('#theme_sidebar').fill('#172A46');
  await page.locator('#theme_accent').fill('#26734D');
  await page.locator('#systemLogo').setInputFiles('assets/images/logo.png');
  await page.getByRole('button', { name: 'Save Settings' }).click();
  await expect(page).toHaveURL(/update=success/);
  await expect(page.getByText('System settings were updated.')).toBeVisible();
  const primary = await page.evaluate(() => getComputedStyle(document.documentElement).getPropertyValue('--theme-primary').trim());
  expect(primary).toBe('#2457A7');
});

test('global search returns authorized records, cases, and users', async ({ page }) => {
  await login(page, 'admin_test');
  await page.goto('auth/search.php?q=Test');
  await expect(page.getByText('Test Person')).toBeVisible();
  await expect(page.getByText('Test Case', { exact: true })).toBeVisible();
  await expect(page.getByText('Admin Test')).toBeVisible();
});

test('admin can create and search a family with an optional spouse', async ({ page }) => {
  await login(page, 'admin_test');
  await page.goto('auth/families/create.php');
  await page.locator('[name="owning_tribe"]').selectOption({ label: 'Test Tribe' });
  await page.locator('[name="affiliation_id"]').selectOption({ label: 'Yapayao' });
  await page.locator('[name="head_last_name"]').fill('Browserfamily');
  await page.locator('[name="head_first_name"]').fill('Fictional');
  await page.getByRole('button', { name: 'Save Family Record' }).click();
  await expect(page.getByText('Family record saved successfully.')).toBeVisible();
  await page.goto('auth/families.php?q=Browserfamily');
  await expect(page.getByText('Fictional Browserfamily')).toBeVisible();
});

test('family list and global search preserve tribe isolation', async ({ page }) => {
  await login(page, 'leader_test');
  await page.goto('auth/families.php?q=Hidden');
  await expect(page.getByRole('heading', { name: 'No family records found' })).toBeVisible();
  await page.goto('auth/search.php?q=Hidden');
  await expect(page.locator('body')).not.toContainText('Hidden Private');
  await page.goto('auth/families.php?q=Dalisay');
  await expect(page.getByText('Amihan Dalisay')).toBeVisible();
});

test('admin previews and confirms the LCE workbook only in the disposable test database', async ({ page }) => {
  await login(page, 'admin_test');
  await page.goto('auth/families/import.php');
  await page.locator('[name="owning_tribe"]').selectOption({ label: 'Test Tribe' });
  await page.locator('[name="workbook"]').setInputFiles("ADAMS IP'S.xlsx");
  await page.getByRole('button', { name: 'Generate Private Preview' }).click();
  await expect(page.getByText('Ready for explicit confirmation')).toBeVisible();
  await expect(page.getByText('424', { exact: true }).first()).toBeVisible();
  await page.getByRole('button', { name: 'Confirm Transactional Import' }).click();
  await expect(page.getByText(/Import batch #\d+ completed/)).toBeVisible();
});

test('admin creates a case with extended participant fields', async ({ page }) => {
  await login(page, 'admin_test');
  await page.goto('auth/admin/cases/create.php');
  await page.locator('[name="applicant_fullname"]').fill('Fictional Case Owner');
  await page.locator('[name="applicant_ip_group"]').fill('Test Tribe');
  await page.locator('[name="applicant_affiliation_id"]').selectOption({ label: 'Yapayao' });
  await page.locator('[name="case_title"]').fill('Browser Participant Case');
  await page.locator('[name="case_type"]').selectOption('environmental_issue');
  await page.locator('[name="person_name[]"]').first().fill('Searchable Participant');
  await page.locator('[name="person_role[]"]').first().selectOption({ label: 'Witness' });
  await page.locator('[name="person_affiliation_id[]"]').first().selectOption({ label: 'Yapayao' });
  await page.getByRole('button', { name: 'Submit Case' }).click();
  await page.goto('auth/admin/cases.php?q=Searchable+Participant');
  await expect(page.getByText('Browser Participant Case')).toBeVisible();
});

test('admin previews and confirms LCE cases only in the disposable test database', async ({ page }) => {
  await login(page, 'admin_test');
  await page.goto('auth/admin/cases/import.php');
  await page.locator('[name="owning_tribe"]').selectOption({ label: 'Test Tribe' });
  await page.locator('[name="case_document"]').setInputFiles('BRGY ADAMS CASES.docx');
  await page.getByRole('button', { name: 'Generate Case Preview' }).click();
  await expect(page.getByText('Explicit confirmation required')).toBeVisible();
  await page.getByRole('button', { name: 'Confirm Transactional Case Import' }).click();
  await expect(page.getByText(/Case import batch #\d+ completed/)).toBeVisible();
});

test('server-side record filters search the full dataset and show an empty state', async ({ page }) => {
  await login(page, 'admin_test');
  await page.goto('auth/admin/records.php?q=does-not-exist');
  await expect(page.getByRole('heading', { name: 'No records found' })).toBeVisible();
  await page.goto('auth/admin/records.php?q=Test+Person');
  await expect(page.getByText('Test Person')).toBeVisible();
});

test('assessor-routed case remains visible to its tribe', async ({ page }) => {
  await login(page, 'leader_test');
  await page.goto('auth/tribe_leader/cases.php');
  await expect(page.getByText('Assessor-routed Land Case')).toBeVisible();
});

test('tribe search and filters do not expose another tribe', async ({ page }) => {
  await login(page, 'leader_test');
  await page.goto('auth/search.php?q=Hidden');
  await expect(page.getByText('Hidden Other Person')).toHaveCount(0);
  await expect(page.getByText('Hidden Other Case')).toHaveCount(0);
  await page.goto('auth/tribe_leader/cases.php?type=land_dispute');
  await expect(page.getByText('Assessor-routed Land Case')).toBeVisible();
  await expect(page.getByText('Test Case', { exact: true })).toHaveCount(0);
});

test('user can update own profile', async ({ page }) => {
  await login(page, 'rep_test');
  await page.goto('auth/profile.php');
  await page.locator('#profileContact').fill('09171234567');
  await page.getByRole('button', { name: 'Save Profile' }).click();
  await expect(page.getByText('Profile details updated.')).toBeVisible();
  await expect(page.locator('#profileContact')).toHaveValue('09171234567');
});

for (const viewport of [{ width: 390, height: 844 }, { width: 768, height: 1024 }, { width: 1440, height: 900 }]) {
  test(`admin dashboard has no horizontal overflow at ${viewport.width}px`, async ({ page }) => {
    await page.setViewportSize(viewport);
    await login(page, 'admin_test');
    const overflow = await page.evaluate(() => document.documentElement.scrollWidth > document.documentElement.clientWidth);
    expect(overflow).toBe(false);
  });
}

test('record and case tables remain readable without horizontal page overflow on mobile', async ({ page }) => {
  await page.setViewportSize({ width: 390, height: 844 });
  await login(page, 'admin_test');
  for (const path of ['auth/admin/records.php', 'auth/admin/cases.php', 'auth/admin/users.php']) {
    await page.goto(path);
    expect(await page.evaluate(() => document.documentElement.scrollWidth <= document.documentElement.clientWidth)).toBe(true);
  }
});

test('user can change password and authenticate with the replacement', async ({ page }) => {
  await login(page, 'staff_test');
  await page.goto('auth/profile.php');
  await page.locator('#currentPassword').fill(password);
  await page.locator('#newPassword').fill('Replacement!456');
  await page.locator('#confirmPassword').fill('Replacement!456');
  await page.getByRole('button', { name: 'Change Password' }).click();
  await expect(page.getByText('Password changed successfully.')).toBeVisible();
  await page.context().clearCookies();
  await page.goto('login.php');
  await page.getByPlaceholder('Username').fill('staff_test');
  await page.getByPlaceholder('Password').fill('Replacement!456');
  await page.getByRole('button', { name: 'Access System' }).click();
  await expect(page).toHaveURL(/auth\/admin\/records\.php/);
});

test('admin creates and searches a tax declaration with multiple assessment rows', async ({ page }) => {
  await login(page, 'admin_test');
  await page.goto('auth/tax_declarations/create.php');
  await page.locator('[name="td_number"]').fill('ANON-BROWSER-TD-001');
  await page.locator('[name="owner_name"]').fill('Fictional Browser Owner');
  await page.locator('[name="owning_tribe"]').selectOption({ label: 'Test Tribe' });
  await page.locator('[name="property_type_id"]').selectOption({ label: 'Land' });
  await page.locator('[name="tax_status"]').selectOption('taxable');
  await page.locator('[name="assessment_classification[]"]').first().fill('Agricultural');
  await page.getByRole('button', { name: 'Add Row' }).click();
  await page.locator('[name="assessment_classification[]"]').nth(1).fill('Residential');
  await page.getByRole('button', { name: 'Save Tax Declaration' }).click();
  await expect(page.getByRole('heading', { name: 'ANON-BROWSER-TD-001' })).toBeVisible();
  await expect(page.getByText('Agricultural')).toBeVisible();
  await expect(page.getByText('Residential')).toBeVisible();
  await page.goto('auth/tax_declarations.php?q=Fictional+Browser+Owner');
  await expect(page.locator('strong').getByText('ANON-BROWSER-TD-001', { exact: true })).toBeVisible();
  await page.goto('auth/search.php?q=ANON-BROWSER-TD-001');
  await expect(page.getByRole('heading', { name: 'Tax Declarations' })).toBeVisible();
  await expect(page.getByRole('link', { name: /ANON-BROWSER-TD-001/ })).toBeVisible();
});

test('tribe tax declaration access denies another operational scope', async ({ page }) => {
  await login(page, 'leader_test');
  await page.goto('auth/tax_declarations.php?q=ANON-TD-NULL-001');
  await expect(page.getByRole('heading', { name: 'No Tax Declarations found' })).toBeVisible();
  await page.goto('auth/tax_declarations.php?q=ANON-TD-CURRENT-001');
  await expect(page.getByText('ANON-TD-CURRENT-001')).toBeVisible();
});

test('assessor sees only the assigned technical case queue and tax evidence', async ({ page }) => {
  await login(page, 'assessor_test');
  await page.goto('auth/admin/cases.php');
  await expect(page.getByText('Assessor-routed Land Case')).toBeVisible();
  await expect(page.getByText('Test Case', { exact: true })).toHaveCount(0);
  await page.goto('auth/tax_declarations.php?q=ANON-TD-CURRENT-001');
  await expect(page.getByText('ANON-TD-CURRENT-001')).toBeVisible();
  await page.getByRole('link', { name: 'View' }).click();
  await expect(page.getByText('Textual Boundary References')).toBeVisible();
  await expect(page.getByRole('link', { name: 'Edit' })).toHaveCount(0);
});

test('mobile navigation exposes the complete representative workspace', async ({ page }) => {
  await page.setViewportSize({ width: 390, height: 844 });
  await login(page, 'rep_test');
  await page.locator('[data-bs-target="#mobileSidebar"]').click();
  await expect(page.locator('#mobileSidebar').getByText('Families', { exact: true })).toBeVisible();
  await expect(page.locator('#mobileSidebar').getByText('Case Intake', { exact: true })).toBeVisible();
  await expect(page.locator('#mobileSidebar').getByText('Tax Declarations', { exact: true })).toBeVisible();
});

test('connected administrative workspace exposes family context across modules', async ({ page }) => {
  await login(page, 'admin_test');
  await expect(page.getByText('Registered Families')).toBeVisible();
  await expect(page.getByText('Case workflow')).toBeVisible();
  await page.goto('auth/admin/records.php');
  await expect(page.getByRole('columnheader', { name: 'Family Connection' })).toBeVisible();
  await page.goto('auth/admin/cases.php');
  await expect(page.getByRole('columnheader', { name: 'Connections' })).toBeVisible();
  await page.goto('auth/admin/reports.php');
  await expect(page.locator('.metric-label').getByText('IP Families', { exact: true })).toBeVisible();
  await expect(page.getByText('Cases Linked to Families')).toBeVisible();
  await page.goto('auth/admin/logs.php');
  await expect(page.locator('[name="module"]')).toBeVisible();
  await page.goto('auth/admin/users.php');
  await expect(page.getByText(/families/).first()).toBeVisible();
});

for (const viewport of [{ width: 390, height: 844 }, { width: 768, height: 1024 }, { width: 1440, height: 900 }]) {
  test(`Phase 1-4 workflows remain responsive at ${viewport.width}px`, async ({ page }) => {
    await page.setViewportSize(viewport);
    await login(page, 'admin_test');
    const paths = ['auth/families.php', 'auth/families/create.php', 'auth/families/import.php', 'auth/admin/cases/create.php', 'auth/admin/cases/import.php', 'auth/tax_declarations.php', 'auth/tax_declarations/create.php'];
    for (const path of paths) {
      await page.goto(path);
      expect(await page.evaluate(() => document.documentElement.scrollWidth <= document.documentElement.clientWidth), `${path} overflowed at ${viewport.width}px`).toBe(true);
    }
    await page.goto('auth/families.php');
    await page.locator('a[href*="families/view.php?id="]').first().click();
    expect(await page.evaluate(() => document.documentElement.scrollWidth <= document.documentElement.clientWidth)).toBe(true);
    await page.goto('auth/tax_declarations.php?q=ANON-TD-CURRENT-001');
    await page.getByRole('link', { name: 'View', exact: true }).click();
    expect(await page.evaluate(() => document.documentElement.scrollWidth <= document.documentElement.clientWidth)).toBe(true);
  });
}

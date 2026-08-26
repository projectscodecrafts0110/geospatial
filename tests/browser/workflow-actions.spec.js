const { test, expect } = require('@playwright/test');

const password = 'TestPassword!123';
test.describe.configure({ timeout: 90000 });
async function login(page, username) {
  await page.goto('login.php');
  await page.getByPlaceholder('Username').fill(username);
  await page.getByPlaceholder('Password').fill(password);
  await page.getByRole('button', { name: 'Access System' }).click();
  if (username === 'staff_test' && /login\.php/.test(page.url())) {
    await page.getByPlaceholder('Username').fill(username);
    await page.getByPlaceholder('Password').fill('Replacement!456');
    await page.getByRole('button', { name: 'Access System' }).click();
  }
  await expect(page).not.toHaveURL(/login\.php/);
}
async function logout(page) {
  await page.locator('.topbar .dropdown-toggle').click();
  await page.locator('form[action$="logout.php"] button').click();
  await expect(page).toHaveURL(/login\.php/);
}
async function createAndSubmitRecord(page, name) {
  await page.goto('auth/admin/records/create.php');
  await page.locator('[name="full_name"]').fill(name);
  await page.locator('[name="gender"]').selectOption('Female');
  await page.locator('[name="tribe"]').fill('Test Tribe');
  await page.locator('[name="barangay"]').fill('Workflow Barangay');
  await page.locator('[name="municipality"]').fill('Workflow Municipality');
  await page.getByRole('button', { name: 'Submit' }).click();
  await expect(page.getByRole('heading', { name })).toBeVisible();
  await page.getByRole('button', { name: /Send for Approval/ }).click();
  await expect(page.getByText('FOR APPROVAL', { exact: true })).toBeVisible();
}

test('registry submission, approval, rejection, and resubmission follow the review hierarchy', async ({ page }) => {
  page.on('dialog', dialog => dialog.accept());
  await login(page, 'staff_test');
  await createAndSubmitRecord(page, 'Workflow Approval Person');
  await createAndSubmitRecord(page, 'Workflow Rejection Person');
  await logout(page);

  await login(page, 'admin_test');
  await page.goto('auth/admin/records.php?q=Workflow+Approval+Person');
  await page.locator('button.dropdown-toggle').last().click();
  await page.locator('.dropdown-menu.show a[href*="view.php"]').click();
  await page.getByRole('button', { name: 'Approve' }).click();
  await expect(page.getByText('APPROVED', { exact: true })).toBeVisible();

  await page.goto('auth/admin/records.php?q=Workflow+Rejection+Person');
  await page.locator('button.dropdown-toggle').last().click();
  await page.locator('.dropdown-menu.show a[href*="view.php"]').click();
  await page.getByRole('button', { name: 'Reject' }).click();
  await expect(page.getByText('REJECTED', { exact: true })).toBeVisible();
  await expect(page.getByRole('button', { name: 'Approve' })).toHaveCount(0);
});

test('staff can save an assigned case while invalid workflow jumps remain unavailable', async ({ page }) => {
  await login(page, 'admin_test');
  await page.goto('auth/admin/cases/create.php');
  await page.locator('[name="applicant_fullname"]').fill('Workflow Staff Applicant');
  await page.locator('[name="applicant_ip_group"]').fill('Test Tribe');
  await page.locator('[name="case_title"]').fill('Workflow Staff Case');
  await page.locator('[name="case_type"]').selectOption('environmental_issue');
  await page.getByRole('button', { name: 'Submit Case' }).click();
  await page.goto('auth/admin/cases.php?q=Workflow+Staff+Case');
  await page.locator('button.dropdown-toggle').last().click();
  await page.getByRole('link', { name: 'View', exact: true }).click();
  await page.locator('[name="assigned_to"]').selectOption('staff');
  await page.waitForLoadState('domcontentloaded');
  await logout(page);

  await login(page, 'staff_test');
  await page.goto('auth/admin/cases.php?q=Workflow+Staff+Case');
  await page.locator('button.dropdown-toggle').last().click();
  await page.getByRole('link', { name: 'Edit' }).click();
  await page.locator('[name="case_title"]').fill('Workflow Staff Case Updated');
  await page.getByRole('button', { name: 'Update Case' }).click();
  await expect(page.getByRole('heading', { name: 'Workflow Staff Case Updated' })).toBeVisible();
  const statuses = await page.locator('[name="status"] option').allTextContents();
  expect(statuses.map(value => value.trim())).toEqual(['Pending', 'Ongoing']);
});

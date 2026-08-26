const { spawn } = require('child_process');

module.exports = async () => {
  const server = spawn('C:/xampp/php/php.exe', ['-S', '127.0.0.1:8099', '-t', 'C:/xampp/htdocs'], {
    env: { ...process.env, DB_HOST: '127.0.0.1', DB_PORT: '3307', DB_NAME: 'geo_case_test', DB_USER: 'root', DB_PASS: '' },
    stdio: 'ignore',
    windowsHide: true
  });

  for (let attempt = 0; attempt < 40; attempt++) {
    if (server.exitCode !== null) throw new Error(`Test server exited with code ${server.exitCode}`);
    try {
      const response = await fetch('http://127.0.0.1:8099/geospatial/login.php');
      if (response.ok) return async () => {
        server.kill();
        await new Promise(resolve => setTimeout(resolve, 300));
        if (server.exitCode === null) server.kill('SIGKILL');
      };
    } catch {}
    await new Promise(resolve => setTimeout(resolve, 250));
  }
  server.kill('SIGKILL');
  throw new Error('Test server did not become ready.');
};

# SDK and CI policy

Use the latest stable Dart SDK for development, tests, linting, formatting, and
coverage. Follow the commands in the README. Keep the package SDK compatibility
range separate from the development SDK choice. Do not add nightly prerelease jobs
for this pure Dart package.

When an SDK update causes CI to fail, investigate the root cause and report the
resolved SDK version, failing check, and a focused reproduction. Propose a package
fix or an upstream fix to Pascal and wait for his review before implementing the
fix or posting upstream. Do not disable checks, weaken tests, or raise the minimum
SDK merely to make CI green.

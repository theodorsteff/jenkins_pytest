Jenkins integration of Pytest + Selenium demo

This small demo shows how to use pytest with Selenium (Firefox) to open https://www.google.com and verify the page title.

Requirements
- Python 3.11+ (recommended, 3.8+ supported)
- Firefox browser (either system Firefox, or download portable Firefox - see below)
- xvfb package if running headless tests without a display server
- Docker (if using Kubernetes integration)

Quick start

1) Create a virtual environment and activate it

```bash
python -m venv .venv
source .venv/bin/activate
```

2) Install dependencies

```bash
pip install -r requirements.txt

# On some systems you may need xvfb to run headless:
sudo apt install -y xvfb
```

3) Get Firefox

If your system's Firefox is a snap package or otherwise incompatible, you can use a portable Firefox. The included helper script makes this easy:

```bash
# Download Firefox to ./firefox (safe, won't overwrite existing):
./scripts/get_firefox.sh

# Force re-download (replace existing ./firefox):
./scripts/get_firefox.sh --force

# Skip download if ./firefox exists:
./scripts/get_firefox.sh --keep

# Override architecture (default: auto-detected):
./scripts/get_firefox.sh --arch=linux-aarch64  # for ARM64
./scripts/get_firefox.sh --arch=linux64        # for x86_64

# After download, use the local Firefox:
export FIREFOX_BINARY="$(pwd)/firefox/firefox"
```

Note: The helper script is idempotent and safe by default:
- If `./firefox` doesn't exist: downloads and unpacks Firefox there
- If `./firefox` exists: refuses to overwrite unless `--force` is passed
- With `--keep`: skips download if `./firefox` exists (useful in CI)
```

4) Run tests

```bash
# Run tests (assumes working display):
pytest -q

# Or run tests headless under xvfb:
xvfb-run -s "-screen 0 1920x1080x24" pytest -q
```

5) Complete command with force firefox re-download would look like this

```bash
# Force re-download firefox portable executable, run tests headless under xvfb:
./scripts/get_firefox.sh --force FIREFOX_BINARY="$(pwd)/firefox/firefox" xvfb-run -s "-screen 0 1920x1080x24" /home/thesteff/workspace/pytest_demo/.venv/bin/python -m pytest -q
```

Project Structure
```
pytest_demo/
├── JenkinsDockerfile       # Jenkins docker image builder
├── README.md               # This file
├── conftest.py             # Pytest configuration and fixtures
├── requirements.txt        # Python dependencies
├── scripts/             # Helper scripts
│   ├── get_firefox.sh  # Download and manage Firefox
└── tests/              # Test files
    └── test_google.py # Example test
```

Dependencies
The project uses specific versions to ensure compatibility:
```
pytest>=7.4.3
selenium>=4.15.2
webdriver-manager>=4.0.1
kubernetes>=28.1.0  # For kubectl operations
```

Notes and troubleshooting
- The project uses `webdriver-manager` to download a matching geckodriver automatically
- If Firefox fails to start:
  - Try a portable Firefox (see above "Get Firefox" steps)
  - Or install Firefox ESR if available: `sudo apt install -y firefox-esr`
  - If using system Firefox and it's a snap package, you may need to set `FIREFOX_BINARY`
- To run non-headless (debug), edit `conftest.py` and set `options.headless = False`

Jenkins integration of Pytest + Selenium demo

This small demo shows how to use pytest with Selenium (Chrome) to open https://www.google.com and verify the page title.

### Environment setup

### Jenkins and Docker-based Testing
- Locally installed and configured Jenkins
- Docker and docker-compose

Run Docker installer helper script in order to install Docker (if needed), enable Docker service and add the current and jenkins users to docker group (sudo actions required)
```bash
cd <repo_folder>
chmod +x ./scripts/docker_installer.sh
./scripts/docker_installer.sh
```

### Option 1: Run locally with Docker

```bash
# Build the required docker image (which would automatically run the test suite as well)
docker build -t pytest_demo:docker -f Dockerfile .

# Run tests
docker run --rm --shm-size=1g -v ".:/workspace" --name test -it pytest_demo:docker pytest --html=test-results/report.html --junitxml=test-results/report.xml -vvv
```

### Option 2: Run in Jenkins

TO BE UPDATED

Project Structure
```
pytest_demo/
├── Dockerfile                    # Docker container builder file for test execution
├── DockerfileJenkinsContainer    # Jenkins docker image builder
├── Jenkinsfile.docker            # Jenkins pipeline file
├── README.md                     # This file
├── conftest.py                   # Pytest configuration and fixtures
├── requirements.txt              # Python dependencies
└── scripts/                      # Helper scripts folder
    └── docker_installer.sh       # Docker installer helper script
└── tests/                        # Test files
    └── test_google.py            # Example test
```

Dependencies
The project uses specific versions to ensure compatibility:
```
attrs==25.4.0
certifi==2025.10.5
h11==0.16.0
idna==3.11
iniconfig==2.3.0
outcome==1.3.0.post0
packaging==25.0
pluggy==1.6.0
Pygments==2.19.2
PySocks==1.7.1
pytest==9.0.0
selenium==4.38.0
setuptools==68.1.2
sniffio==1.3.1
sortedcontainers==2.4.0
trio==0.32.0
trio-websocket==0.12.2
typing_extensions==4.15.0
urllib3==2.5.0
websocket-client==1.9.0
wheel==0.42.0
wsproto==1.2.0
```

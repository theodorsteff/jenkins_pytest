Jenkins integration of Pytest + Selenium demo

This small demo shows how to Integrate pytest with Selenium (Chrome) in Jenkins

### Environment setup

### Linux Ubuntu
- Installed Ubuntu 24.04.3 LTS distribution of Linux

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
cd <repo_folder>
docker run --rm --shm-size=1g -v ".:/workspace" ${IMAGE_NAME} pytest --html=test-results/report.html --junitxml=test-results/report.xml -vvv
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

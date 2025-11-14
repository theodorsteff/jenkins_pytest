Jenkins integration of Pytest + Selenium demo

This small demo shows how to Integrate pytest with Selenium (Chrome) in Jenkins

### Environment setup

### Linux Ubuntu
- Installed Ubuntu 24.04.3 LTS distribution of Linux

### Docker installation

Run Docker installer helper script in order to install Docker (if needed), enable Docker service and add the current and jenkins users to docker group (sudo actions required)
```bash
cd <repo_folder>
chmod +x ./scripts/docker_installer.sh
./scripts/docker_installer.sh
```

### Option 1: Run locally with Docker

```bash
# Build the required docker image
IMAGE_NAME = pytest:ubuntu
docker build -t ${IMAGE_NAME} -f Dockerfiles/Dockerfile.Ubuntu .

# Run tests
cd <repo_folder>
docker run --rm --shm-size=1g -v ".:/workspace" ${IMAGE_NAME} pytest --html=test-results/report.html --junitxml=test-results/report.xml -vvv

# Change ownership recursively of the test-results folder to the current user (to be able to visualize the report data)
sudo chown -R $(id -u):$(id -g) test-results/
```

### Jenkins pipeline setup

1. Click on `Jenkins` logo to go to the dashboard
2. Click on `New Item`
3. Enter an item name
4. Coose `pipeline` (requires pipeline plugin to be preinstalled)
5. Click `OK`
6. Scroll down to "Pipeline" section -> `Pipeline script from SCM` and configure the job {
    `SCM`: Git
    `Repository URL`: <repo_url>
    `Credentials`: none
    `Branch Specifier (blank for 'any')`: <branch_name>
    `Script Path`: <jenkins_script_path_inside_repo>
}
7. Click `Save`

### Option 2: Run in pre-installed Jenkins

Required Jenkins plugins:
```
git
workflow-aggregator
configuration-as-code
blueocean
docker-workflow
credentials-binding
pipeline-stage-view
```

1. Access & login to Jenkins
2. Jenkins pipeline setup {
    `SCM`: Git
    `Repository URL`: https://github.com/theodorsteff/jenkins_pytest.git
    `Credentials`: none
    `Branch Specifier (blank for 'any')`: ./main
    `Script Path`: Jenkinsfiles/Jenkinsfile.Ubuntu
}
3. Run the pipeline

### Option 3: Run in containerized Jenkins

Required Jenkins plugins are automatically installed when building the docker image.

```bash
# Build the required docker image
IMAGE_NAME = jenkins:docker
docker build -t ${IMAGE_NAME} -f Dockerfiles/Dockerfile.Jenkins .

# Run docker container for Jenkins
docker run -d \
  -p 8081:8081 -p 50000:50000 \
  --name my-jenkins \
  my-jenkins:latest

# Jenkins should be up and running in about 30-60 seconds
```

1. Access & login to Jenkins (http://localhost:8081, Username: admin, Password: admin)
2. Jenkins pipeline setup {
    `SCM`: Git
    `Repository URL`: https://github.com/theodorsteff/jenkins_pytest.git
    `Credentials`: none
    `Branch Specifier (blank for 'any')`: ./main
    `Script Path`: Jenkinsfiles/Jenkinsfile.Ubuntu
}
3. Run the pipeline

### Project structure
```
<repo_folder>/
├── conftest.py                    # Pytest configuration and fixtures
└── Dockerfiles/                   # Docker scripts folder
    └── casc.yaml                  # Jenkins Configuration as Code (JCasC)
    └── Dockerfile.Jenkins         # Docker image file for Jenkins container
    └── Dockerfile.Ubuntu          # Docker image file for Ubuntu container
    └── plugins.txt                # Jenkins plugins list to be installed
└── Jenkinsfiles/                  # Jenkins pipeline scripts folder
    └── Jenkinsfile.Jenkins        # Jenkins pipeline scripts to run on containerized Jenkins
    └── Jenkinsfile.Ubuntu         # Jenkins pipeline scripts to run on pre-installed Jenkins
├── README.md                      # This file
├── requirements.txt               # Python dependencies
└── scripts/                       # Helper scripts folder
    └── docker_installer.sh        # Docker installer helper script
└── tests/                         # Test files
    └── test_google.py             # Example test for google.com
    └── test_automationexercise.py # Example test for automationexercise.com
```


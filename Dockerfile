FROM python:3-slim
COPY . /pytest_demo
WORKDIR /pytest_demo
RUN pip install --no-cache-dir -r requirements.txt
RUN apt-get update && apt-get install -y \
    bash curl wget unzip xz-utils xvfb \
    && rm -rf /var/lib/apt/lists/*
RUN chmod +x ./scripts/get_firefox.sh
RUN export FIREFOX_BINARY="/pytest_demo/firefox/firefox"
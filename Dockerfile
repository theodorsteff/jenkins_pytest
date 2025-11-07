FROM python:3-slim
COPY . /pytest_demo
WORKDIR /pytest_demo
RUN pip install --no-cache-dir -r requirements.txt
RUN ["pytest", "-v", "--junitxml=reports/result.xml"]
CMD tail -f /dev/null
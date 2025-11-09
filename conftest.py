import os
import pytest
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options

@pytest.fixture(scope="session")
def driver():
    options = Options()
    options.add_argument("--headless=new")
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")
    options.add_argument("--disable-gpu")
    options.add_argument("--disable-software-rasterizer")
    options.add_argument("--remote-debugging-port=9222")
    options.binary_location = "/usr/bin/google-chrome"

    service = Service("/usr/local/bin/chromedriver")

    try:
        driver = webdriver.Chrome(service=service, options=options)
    except Exception as e:
        with open("/tmp/webdriver_debug.log", "w") as f:
            f.write(str(e))
        raise

    yield driver
    driver.quit()

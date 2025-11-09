def test_google_title(driver):
    """Open automationexercise.com and check the page title contains 'Automation'."""
    driver.get("https://automationexercise.com/")
    assert "Automation" in driver.title

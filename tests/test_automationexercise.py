def test_google_title(driver):
    """Open automationexercise.com and check the page title contains 'Automation'."""
    driver.get("https://automationexercise.com/")
    # Some regions may show localized titles; we assert 'Google' is a substring.
    assert "Automation" in driver.title

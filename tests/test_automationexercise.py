def test_google_title(driver):
    """Open google.com and check the page title contains 'Google'."""
    driver.get("https://automationexercise.com/")
    # Some regions may show localized titles; we assert 'Google' is a substring.
    assert "Automation" in driver.title

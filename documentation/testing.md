# Test Scenarios Documentation

## Table of Contents

1. [404 Error Page](#1-404-error-page)
2. [Exciting Username Register](#2-exciting-username-register)
3. [Missing Field Registration](#3-missing-field-registration)
4. [Quantity Number Out of Stock](#4-quantity-number-out-of-stock)
5. [Wrong Card Details](#5-wrong-card-details)
6. [Wrong Credentials Login](#6-wrong-credentials-login)

---

## 1. **404 Error Page**

- **Scenario**: When the user attempts to access a page that doesn't exist.
- **Expected Result**: A 404 error page is displayed indicating that the page was not found.
- **Image**: ![404 Error](documentation/images/testing/404.webp)

## 2. **Exciting Username Register**

- **Scenario**: A user attempts to register with an exciting username.
- **Expected Result**: The registration form should process the username correctly or display an error if not valid.
- **Image**: ![Exciting Username Register](documentation/images/testing/exiting-username-register.webp)

## 3. **Missing Field Registration**

- **Scenario**: A user attempts to submit the registration form without filling in required fields.
- **Expected Result**: The system will prompt the user to fill in the missing fields.
- **Image**: ![Missing Field Registration](documentation/images/testing/missing-field-registration.webp)

## 4. **Quantity Number Out of Stock**

- **Scenario**: A user tries to select a quantity of a product that is no longer in stock.
- **Expected Result**: The system will notify the user that the item is out of stock.
- **Image**: ![Quantity Number Out of Stock](documentation/images/testing/quantity-number-out-of-stock.webp)

## 5. **Wrong Card Details**

- **Scenario**: A user attempts to complete a purchase with incorrect card details.
- **Expected Result**: The system will show an error about the invalid card information.
- **Image**: ![Wrong Card Details](documentation/images/testing/wrong-card-details.webp)

## 6. **Wrong Credentials Login**

- **Scenario**: A user attempts to log in with incorrect credentials (username or password).
- **Expected Result**: The system will display an error message indicating the wrong credentials.
- **Image**: ![Wrong Credentials Login](documentation/images/testing/wrong-credentials-login.webp)

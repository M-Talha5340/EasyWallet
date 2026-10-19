# 💳 Digital Wallet & Payment Gateway Integration

A digital wallet application developed using **Flutter** and **ASP.NET Core Web API**, featuring Firebase authentication, cloud-based data storage, and PayFast payment gateway integration for wallet recharges.

This project demonstrates mobile application development, REST API integration, authentication, database transactions, and third-party payment gateway workflows.

## ✨ Features

- 📱 **Flutter Mobile App** — Mobile interface for wallet operations and recharge workflows.
- 🔐 **Firebase Phone Authentication** — User authentication through Firebase.
- 🛡️ **Protected REST APIs** — Firebase ID token verification on secured backend endpoints.
- 💰 **Wallet Management** — Wallet balance retrieval and recharge processing.
- ☁️ **Cloud Firestore** — Storage for user accounts, payments, and wallet transaction records.
- 💳 **PayFast Integration** — Access-token generation and checkout-session creation using the PayFast UAT environment.
- 🔄 **Payment Redirect Handling** — Success and failure redirect endpoints for the checkout flow.
- 🔑 **SHA-256 Hash Validation** — Validation of PayFast redirect hash fields.
- ⚙️ **Transaction Safety** — Atomic Firestore updates and duplicate-processing safeguards for wallet credit operations.
- 🌐 **Callback Testing** — ngrok for exposing local backend endpoints during integration testing.

## 🧰 Tech Stack

| Technology | Purpose |
|---|---|
| Flutter & Dart | Mobile application |
| C# | Backend programming |
| ASP.NET Core Web API | REST API and business logic |
| Firebase Authentication | User authentication |
| Cloud Firestore | Cloud database |
| PayFast API | Payment gateway integration |
| ngrok | Local callback testing |

## 🏗️ System Architecture

```text
Flutter Mobile Application
           |
           | Authenticated API Requests
           v
    ASP.NET Core Web API
           |
           +---------- Firebase Authentication
           |
           +---------- Cloud Firestore
           |
           +---------- PayFast UAT API
                            |
                            v
                      Checkout Flow
                            |
                            v
                    Payment Redirect
```

## 🔁 Payment Workflow

1. The user signs in using Firebase Phone Authentication.
2. The Flutter application sends an authenticated request to the backend.
3. The backend validates the Firebase ID token and creates a pending payment record.
4. The backend communicates with PayFast to obtain checkout details.
5. The Flutter application opens the PayFast checkout page.
6. PayFast redirects the user to the configured success or failure endpoint.
7. The backend validates the redirect hash and must independently verify the transaction before considering it eligible for wallet credit.
8. After successful verification, the backend updates the wallet balance and transaction records atomically in Firestore.

## 🔒 Security

- Verify Firebase ID tokens on protected endpoints.
- Keep merchant IDs, secured keys, and other sensitive configuration out of source control.
- Match the payment amount against the original pending payment.
- Prevent duplicate wallet credits through idempotent transaction processing.
- Never rely on a browser redirect alone as proof of a successful payment.
- Complete independent transaction verification and callback security checks before production deployment.

## 🚧 Project Status

**Development / PayFast UAT integration**

The core Flutter-to-backend flow and PayFast checkout integration have been implemented and tested. Independent server-side payment verification and final security validation are required before the wallet recharge flow can be considered production-ready.

## 📚 What I Learned

- Developing mobile applications with Flutter.
- Building REST APIs with ASP.NET Core.
- Integrating Firebase Authentication and Cloud Firestore.
- Connecting a mobile application to a backend API.
- Integrating a third-party payment gateway.
- Handling payment lifecycle events and redirects.
- Designing atomic database operations and duplicate-payment safeguards.
- Testing local callback endpoints using ngrok.

## 👨‍💻 Developer

**Muhammad Talha**

GitHub: [@M-Talha5340](https://github.com/M-Talha5340)

---

⭐ If you find this project interesting, feel free to explore the repository.
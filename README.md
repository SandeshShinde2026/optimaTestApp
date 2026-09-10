# Optima Customer Management

Optima Customer Management is a streamlined, mobile-first Customer Relationship Management (CRM) application built with Flutter. It is designed to help businesses and sales professionals easily track, manage, and analyze their client base on the go.

## Core Features

- **Secure Authentication:** Email/Password login, password resets, and Google Single Sign-On (SSO) powered by Firebase Auth.
- **Interactive Dashboard:** Instant visibility into business health with top-level metrics and recent customer activity.
- **Customer Directory:** A comprehensive database of your clients with real-time global search and quick status filters.
- **Detailed Profiles:** View personal and business data, and instantly call or email clients with one-tap action buttons.
- **Business Intelligence:** Dynamic, interactive pie charts visualizing your geographic footprint, and an accordion-style company directory showing who works where.
- **Modern UI/UX:** Built on Material Design 3 and beautifully branded with the Optima Violet theme (`#796AB1`), featuring an intuitive 4-tab bottom navigation bar.

## Tech Stack

- **Frontend:** Flutter (Dart)
- **State Management:** Provider
- **Backend & Auth:** Firebase
- **Data Visualization:** fl_chart

## Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- A Firebase project configured for iOS/Android (ensure `GoogleService-Info.plist` and `google-services.json` are placed in their respective directories).

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/SandeshShinde2026/optimaTestApp.git
   ```
2. Navigate to the project directory:
   ```bash
   cd optimaTestApp
   ```
3. Install Flutter dependencies:
   ```bash
   flutter pub get
   ```
4. Install iOS Pods (if running on a Mac):
   ```bash
   cd ios && pod install --repo-update && cd ..
   ```
5. Run the application:
   ```bash
   flutter run
   ```

# Customer Management Application --- Product Requirements Document (PRD)

**Document Version:** 1.0\
**Prepared for:** Candidate Technical Assignment\
**Product Type:** Mobile Customer Management Application\
**Primary Platform:** Mobile (Android / iOS)\
**Suggested Implementation:** Flutter

------------------------------------------------------------------------

## 1. Product Overview

The Customer Management Application is a mobile application that allows
an authenticated user to view and inspect customer records in a simple,
responsive, and maintainable interface.

The application is intentionally focused on the core assignment
requirements:

1.  Login
2.  Customer listing
3.  Customer details
4.  Local/sample customer data
5.  Basic validation and error handling
6.  Clean separation between UI, data, and application logic

No backend or live API is required.

------------------------------------------------------------------------

## 2. Product Goal

Build a professional-looking mobile customer management experience that
demonstrates:

-   Clean application architecture
-   Reusable UI components
-   Responsive mobile layouts
-   Sensible navigation
-   Form validation
-   Local data handling
-   Maintainable code
-   Clear separation of concerns

The visual design should communicate a modern business/CRM product
rather than a generic demo application.

------------------------------------------------------------------------

## 3. Target User

### Primary User

A business employee, sales representative, account manager,
administrator, or customer-support user who needs to quickly review
customer information from a mobile device.

### User Needs

The user should be able to:

-   Sign in quickly.
-   See a summary of customers.
-   Find a customer easily.
-   Open a customer record.
-   Review complete customer information.
-   Understand customer status at a glance.

------------------------------------------------------------------------

## 4. Scope

### In Scope

  Feature                      Priority
  ---------------------------- -------------
  Login screen                 Must Have
  Email/username validation    Must Have
  Password validation          Must Have
  Firebase Authentication      Must Have
  Customer listing             Must Have
  Customer search/filter       Recommended
  Customer detail screen       Must Have
  Customer status              Must Have
  Local/sample data            Must Have
  Responsive UI                Must Have
  Empty/error states           Must Have
  Reusable components          Must Have
  Loading state                Recommended
  Pull-to-refresh simulation   Optional
  Add/edit/delete customer     Optional

### Out of Scope

-   Backend server (other than Firebase Auth)
-   Real-time API integration
-   Cloud database
-   Role-based access control
-   Payments
-   Push notifications
-   Complex CRM workflows

------------------------------------------------------------------------

# 5. Information Architecture

``` text
                    ┌───────────────┐
                    │  Login Screen │
                    └───────┬───────┘
                            │
                    Successful Login
                            │
                            ▼
                 ┌─────────────────────┐
                 │ Customer List Screen│
                 └──────────┬──────────┘
                            │
                     Select Customer
                            │
                            ▼
                 ┌─────────────────────┐
                 │ Customer Detail     │
                 │ Screen              │
                 └─────────────────────┘
```

------------------------------------------------------------------------

# 6. Screen Requirements

## 6.1 Login Screen

### Purpose

Authenticate the user using Firebase Authentication (Email & Password) and provide
access to the customer listing.

### UI Elements

-   Application logo/icon
-   Application name
-   Welcome/title text
-   Email/username field
-   Password field
-   Show/hide password control
-   Login button
-   Validation/error messages

### Validation

Email/username:

-   Required
-   If email format is used, validate email format

Password:

-   Required
-   Minimum recommended length: 6 characters

### Firebase Authentication

The application must integrate with Firebase Authentication to handle user login via Email and Password. Users should be able to authenticate against a real Firebase project.

### Success

Navigate to the Customer Listing Screen.

### Failure

Show a clear inline or snackbar error such as:

> Invalid username or password.

Do not crash or navigate on failed authentication.

------------------------------------------------------------------------

# 7. Customer Listing Screen

## Purpose

Provide an overview of all available customer records.

### UI Requirements

Each customer item should communicate key information without opening
the record.

Recommended information:

-   Customer name
-   Company
-   City
-   Contact number
-   Status
-   Avatar/initials

### Recommended Layout

``` text
┌─────────────────────────────┐
│ Customers             ⋮     │
│                             │
│ ┌─────────────────────────┐ │
│ │ Search customers...     │ │
│ └─────────────────────────┘ │
│                             │
│ ┌─────────────────────────┐ │
│ │ [AS]  Amit Shah         │ │
│ │       Acme Technologies │ │
│ │       Pune       Active │ │
│ └─────────────────────────┘ │
│                             │
│ ┌─────────────────────────┐ │
│ │ [PR]  Priya Rao         │ │
│ │       Nova Solutions    │ │
│ │       Mumbai    Inactive│ │
│ └─────────────────────────┘ │
└─────────────────────────────┘
```

### Interactions

-   Tap customer → open customer details
-   Search → filter customer list
-   Optional status filter → filter by Active/Inactive/Lead/etc.
-   Pull to refresh → optional local refresh simulation

### Empty State

When no customers match a search:

> No customers found

Supporting text:

> Try a different name, company, or city.

------------------------------------------------------------------------

# 8. Customer Detail Screen

## Purpose

Display complete information for the selected customer in a structured
and readable manner.

### Required Information

-   Customer name
-   Company
-   Email
-   Phone
-   Address
-   City
-   Status

### Optional Information

-   Customer ID
-   State
-   Postal code
-   Country
-   Notes
-   Created date
-   Last interaction
-   Customer category

### Recommended Structure

``` text
┌─────────────────────────────┐
│ ← Customer Details          │
│                             │
│        [AS]                 │
│      Amit Shah              │
│    Acme Technologies        │
│                             │
│ ● Active                    │
│                             │
│ CONTACT                     │
│ Email                       │
│ amit@example.com            │
│                             │
│ Phone                       │
│ +91 98765 43210             │
│                             │
│ ADDRESS                     │
│ 12 Business Park            │
│ Pune, Maharashtra           │
│                             │
└─────────────────────────────┘
```

### Interaction

-   Back navigation
-   Tap email → optional mail application
-   Tap phone → optional phone application
-   Tap address → optional maps application

These external actions are optional and should not be required for
assignment completion.

------------------------------------------------------------------------

# 9. Data Model

The application should use a dedicated customer model rather than
hard-coded values directly inside UI widgets.

Example:

``` text
Customer
├── id
├── name
├── company
├── email
├── phone
├── address
├── city
├── status
└── optional metadata
```

### Example Dart Model

``` dart
class Customer {
  final String id;
  final String name;
  final String company;
  final String email;
  final String phone;
  final String address;
  final String city;
  final String status;

  const Customer({
    required this.id,
    required this.name,
    required this.company,
    required this.email,
    required this.phone,
    required this.address,
    required this.city,
    required this.status,
  });
}
```

------------------------------------------------------------------------

# 10. Data Layer

The supplied `sample_customer_data.json` or `sample_customer_data.csv`
should be used as the source of local records.

Recommended separation:

``` text
UI
 ↓
Controller / ViewModel
 ↓
Customer Repository
 ↓
Local Data Source
 ↓
JSON / CSV
```

The UI should not directly parse the raw JSON/CSV file.

### Recommended Repository API

``` text
getCustomers()
getCustomerById(id)
searchCustomers(query)
```

------------------------------------------------------------------------

# 11. Navigation

Recommended routes:

``` text
/login
/customers
/customers/:id
```

Navigation rules:

-   App starts at Login.
-   Successful login → Customers.
-   Selecting a customer → Customer Details.
-   Back from details → Customers.
-   Failed login → remain on Login.

------------------------------------------------------------------------

# 12. Error Handling

The application should gracefully handle:

### Invalid Login

Show an understandable authentication error.

### Invalid Form

Show field-level validation.

### Data Loading Failure

Show:

> Unable to load customers.

Provide a retry action.

### Empty Dataset

Show an empty-state illustration/message.

### Missing Customer

If a customer ID cannot be found:

> Customer not found.

Provide a Back action.

------------------------------------------------------------------------

# 13. Responsive Design Requirements

The UI should work on common mobile screen sizes.

Design considerations:

-   Use flexible layouts instead of fixed widths.
-   Avoid text overflow.
-   Use safe areas.
-   Support different screen heights.
-   Ensure touch targets are comfortably tappable.
-   Maintain consistent horizontal padding.
-   Use scrolling for long customer details.

Recommended horizontal page padding:

**16--20 dp**

------------------------------------------------------------------------

# 14. Accessibility

Recommended accessibility considerations:

-   Sufficient text contrast
-   Meaningful labels for form fields
-   Minimum comfortable touch target around 44--48 dp
-   Do not communicate status using color alone
-   Support larger text where practical
-   Clear error messages

------------------------------------------------------------------------

# 15. Non-Functional Requirements

### Maintainability

Code should be organized by feature and responsibility.

### Reliability

No unresolved build errors.

### Performance

Customer lists should remain smooth for the supplied dataset.

### Usability

A new user should understand the three primary screens without
instructions.

### Scalability

The data/repository layer should allow a future API to replace the local
source without requiring major UI changes.

------------------------------------------------------------------------

# 16. Suggested Project Structure

``` text
lib/
├── core/
│   ├── theme/
│   ├── constants/
│   └── utils/
│
├── features/
│   ├── auth/
│   │   ├── screens/
│   │   ├── widgets/
│   │   └── controllers/
│   │
│   └── customers/
│       ├── models/
│       ├── data/
│       ├── repositories/
│       ├── screens/
│       ├── widgets/
│       └── controllers/
│
└── main.dart

assets/
└── data/
    └── sample_customer_data.json
```

------------------------------------------------------------------------

# 17. Acceptance Criteria

## Login

-   [ ] Email/username field exists.
-   [ ] Password field exists.
-   [ ] Required validation works.
-   [ ] Email format is validated where applicable.
-   [ ] Password is obscured.
-   [ ] Firebase Authentication (Email/Password) is integrated and works.
-   [ ] Successful login navigates to customers.
-   [ ] Failed login shows an error.

## Customer Listing

-   [ ] Customer records are displayed.
-   [ ] Name is visible.
-   [ ] Company is visible.
-   [ ] City/contact/status information is visible.
-   [ ] List is scrollable.
-   [ ] Layout works on common mobile sizes.
-   [ ] Selecting a customer opens details.

## Customer Details

-   [ ] Dedicated detail screen exists.
-   [ ] Complete customer information is shown.
-   [ ] Information is structured into logical sections.
-   [ ] Back navigation works.

## Data

-   [ ] Supplied JSON/CSV data is used.
-   [ ] Customer data is represented by a model.
-   [ ] Raw data is not embedded directly into UI code.

## Technical Quality

-   [ ] UI, data, and application logic are separated.
-   [ ] Reusable widgets/components are used.
-   [ ] Error and empty states are handled.
-   [ ] Project builds without unresolved errors.

# Customer Management Application --- Design System

**Version:** 1.0\
**Platform:** Mobile\
**Design Direction:** Modern, professional, clean CRM\
**Suggested Framework:** Flutter

------------------------------------------------------------------------

# 1. Design Principles

## 1.1 Clarity First

Customer information is the primary content. Avoid unnecessary
decoration that competes with names, contact information, and status.

## 1.2 Consistency

Use the same spacing, typography, corner radius, button treatment, and
status patterns throughout the application.

## 1.3 Efficient Scanning

The listing screen should allow users to understand a customer record
within a few seconds.

## 1.4 Progressive Detail

The list provides a summary. The detail screen provides the complete
record.

## 1.5 Professional but Approachable

Use a restrained business UI with subtle surfaces, clear hierarchy, and
a small number of accent colors.

------------------------------------------------------------------------

# 2. Visual Direction

### Overall Style

-   Light-first interface
-   Soft neutral background
-   White elevated cards
-   One strong primary brand color
-   Rounded but not overly playful components
-   Clear typography hierarchy
-   Minimal shadows
-   Status shown with both text and visual indicator

### Suggested Brand Personality

**Reliable · Modern · Efficient · Professional**

------------------------------------------------------------------------

# 3. Color System

Use semantic color tokens rather than hard-coding colors throughout
widgets.

## Brand

  Token          Suggested Value   Usage
  -------------- ----------------- ----------------------------------
  Primary        `#2563EB`         Primary actions, active controls
  Primary Dark   `#1D4ED8`         Pressed/hover state
  Primary Soft   `#DBEAFE`         Selected backgrounds

## Neutral

  Token               Suggested Value   Usage
  ------------------- ----------------- -----------------------------
  Background          `#F8FAFC`         App background
  Surface             `#FFFFFF`         Cards and fields
  Surface Secondary   `#F1F5F9`         Secondary containers
  Border              `#E2E8F0`         Dividers and field borders
  Text Primary        `#0F172A`         Headings and important text
  Text Secondary      `#475569`         Supporting information
  Text Muted          `#64748B`         Metadata/placeholders

## Semantic

  Token          Suggested Value   Usage
  -------------- ----------------- --------------------------
  Success        `#16A34A`         Active/success
  Success Soft   `#DCFCE7`         Active status background
  Warning        `#D97706`         Pending/warning
  Warning Soft   `#FEF3C7`         Warning background
  Error          `#DC2626`         Validation/error
  Error Soft     `#FEE2E2`         Error background
  Info           `#0284C7`         Informational states

**Implementation rule:** Components should consume semantic tokens such
as `primary`, `surface`, `textPrimary`, and `error`, rather than
repeating raw hex values.

------------------------------------------------------------------------

# 4. Typography

Use a clean system sans-serif font.

### Recommended Flutter approach

Use the platform/system font or a font such as Inter if an external font
is intentionally included.

## Type Scale

  Style          Size Weight     Usage
  ------------ ------ ---------- ------------------------
  Display          32 Bold       Rare large headings
  H1               28 Bold       Main screen title
  H2               22 Bold       Section title
  H3               18 SemiBold   Card/customer title
  Body Large       16 Regular    Important body content
  Body             14 Regular    General content
  Label            13 Medium     Form labels
  Caption          12 Regular    Supporting metadata
  Button           14 SemiBold   Actions

### Typography Rules

-   Use sentence case.
-   Avoid excessive uppercase text.
-   Use bold primarily for hierarchy.
-   Maintain comfortable line height.
-   Do not use more than 3--4 text sizes on one screen.

------------------------------------------------------------------------

# 5. Spacing System

Use a base **4 dp** spacing unit.

``` text
4   = XS
8   = SM
12  = MD-SM
16  = MD
20  = LG
24  = XL
32  = 2XL
40  = 3XL
48  = 4XL
```

### Common Usage

-   Screen horizontal padding: **16--20 dp**
-   Card internal padding: **16 dp**
-   Section spacing: **24 dp**
-   Label → field: **8 dp**
-   Field → field: **16 dp**
-   Icon → text: **8 dp**
-   List item gap: **12 dp**

------------------------------------------------------------------------

# 6. Border Radius

  Token           Radius Usage
  ------------- -------- ------------------
  Radius XS            6 Small badges
  Radius SM            8 Inputs
  Radius MD           12 Cards
  Radius LG           16 Large containers
  Radius Full        999 Pills/avatars

Recommended default card radius:

**12 dp**

Recommended input radius:

**10--12 dp**

------------------------------------------------------------------------

# 7. Elevation & Shadows

Keep elevation subtle.

### Card

``` text
Elevation: 1–2
Blur: subtle
```

Cards should primarily be separated through:

1.  Surface color
2.  Border
3.  Small elevation

Avoid large, dramatic shadows.

------------------------------------------------------------------------

# 8. Iconography

Use one consistent icon family.

Suggested Flutter option:

``` dart
Icons
```

or a single consistent icon package.

### Common Icons

  Purpose               Icon
  --------------------- ------------------------
  Back                  `arrow_back`
  Search                `search`
  Password visibility   `visibility`
  Email                 `email_outlined`
  Phone                 `phone_outlined`
  Location              `location_on_outlined`
  Company               `business_outlined`
  Status                `circle`
  More                  `more_vert`

Do not mix multiple unrelated icon styles.

------------------------------------------------------------------------

# 9. Buttons

## Primary Button

Use for the main action.

Example:

``` text
┌──────────────────────────────┐
│           Log In              │
└──────────────────────────────┘
```

Specifications:

-   Height: **48--52 dp**
-   Radius: **10--12 dp**
-   Text: 14--16 dp, semi-bold
-   Full width on login
-   Clear pressed/disabled states

## Secondary Button

Use for less important actions.

-   Transparent or light surface
-   Primary-colored border/text
-   Same height as primary button

------------------------------------------------------------------------

# 10. Text Fields

### Standard Field

``` text
Email
┌────────────────────────────────┐
│ ✉  demo@example.com            │
└────────────────────────────────┘
```

### Specifications

-   Height: approximately **48--52 dp**
-   Horizontal padding: **14--16 dp**
-   Radius: **10--12 dp**
-   Border: 1 dp
-   Clear focused state
-   Clear error state

### Error

``` text
Email
┌────────────────────────────────┐
│ invalid-email                  │
└────────────────────────────────┘
Please enter a valid email address.
```

Errors should appear close to the relevant field.

------------------------------------------------------------------------

# 11. Customer Card

The customer card is the primary reusable component on the listing
screen.

### Structure

``` text
┌─────────────────────────────────┐
│  ○  Amit Shah              ›    │
│     Acme Technologies           │
│     Pune · +91 98765 43210      │
│                                 │
│     ● Active                    │
└─────────────────────────────────┘
```

### Component API Concept

``` text
CustomerCard
├── avatar
├── customerName
├── companyName
├── city
├── contact
├── status
└── onTap
```

### Rules

-   Name receives strongest visual emphasis.
-   Company is secondary.
-   Metadata is smaller.
-   Status is visually distinct.
-   Entire card should be tappable.

------------------------------------------------------------------------

# 12. Avatar

Use customer initials when profile images are unavailable.

Example:

``` text
AS
```

### Specifications

-   Size: 44--48 dp
-   Circular
-   Semibold initials
-   Consistent background treatment

Initials should be generated from the customer's name.

Examples:

``` text
Amit Shah → AS
Priya Rao → PR
John Doe → JD
```

------------------------------------------------------------------------

# 13. Status Badge

Status should be represented using both a visual indicator and text.

### Active

``` text
● Active
```

Use success semantic styling.

### Pending

``` text
● Pending
```

Use warning semantic styling.

### Inactive

``` text
● Inactive
```

Use neutral styling.

### Badge Specifications

-   Height: approximately 28 dp
-   Horizontal padding: 10--12 dp
-   Fully rounded
-   Small status dot
-   12--13 dp text

Do not rely only on color to communicate status.

------------------------------------------------------------------------

# 14. Search Bar

### Structure

``` text
┌─────────────────────────────────┐
│ 🔍  Search customers...         │
└─────────────────────────────────┘
```

### Behavior

Search across:

-   Name
-   Company
-   City
-   Email
-   Phone

Recommended:

-   Case-insensitive search
-   Instant filtering
-   Clear button when text exists

------------------------------------------------------------------------

# 15. Login Screen Design

## Layout

``` text
┌─────────────────────────────┐
│                             │
│          [ LOGO ]           │
│                             │
│      Customer Manager       │
│  Manage your customers      │
│  from anywhere.             │
│                             │
│  Email                      │
│  ┌─────────────────────────┐│
│  │ demo@example.com        ││
│  └─────────────────────────┘│
│                             │
│  Password                   │
│  ┌─────────────────────────┐│
│  │ ••••••••••          ◉   ││
│  └─────────────────────────┘│
│                             │
│  ┌─────────────────────────┐│
│  │          Log In         ││
│  └─────────────────────────┘│
│                             │
└─────────────────────────────┘
```

### Design Goal

The login screen should feel lightweight and trustworthy.

Avoid unnecessary:

-   Gradients
-   Large illustrations
-   Excessive animation
-   Decorative elements

------------------------------------------------------------------------

# 16. Customer List Design

### Header

``` text
Customers
12 customers
```

Optional:

``` text
        Search
```

### List

Use vertically stacked cards with approximately 12 dp spacing.

The screen should prioritize customer records rather than navigation
chrome.

------------------------------------------------------------------------

# 17. Customer Details Design

Organize information into sections.

### Header

``` text
← Customer Details
```

### Customer Identity

``` text
        [AS]

      Amit Shah
   Acme Technologies
```

### Status

``` text
● Active
```

### Contact Section

``` text
CONTACT

Email
amit@example.com

Phone
+91 98765 43210
```

### Address Section

``` text
ADDRESS

12 Business Park
Pune, Maharashtra
```

This structure makes long records easier to scan.

------------------------------------------------------------------------

# 18. Loading State

For local data, loading may be extremely short, but the architecture
should still support a loading state.

Recommended:

``` text
CircularProgressIndicator
```

For a list, an optional skeleton can be used.

Avoid artificial delays merely to demonstrate loading.

------------------------------------------------------------------------

# 19. Empty States

## No Customers

``` text
        [icon]

    No customers yet

There are no customer records
to display.
```

## No Search Results

``` text
        [search icon]

    No customers found

Try another search term.
```

Provide a clear way to recover where appropriate.

------------------------------------------------------------------------

# 20. Error State

Example:

``` text
Something went wrong

We couldn't load the customer data.

        [ Try Again ]
```

Errors should be human-readable and actionable.

Avoid technical messages such as:

``` text
NullPointerException
JSON parse error at line 37
```

------------------------------------------------------------------------

# 21. Responsive Rules

### Small Mobile

-   16 dp page padding
-   Single-column layout
-   Cards occupy available width
-   Details use scrolling

### Standard Mobile

-   16--20 dp page padding
-   Same component system

### Larger Screens

If tablet support is added:

-   Increase maximum content width
-   Keep readable line lengths
-   Optionally use a two-column customer list/detail layout

Do not simply stretch every element to the full screen.

------------------------------------------------------------------------

# 22. Motion

Animations should be subtle.

Recommended:

-   Navigation transition
-   Button pressed feedback
-   Search/list filtering transition
-   Optional fade/slide for empty states

Avoid:

-   Long animations
-   Constant decorative movement
-   Animation that delays user interaction

------------------------------------------------------------------------

# 23. Component Inventory

The application should ideally contain reusable components such as:

``` text
AppButton
AppTextField
CustomerCard
CustomerAvatar
StatusBadge
SearchBar
SectionHeader
EmptyState
ErrorState
LoadingState
```

This prevents duplicated styling across screens.

------------------------------------------------------------------------

# 24. Flutter Theme Mapping

Recommended architecture:

``` dart
ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
  ),
  scaffoldBackgroundColor: backgroundColor,
  inputDecorationTheme: ...,
  elevatedButtonTheme: ...,
  cardTheme: ...,
)
```

Keep theme configuration centralized.

Avoid:

``` dart
Container(
  color: Color(0xFF2563EB),
)
```

repeated throughout the application.

Prefer:

``` dart
Theme.of(context).colorScheme.primary
```

or centralized design tokens.

------------------------------------------------------------------------

# 25. Design Token Example

``` dart
abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
}

abstract final class AppRadius {
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double full = 999;
}
```

The exact implementation may differ depending on the project's
architecture.

------------------------------------------------------------------------

# 26. UX Checklist

Before submission:

-   [ ] Login form is immediately understandable.
-   [ ] Validation messages are clear.
-   [ ] Password can be shown/hidden.
-   [ ] Customer list is easy to scan.
-   [ ] Search is easy to find.
-   [ ] Customer cards have a clear tap affordance.
-   [ ] Customer status is obvious.
-   [ ] Details are grouped logically.
-   [ ] Long details scroll correctly.
-   [ ] Empty states exist.
-   [ ] Error states exist.
-   [ ] UI does not overflow on small screens.
-   [ ] Touch targets are comfortable.
-   [ ] Colors have sufficient contrast.
-   [ ] Typography is consistent.
-   [ ] No unnecessary visual decoration.

------------------------------------------------------------------------

# 27. Recommended Final Visual Hierarchy

``` text
PRIMARY
Customer name / Screen title
        ↓
SECONDARY
Company / Important information
        ↓
TERTIARY
City / phone / metadata
        ↓
STATUS
Active / Pending / Inactive
        ↓
ACTIONS
Login / Search / Navigation
```

The final product should feel like a small, production-minded CRM
application rather than a collection of assignment screens.

<<<<<<< HEAD
# Mallie — Mall Guide App

A mobile mall guide application built with Flutter and Dart. Mallie helps shoppers find stores, search for products, navigate floor maps, and save their favorite shops — all within a clean, intuitive interface.

> **Type:** Academic/Grouped Mobile App Project
=======
# Mallie — Flutter Mall Guide App

A mobile mall guide application built with Flutter and Dart. Mallie helps shoppers find stores, search for products, navigate floor maps, and save their favorite shops — all within a clean, intuitive interface.

> **Type:** Personal / Academic Mobile App Project
>>>>>>> Test_Dev

---

## Features

<<<<<<< HEAD
| Screen | Features |
|---|---|
| **Home Screen** | Search for products with quick category filters and popular search suggestions |
| **Search Results** | Lists stores selling the searched product with floor location, price, and stock status |
| **Store Details** | Full store info including floor/store number, contact, hours, and available products |
| **Map Screen** | Floor-by-floor mall map with navigation directions to a selected store |
| **Saved Stores** | Bookmark stores for quick access later |
| **Profile Screen** | User settings including mall location, search history, and notification preferences |
| **Auth Screen** | Login and authentication flow for user accounts |
| **Splash Screen** | Branded launch screen on app startup |
| **Onboarding Screen** | First-time user walkthrough and app introduction |
| **Shop Page** | Dedicated store/shop browsing experience |
| **Quest Page** | Engagement or rewards-based quest feature |
| **Wallet Page** | In-app wallet or payment-related screen |
| **Preferences Page** | Granular user preference and settings controls |
| **Bottom Navigation** | Easy switching between Home, Map, Quest, and Profile tabs |
=======
- **Home Screen** — Search for products with quick category filters and popular search suggestions
- **Search Results** — Lists stores selling the searched product with floor location, price, and stock status
- **Store Details** — Shows full store info including floor/store number, contact, hours, and available products
- **Map Screen** — Floor-by-floor mall map with navigation directions to a selected store
- **Saved Stores** — Bookmark stores for quick access later
- **Profile Screen** — User settings including mall location, search history, and notification preferences
- **Bottom Navigation** — Easy switching between Home, Map, Saved, and Profile tabs

>>>>>>> Test_Dev
---

## Tech Stack

<<<<<<< HEAD
| Layer | Technology |
|---|---|
| Framework | Flutter |
| Language | Dart |
| UI | Material Design 3 |
| Min SDK | Flutter SDK `^3.10.8` |
=======
| | |
|-|-|
| Framework | Flutter |
| Language | Dart |
| UI | Material Design 3 |
| Min SDK | Flutter SDK ^3.10.8 |
>>>>>>> Test_Dev

---

## Getting Started

### Prerequisites
<<<<<<< HEAD

- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed
- Android Studio or VS Code with the Flutter & Dart extensions
- An emulator or physical device

### Steps

**1. Clone the repository**
```bash
git clone https://github.com/gabbslvm/Mallie.git
cd Mallie
```

**2. Switch to the development branch**
```bash
git checkout Test_Dev
```

**3. Install dependencies**
```bash
flutter pub get
```

**4. Run the app**
```bash
flutter run
```
=======
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed
- Android Studio or VS Code with the Flutter extension
- An emulator or physical device

### Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/gabbslvm/Mallie.git
   cd Mallie
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```
>>>>>>> Test_Dev

---

## Project Structure

<<<<<<< HEAD
The following outlines the full project structure.

```
Mallie/
│
├── assets/                            #   Project images and visual assets
│   └── images/
│
├── lib/                               #   All application source code
│   ├── main.dart                      #   App entry point & routing
│   ├── auth_screen.dart               #   Login / authentication screen
│   ├── mallie_splash_screen.dart      #   Splash / launch screen
│   ├── mallie_onboarding_screen.dart  #   First-time onboarding flow
│   ├── mallie_home_screen.dart        #   Home feed, search, categories
│   ├── mallie_shop_page.dart          #   Store/shop browsing page
│   ├── mallie_quest_page.dart         #   Quest / rewards feature
│   ├── mallie_wallet_page.dart        #   Wallet / payment screen
│   ├── mallie_profile_page.dart       #   User profile & settings
│   └── preferences_page.dart          #   Detailed preferences controls
│
├── pubspec.yaml                       #   Dependencies & asset declarations
├── pubspec.lock                       #   Locked dependency versions
├── analysis_options.yaml              #   Dart linting rules
├── devtools_options.yaml              #   Dart & Flutter DevTools config
│
├── android/                           #   Android platform project
├── ios/                               #   iOS platform project
├── web/                               #   Web platform support
├── linux/                             #   Linux desktop support
├── macos/                             #   macOS desktop support
├── windows/                           #   Windows desktop support
├── test/                              #   Default Flutter test directory
└── .vscode/                           #   VS Code workspace settings
```

## Screens Overview

| Screen | File | Description |
|---|---|---|
| Splash | `mallie_splash_screen.dart` | Branded app launch screen |
| Onboarding | `mallie_onboarding_screen.dart` | First-time user introduction |
| Auth | `auth_screen.dart` | Login / account authentication |
| Home | `mallie_home_screen.dart` | Search bar, category chips, popular searches |
| Shop | `mallie_shop_page.dart` | Store listing and browsing |
| Quest | `mallie_quest_page.dart` | User quests / engagement rewards |
| Wallet | `mallie_wallet_page.dart` | In-app wallet and payment details |
| Profile | `mallie_profile_page.dart` | User preferences and app settings |
| Preferences | `preferences_page.dart` | Granular notification and app controls |

---

## Design System

| Token | Value |
|---|---|
| Primary Dark Blue | `#165CA1` |
| Accent Yellow | `#F0B552` |
| Background | Light blue gradient |
| UI Framework | Material Design 3 |

---

## Branch Info

| Branch | Purpose |
|---|---|
| `Test_Dev` | Active development branch |
| `main` | Stable / release-ready builds |
=======
```
lib/
└── main.dart       # All screens and widgets (MallieApp, HomeScreen,
                    # SearchResultsScreen, StoreDetailsScreen,
                    # MapScreen, SavedScreen, ProfileScreen)
```

---

## Screens Overview

| Screen | Description |
|--------|-------------|
| `HomeScreen` | Search bar, category chips, popular searches |
| `SearchResultsScreen` | Store cards filtered by searched product |
| `StoreDetailsScreen` | Store location, products, contact, and navigation |
| `MapScreen` | Floor selector and directional map with navigation steps |
| `SavedScreen` | Saved/favorited stores list |
| `ProfileScreen` | User preferences and app settings |
>>>>>>> Test_Dev

---

## License

For academic use only.

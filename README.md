# Mallie — Flutter Mall Guide App

A mobile mall guide application built with Flutter and Dart. Mallie helps shoppers find stores, search for products, navigate floor maps, and save their favorite shops — all within a clean, intuitive interface.

> **Type:** Personal / Academic Mobile App Project

---

## Features

- **Home Screen** — Search for products with quick category filters and popular search suggestions
- **Search Results** — Lists stores selling the searched product with floor location, price, and stock status
- **Store Details** — Shows full store info including floor/store number, contact, hours, and available products
- **Map Screen** — Floor-by-floor mall map with navigation directions to a selected store
- **Saved Stores** — Bookmark stores for quick access later
- **Profile Screen** — User settings including mall location, search history, and notification preferences
- **Bottom Navigation** — Easy switching between Home, Map, Saved, and Profile tabs

---

## Tech Stack

| | |
|-|-|
| Framework | Flutter |
| Language | Dart |
| UI | Material Design 3 |
| Min SDK | Flutter SDK ^3.10.8 |

---

## Getting Started

### Prerequisites
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

---

## Project Structure

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

---

## License

For academic use only.

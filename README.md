# 📖 Lumen Reader

**Lumen Reader** is a premium, feature-rich eBook application template built with **Flutter** and **Material 3**. It offers a polished, modern user experience designed for focus, aesthetic appeal, and seamless cross-platform performance.

---

## ✨ Key Features

- **🎨 Modern Material 3 UI**: Fully utilizes Material You design principles with dynamic color support and sleek transitions.
- **📚 Immersive Reader**: A dedicated reading interface with customizable typography and themes.
- **🌗 Smart Theming**:
  - **Paper Mode**: Clean, crisp white for sunny days.
  - **Sepia Mode**: Warm tones for reduced eye strain.
  - **Night Mode**: Deep OLED-optimized blacks for late-night reading.
- **🏷️ Smart Library**: Organize books with tags, search titles/authors, and filter by category in real-time.
- **📉 Reading Progress**: Automatically saves your last read page for every book.
- **📍 Bookmarks**: Save important sections and jump back to them anytime.
- **🚀 Onboarding Experience**: A smooth, animated introduction to the app's premium features.

---

## 📸 Screen Previews

<div align="center">
  <img src="/Users/macbookpro/.gemini/antigravity/brain/68d257ad-1ec7-451f-90ef-6319022c1581/library_mockup_png_1772442660313.png" width="30%" alt="Library View" />
  <img src="/Users/macbookpro/.gemini/antigravity/brain/68d257ad-1ec7-451f-90ef-6319022c1581/reader_mockup_png_1772442729198.png" width="30%" alt="Reader View" />
  <img src="/Users/macbookpro/.gemini/antigravity/brain/68d257ad-1ec7-451f-90ef-6319022c1581/onboarding_mockup_png_1772442748204.png" width="30%" alt="Onboarding" />
</div>

---

## 🛠️ Tech Stack

- **Framework**: [Flutter](https://flutter.dev) (v3.3+)
- **State Management**: [Provider](https://pub.dev/packages/provider)
- **Navigation**: [GoRouter](https://pub.dev/packages/go_router)
- **Styling**: [Material 3](https://m3.material.io) & [Dynamic Color](https://pub.dev/packages/dynamic_color)
- **Persistence**: [Shared Preferences](https://pub.dev/packages/shared_preferences)
- **Fonts**: [Google Fonts](https://pub.dev/packages/google_fonts)

---

## 📁 Project Structure

```bash
lib/
├── app/               # Global routing, state, and theme logic
├── features/          # Feature-based modular architecture
│   ├── book_details/  # Immersive book summaries
│   ├── library/       # Core discovery & search interface
│   ├── reader/        # Customizable reading engine
│   ├── onboarding/    # Animated user introduction
│   └── ...            # Splash, settings, and profile
├── models/            # Data entities (Book, etc.)
└── widgets/           # Global reusable UI components
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK installed and configured.
- A mobile emulator or physical device.

### Installation
1.  **Generate Platforms** (if missing):
    ```bash
    flutter create .
    ```
2.  **Fetch Dependencies**:
    ```bash
    flutter pub get
    ```
3.  **Run Application**:
    ```bash
    flutter run
    ```

---

## 🎨 Customization

### Adding New Books
Navigate to `lib/models/book.dart` and add new `Book` objects to the `demoBooks` list.

### Adjusting Themes
Global theme tokens (colors, gradients, and font families) can be customized in `lib/app/theme.dart`.

---

## 📄 License
This project is for demonstration purposes. Feel free to use it as a foundation for your own beautiful Flutter apps.

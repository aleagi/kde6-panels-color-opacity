# KDE6 Panels Color & Opacity

A powerful and intuitive Plasmoid widget for KDE Plasma 6 that grants you total control over your panel's aesthetics. Transform any system panel with custom colors, precise transparency levels, and background effects to perfectly match your desktop theme.

## ✨ Features

- **Custom Color Picker**: Choose any RGBA color for your panels with a native Kirigami interface.
- **Dynamic Transparency**: Adjust opacity from 0% (fully transparent) to 100% (solid) using a precise slider.
- **Real-time Updates**: See your changes instantly across all your desktop panels.
- **Blurred Backgrounds**: Toggle the Plasma blur effect to maintain readability while keeping a glass-like aesthetic.
- **Light/Dark Mode Aware**: Automatically adjusts contrast and readability based on your system theme.
- **Multiple Panel Support**: Configure individual settings for different panels (Top, Bottom, Sidebar).

## 🛠️ Requirements

- **KDE Plasma 6.0+**
- **KDE Frameworks 6**
- **Kirigami 6** (for the configuration interface)
- **Qt 6**

## 📥 Installation

### Method 1: Easy Install (via KPackagetool)

1. Download the latest release from the [Releases](https://github.com/aleagi/kde6-panels-color-opacity/releases) page.
2. Open your terminal in the downloaded folder and run:
   ```bash
   kpackagetool6 -t Plasma/Applet -i .
   ```

### Method 2: Manual Installation

Clone this repository to your local Plasmoid directory:

```bash
mkdir -p ~/.local/share/plasma/plasmoids/
git clone https://github.com/aleagi/kde6-panels-color-opacity.git ~/.local/share/plasma/plasmoids/org.kde.panelcoloropacity
```

## 🚀 Usage

1. Right-click on any **KDE Panel**.
2. Select **"Add Widgets..."**.
3. Search for **"Panels Color & Opacity"**.
4. Drag and drop the widget onto your panel.
5. Right-click the widget icon and select **"Configure Panels Color & Opacity..."** to start customizing.

## 🏗️ Technical Architecture

This widget leverages the **Plasma 6 C++ API** and **QML** for high performance and native integration.

### Project Structure
```text
├── metadata.json       # Widget metadata (name, version, icon)
├── translate/          # Localized strings
└── contents/
    ├── ui/
    │   ├── main.qml    # Core logic and background rendering
    │   └── Config.qml  # User interface for settings
    └── code/           # Optional JavaScript helper scripts
```

## 🤝 Contributing

Contributions are welcome! If you have ideas for new features or find any bugs:

1. Fork the repository.
2. Create a feature branch (`git checkout -b feature/AmazingFeature`).
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`).
4. Push to the branch (`git push origin feature/AmazingFeature`).
5. Open a Pull Request.

## 📜 License

This project is licensed under the **GPL-3.0 License** - see the [LICENSE](LICENSE) file for details.

## 🌟 Support

If you find this widget useful, please consider giving it a ⭐ on GitHub!

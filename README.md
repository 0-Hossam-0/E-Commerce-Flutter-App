# E-Commerce Flutter App

An intuitive, feature-rich e-commerce mobile application built with **Flutter** and **Dart**, offering seamless shopping experiences with offline support, real-time updates, and modern UI/UX patterns.


---

## 🚀 Features

* **Product Catalog**: Scrollable, responsive grid displaying products with images, names, and prices.
* **Product Details**: Detailed view with descriptions, image zoom/swipe, and add-to-cart functionality.
* **Persistent Cart & Wishlist**: Powered by **Hive**, allowing offline access and data persistence.
* **Authentication**: Secure user sign-up and login flows with **Firebase Auth**.
* **Real-time Data**: Dynamic updates via **Cloud Firestore**.
* **Responsive Design**: Adaptive layouts for phones and tablets using **Sizer**.
* **Smooth Animations**: Polished transitions and interactive UI elements.

---

## 🛠 Tech Stack

* [Flutter](https://flutter.dev/) & [Dart](https://dart.dev/)
* [Hive](https://pub.dev/packages/hive) for local storage
* [firebase\_core](https://pub.dev/packages/firebase_core)
* [firebase\_auth](https://pub.dev/packages/firebase_auth)
* [cloud\_firestore](https://pub.dev/packages/cloud_firestore)
* [Sizer](https://pub.dev/packages/sizer) for responsive UI

---

## 📥 Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/0-Hossam-0/E-Commerce-Flutter-App.git
   cd E-Commerce-Flutter-App
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Configure Firebase**

   * Place your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) files in the respective platform directories.
   * Ensure `firebase_options.dart` is generated via `flutterfire configure` or manually added.

4. **Run the app**

   ```bash
   flutter run
   ```

---

## 📂 Project Structure

```
lib/
├── data/
│   ├── Cart/cart_hive.dart       # Hive model & box for cart items
│   └── Favorite/favorite_hive.dart # Hive model & box for favorite items
├── ui/
│   ├── Screens/
│   │   ├── Auth/                 # Login & registration screens
│   │   ├── Home/                 # Main product listing & details
│   │   └── Landing/              # Splash & onboarding
│   └── Widgets/                  # Reusable UI components
├── firebase_options.dart         # Firebase configuration
└── main.dart                     # App entrypoint
```

---

## 🖌️ Usage

* Launch the app on a device or simulator.
* Sign up or log in with email/password.
* Browse products, add them to cart/wishlist.
* Checkout (if implemented) or explore offline capabilities.

---

## 🤝 Contributing

1. Fork the repository
2. Create a new branch: `git checkout -b feature/YourFeature`
3. Make your changes and commit: \`git commit -m "Add YourFeature"
4. Push to your branch: `git push origin feature/YourFeature`
5. Open a Pull Request

Please ensure your code follows existing conventions and includes relevant tests/widgets.

---

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## ✉️ Contact

Created by **Hossam** – feel free to reach out via GitHub!

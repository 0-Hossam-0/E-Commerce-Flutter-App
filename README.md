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


![Screenshot_20250616-020749](https://github.com/user-attachments/assets/7043c0ce-5c52-40d6-8f91-d2044700766d)
![Screenshot_20250616-020747](https://github.com/user-attachments/assets/44b655ba-f2da-428c-8d8d-0632bb8aab0f)
![Screenshot_20250616-020744](https://github.com/user-attachments/assets/5b6946a7-c461-45b5-ae0d-80483cfdea4d)
![Screenshot_20250616-020742](https://github.com/user-attachments/assets/2ab51131-088b-4ba4-b771-b6790b7b0675)
![Screenshot_20250616-020740](https://github.com/user-attachments/assets/1fe20fb1-80ac-42e6-bfcf-9b890f802315)
![Screenshot_20250616-020735](https://github.com/user-attachments/assets/01d076b4-3f38-451c-8f95-b512a720f84d)
![Screenshot_20250616-020819](https://github.com/user-attachments/assets/69a7aff3-8a1f-4c74-8c73-6410b9f1b72e)
![Screenshot_20250616-020816](https://github.com/user-attachments/assets/0bb4e7c1-59df-4ca9-b560-607a666a5a54)
![Screenshot_20250616-020813](https://github.com/user-attachments/assets/ef1d41f3-a701-4136-90cc-ac3eda12ca30)
![Screenshot_20250616-020810](https://github.com/user-attachments/assets/1152db61-893e-4a32-854e-c5e47eac718b)
![Screenshot_20250616-020806](https://github.com/user-attachments/assets/4c879ca1-39ac-4514-8dcd-3d674628ca0d)
![Screenshot_20250616-020800](https://github.com/user-attachments/assets/20d72fd1-8019-426b-93ba-4ff46870e74b)



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

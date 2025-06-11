import 'package:e_commerce/data/Favorite/favorite_hive.dart';
import 'package:e_commerce/firebase_options.dart';
import 'package:e_commerce/ui/Screens/Home/home.dart';
import 'package:e_commerce/ui/Screens/Landing/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'data/Cart/cart_hive.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(FavoriteAdapter());
  await Hive.openBox<Product>('cartItems');
  await Hive.openBox<Favorite>('favoriteItems');

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final User? user = FirebaseAuth.instance.currentUser;
  final Widget initialScreen = (user != null)
    ? HomeScreen()
    : SplashScreen();

  runApp(MyApp(initialScreen: initialScreen));
}

class MyApp extends StatelessWidget {
  final Widget initialScreen;
  const MyApp({Key? key, required this.initialScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (_, __, ___) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: initialScreen,
      ),
    );
  }
}

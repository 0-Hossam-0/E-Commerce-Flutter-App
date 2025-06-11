import 'package:e_commerce/data/Signup/Service/auth_service.dart';
import 'package:e_commerce/ui/Screens/Home/home.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/ui/Public_Widgets/input_field.dart';
import 'package:e_commerce/ui/Public_Widgets/social_button.dart';
import 'package:e_commerce/ui/Screens/Signup/signup.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isEmailError = false;
  bool isPasswordError = false;
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    final email = _usernameController.text;
    final password = _passwordController.text;
    if (email.isEmpty) {
      setState(() {
        isEmailError = true;
      });
    } else {
      setState(() {
        isEmailError = false;
      });
    }
    if (password.isEmpty) {
      setState(() {
        isPasswordError = true;
      });
    } else {
      setState(() {
        isPasswordError = false;
      });
    }
    if (!isPasswordError && !isEmailError) {
      AuthService().signIn(email: email, password: password, context: context);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    void _signInWithGoogle() async {
      try {
        await AuthService().signInWithGoogle(context);
        ElegantNotification.success(
          width: MediaQuery.sizeOf(context).width * 0.9,
          height: 80,
          position: Alignment.topRight,
          animation: AnimationType.fromRight,
          title: const Text('Succuss'),
          description: Text('Logged in Succufully'),
        ).show(context);
      } catch (e) {
        ElegantNotification.error(
          width: MediaQuery.sizeOf(context).width * 0.9,
          height: 80,
          position: Alignment.topRight,
          animation: AnimationType.fromRight,
          title: const Text('Error'),
          description: Text('Something went wrong!'),
        ).show(context);
      }
    }

    void _signInWithFacebook() async {
      try {
        await AuthService().signInWithFacebook(context);
        ElegantNotification.success(
          width: MediaQuery.sizeOf(context).width * 0.9,
          height: 80,
          position: Alignment.topRight,
          animation: AnimationType.fromRight,
          title: const Text('Succuss'),
          description: Text('Logged in Succufully'),
        ).show(context);
      } catch (e) {
        ElegantNotification.error(
          width: MediaQuery.sizeOf(context).width * 0.9,
          height: 80,
          position: Alignment.topRight,
          animation: AnimationType.fromRight,
          title: const Text('Error'),
          description: Text('Something went wrong!'),
        ).show(context);
      }
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Center(
              child: Column(
                children: [
                  Image.asset('assets/images/login.png'),
                  Text(
                    'Login',
                    style: TextStyle(
                        color: Color(0xFF3347C4),
                        fontWeight: FontWeight.w800,
                        fontSize: 30),
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 10),
                  InputField(
                      controller: _usernameController,
                      placeholder: 'Username',
                      borderColor: isEmailError ? Colors.red : Colors.black,
                      prefixIcon: Icon(Icons.email),
                      isSecured: false),
                  SizedBox(height: 5),
                  Text(
                    isEmailError ? 'Username Input Is Wrong' : '',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 5),
                  InputField(
                      controller: _passwordController,
                      placeholder: 'Password',
                      borderColor: isPasswordError ? Colors.red : Colors.black,
                      prefixIcon: Icon(Icons.lock),
                      isSecured: true),
                  SizedBox(height: 5),
                  Text(
                    isPasswordError ? 'Password Input Is Wrong' : '',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Color(0xFF3347C4)),
                          shadowColor:
                              WidgetStateProperty.all(Color(0xFF3347C4)),
                          elevation: WidgetStateProperty.all(10),
                          fixedSize: WidgetStateProperty.all(Size(90.w, 6.h)),
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)))),
                      onPressed: _login,
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 18),
                      )),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Color(0xFFC4C4C4),
                          indent: 25.w,
                          endIndent: 10,
                          thickness: 3,
                        ),
                      ),
                      Text(
                        'Or',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF828282)),
                      ),
                      Expanded(
                        child: Divider(
                          color: Color(0xFFC4C4C4),
                          indent: 10,
                          endIndent: 25.w,
                          thickness: 3,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialButton(
                          onTapFunction: _signInWithFacebook,
                          imagePath: 'assets/images/facebook-icon.png',
                          hoverColor: Color.fromARGB(255, 65, 53, 235)),
                      SizedBox(width: 20),
                      SocialButton(
                          onTapFunction: _signInWithGoogle,
                          imagePath: 'assets/images/google-icon.png',
                          hoverColor: Color.fromARGB(255, 226, 80, 80)),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account ?",
                        style: TextStyle(
                            color: Color(0xFF828282), fontSize: 15.sp),
                      ),
                      SizedBox(width: 6),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return SignUpScreen();
                          }));
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: Color(0xFF3347C4),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

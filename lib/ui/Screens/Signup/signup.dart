import 'package:e_commerce/data/Signup/Service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/ui/Public_Widgets/input_field.dart';
import 'package:e_commerce/ui/Screens/Login/login.dart';
import 'package:sizer/sizer.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool isEmailError = false;
  bool isUsernameError = false;
  bool isPasswordError = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    void _signup() async {
      final username = _usernameController.text;
      final email = _emailController.text;
      final password = _passwordController.text;
      if (username.isEmpty) {
        setState(() {
          isUsernameError = true;
        });
      } else {
        setState(() {
          isUsernameError = false;
        });
      }
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
      if (!isEmailError && !isPasswordError && !isUsernameError) {
        setState(() {
          isLoading = true;
        });
        await AuthService().signUp(
            username: username,
            email: email,
            password: password,
            context: context);
        setState(() {
          isLoading = false;
        });
      }
    }

    return Stack(children: [
      SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Center(
                child: Column(
                  children: [
                    Image.asset('assets/images/signup.png'),
                    SizedBox(height: 20),
                    Text(
                      'Sign Up',
                      style: TextStyle(
                          color: Color(0xFF3347C4),
                          fontWeight: FontWeight.w800,
                          fontSize: 30),
                    ),
                    SizedBox(height: 20),
                    InputField(
                        borderColor: isEmailError ? Colors.red : Colors.black,
                        controller: _emailController,
                        placeholder: 'Email',
                        prefixIcon: Icon(Icons.email),
                        isSecured: false),
                    SizedBox(height: 5),
                    Text(
                      isEmailError ? 'Email Field Is Empty' : '',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 5),
                    InputField(
                        controller: _usernameController,
                        borderColor:
                            isUsernameError ? Colors.red : Colors.black,
                        placeholder: 'Username',
                        prefixIcon: Icon(Icons.person),
                        isSecured: false),
                    SizedBox(height: 5),
                    Text(
                      isUsernameError ? 'Username Field Is Empty' : '',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 5),
                    InputField(
                        borderColor:
                            isPasswordError ? Colors.red : Colors.black,
                        controller: _passwordController,
                        placeholder: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        isSecured: true),
                    SizedBox(height: 5),
                    Text(
                      isPasswordError ? 'Password Field Is Empty' : '',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(Color(0xFF3347C4)),
                            shadowColor:
                                WidgetStateProperty.all(Color(0xFF3347C4)),
                            elevation: WidgetStateProperty.all(10),
                            fixedSize: WidgetStateProperty.all(Size(90.w, 6.h)),
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)))),
                        onPressed: () => _signup(),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 18),
                        )),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account ?",
                          style: TextStyle(
                              fontSize: 15.sp, color: Color(0xFF828282)),
                        ),
                        SizedBox(width: 6),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return LoginScreen();
                            }));
                          },
                          child: Text(
                            "Login",
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
      ),
      if (isLoading)
        Container(
          color: Colors.black.withOpacity(0.8),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Color(0xFF3347C4),
                ),
                SizedBox(width: 20),
                Text(
                  'Loading...',
                  style: TextStyle(
                      color: Color(0xFF3347C4),
                      fontSize: 18,
                      decoration: TextDecoration.none),
                ),
              ],
            ),
          ),
        ),
    ]);
  }
}

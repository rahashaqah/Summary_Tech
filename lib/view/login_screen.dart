import 'package:easy_localization/easy_localization.dart';
import 'package:final_q/core/helper/responsive.dart';
import 'package:final_q/view/home_screen.dart';
import 'package:final_q/view/rest_password.dart';
import 'package:final_q/view/sign_up_screen.dart';
import 'package:final_q/widget/custom_button_widget.dart';
import 'package:final_q/widget/input_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../controller/auth_controller.dart';
import '../core/function/validation_functions.dart';
import '../core/helper/shared_preferences_helper.dart';
import '../model/user_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();
  String? _loginError;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    bool rememberMe = await _authController.isRemembered();
    _rememberMe = rememberMe;

    if (_rememberMe) {
      final user = await _authController.getUser();
      emailController.text = user.email;
      passwordController.text = user.password;
    }

    setState(() {});
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 80, left: 30, right: 30, bottom: 100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/img/logoo.png',
                        height: responsiveHeight(context, 120),
                        width: responsiveWidth(context, 200),
                      ),
                      SizedBox(height: responsiveHeight(context, 20)),
                      Card(
                        color: Colors.purple[100],
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(tr('login')
                                  ,
                                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(tr("have_account?"),
                                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                                      );
                                    },
                                    child: Text(tr("Sign_up"), style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                              SizedBox(height: responsiveHeight(context, 10)),
                              Text(tr("email"), style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
                              InputWidget(
                                textEditingController: emailController,
                                isPassword: false,
                                validator: validateEmail,
                              ),
                              SizedBox(height: responsiveHeight(context, 20)),
                              Text(tr("password"), style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
                              InputWidget(
                                textEditingController: passwordController,
                                isPassword: true,
                                validator: validatePassword,
                              ),
                              if (_loginError != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    _loginError!,
                                    style: TextStyle(color: Colors.red, fontSize: 13),
                                  ),
                                ),
                              SizedBox(height: responsiveHeight(context, 10)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Transform.scale(
                                        scale: 0.9,
                                        child: Checkbox(
                                          value: _rememberMe,
                                          onChanged: (value) {
                                            setState(() {
                                              _rememberMe = value!;
                                            });
                                          },
                                        ),
                                      ),
                                      Transform.translate(
                                        offset: Offset(-8, 0),
                                        child: Text(tr('remember_me'), style: TextStyle(fontSize: 12)),
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => RestPassword()),
                                      );
                                    },
                                    child: Text(tr('forgot_password'), style: TextStyle(fontSize: 12, color: Colors.purple)),
                                  ),
                                ],
                              ),
                              SizedBox(height: responsiveHeight(context, 10)),
                              Padding(
                                padding: const EdgeInsets.only(left: 80),
                                child: CustomButton(
                                  onPress: () async {
                                    if (_formKey.currentState!.validate()) {
                                      String enteredEmail = emailController.text.trim();
                                      String enteredPassword = passwordController.text;

                                      final savedUser = await _authController.getUser();
                                      String savedEmail = savedUser.email;
                                      String savedPassword = savedUser.password;

                                      if (enteredEmail != savedEmail || enteredPassword != savedPassword) {
                                        setState(() {
                                          _loginError = tr("email_or_password_is_incorrect");
                                        });
                                        return;
                                      }

                                      setState(() {
                                        _loginError = null;
                                      });

                                      await _authController.setRememberMe(_rememberMe);
                                      if (_rememberMe) {
                                        await _authController.saveUser(UserModel(
                                          name: savedUser.name,
                                          email: savedUser.email,
                                          password: savedUser.password,
                                        ));
                                      }

                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => Home1Screen()),
                                      );
                                    }
                                  },
                                  height: responsiveHeight(context, 50),
                                  title: tr("login"),
                                  fontWeight: FontWeight.w800,
                                  width: 100,
                                ),
                              ),
                              SizedBox(height: responsiveHeight(context, 20)),
                              Row(
                                children: [
                                  Expanded(child: Divider(thickness: 1, color: Colors.grey[400])),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: responsiveWidth(context, 10)),
                                    child: Text(tr('or'), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                  ),
                                  Expanded(child: Divider(thickness: 1, color: Colors.grey[400])),
                                ],
                              ),
                              SizedBox(height: responsiveHeight(context, 20)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleSocialButton(
                                    iconPath: 'assets/img/google.png',
                                    backgroundColor: Colors.white,
                                    onTap: () {},
                                  ),
                                  SizedBox(width: 20),
                                  CircleSocialButton(
                                    iconPath: 'assets/img/facebook.png',
                                    backgroundColor: Color(0xFF4267B2),
                                    onTap: () {},
                                  ),
                                  SizedBox(width: 20),
                                  CircleSocialButton(
                                    iconPath: 'assets/img/apple.png',
                                    backgroundColor: Colors.grey,
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircleSocialButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback onTap;
  final Color backgroundColor;

  const CircleSocialButton({
    super.key,
    required this.iconPath,
    required this.onTap,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: Ink(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color: backgroundColor.withOpacity(0.3),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Image.asset(iconPath, width: 28, height: 28),
        ),
      ),
    );
  }
}

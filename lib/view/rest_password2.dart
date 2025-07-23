import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:final_q/core/function/validation_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/helper/responsive.dart';
import '../widget/custom_button_widget.dart';
import 'login_screen.dart';


class RestPassword2 extends StatefulWidget {
  const RestPassword2({super.key});

  @override
  State<RestPassword2> createState() => _RestPassword2State();
}

class _RestPassword2State extends State<RestPassword2> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Positioned.fill(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: responsiveWidth(context, 50),
              ),
              child: Column(
                children: [
                  SizedBox(height: responsiveHeight(context, 74)),
                  Image.asset(
                    'assets/img/logoo.png',
                    width: responsiveWidth(context, 307),
                    height: responsiveHeight(context, 85),
                  ),
                  SizedBox(height: responsiveHeight(context, 46)),
                  Card(
                    color: Colors.purple[100],
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: responsiveWidth(context, 24),
                        vertical: responsiveHeight(context, 24),
                      ),

                      width: responsiveWidth(context, 343),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.keyboard_backspace_sharp,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: responsiveHeight(context, 24)),
                            Text(
                              tr("Rest Password"),
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: responsiveHeight(context, 12)),
                            Row(
                              children: [
                                Text(
                                  tr("Want to try with my current password?"),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 9,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(width: responsiveWidth(context, 4)),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    tr("login"),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.purple,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: responsiveHeight(context, 24)),
                            Text(
                              tr("New Password"),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                            SizedBox(height: responsiveHeight(context, 3)),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(fontSize: 14),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: responsiveHeight(context, 12),
                                  horizontal: responsiveWidth(context, 10),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorStyle: TextStyle(height: 0),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                              validator: validatePassword
                            ),
                            SizedBox(height: responsiveHeight(context, 16)),
                            Text(
                              tr("Confirm New Password"),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                            SizedBox(height: responsiveHeight(context, 3)),
                            TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: true,
                              decoration: InputDecoration(

                                hintStyle: TextStyle(fontSize: 14),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: responsiveHeight(context, 12),
                                  horizontal: responsiveWidth(context, 10),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorStyle: TextStyle(
                                  height: responsiveHeight(context, 0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return tr('Please confirm your password');
                                }
                                if (value != _passwordController.text) {
                                  return tr('Passwords do not match');
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: responsiveHeight(context, 24)),
                            Padding(
                              padding: const EdgeInsets.only(left: 35),
                              child: CustomButton(onPress: () {
                                if (_formKey.currentState!.validate()) {
                                  showDialog(
                                    context: context,
                                    barrierColor: Colors.black.withOpacity(
                                      0.6,
                                    ),
                                    barrierDismissible: true,
                                    builder:
                                        (context) => Stack(
                                      children: [
                                        BackdropFilter(
                                          filter: ImageFilter.blur(
                                            sigmaX: 5,
                                            sigmaY: 5,
                                          ),
                                          child: Container(
                                            color: Colors.black
                                                .withOpacity(0.3),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (context) =>
                                                    LoginScreen(),
                                              ),
                                            );
                                          },
                                          child: Center(
                                            child: Dialog(
                                              backgroundColor:
                                              Colors.transparent,
                                              child: Column(
                                                mainAxisSize:
                                                MainAxisSize.min,
                                                children: [
                                                  Image.asset(
                                                    'assets/img/b.png',
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    tr("Congratulations!"),
                                                    style: TextStyle(
                                                      color:
                                                      Colors.white,
                                                      fontSize: 24,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold,
                                                    ),
                                                  ),
                                                  SizedBox(height: 8),
                                                  Text(
                                                    tr("Password reset successfully"),
                                                    style: TextStyle(
                                                      color:
                                                      Colors
                                                          .white70,
                                                      fontSize: 16,
                                                    ),
                                                    textAlign:
                                                    TextAlign
                                                        .center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                                  height: responsiveHeight(context, 48),
                                  width: responsiveWidth(context, 190),
                                  title: tr("Update Password")),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

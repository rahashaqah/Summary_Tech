import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:final_q/core/function/validation_functions.dart';
import 'package:final_q/view/rest_password2.dart';
import 'package:flutter/material.dart';
import '../core/helper/responsive.dart';
import '../widget/custom_button_widget.dart';
import '../widget/input_widgets.dart';
import 'login_screen.dart';

class RestPassword extends StatefulWidget {
  const RestPassword({super.key});

  @override
  _RestPasswordState createState() => _RestPasswordState();
}

class _RestPasswordState extends State<RestPassword> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());


  @override
  void dispose() {
    _focusNodes.forEach((focusNode) => focusNode.dispose());
    _controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                children: [
                  SizedBox(height: responsiveHeight(context, 74)),
                  Image.asset(
                    'assets/img/logoo.png',
                    width: responsiveWidth(context, 307),
                    height: responsiveHeight(context, 100),
                  ),
                  SizedBox(height: responsiveHeight(context, 120)),
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.keyboard_backspace_sharp),
                                ),
                                Text(tr("Back to "), style: TextStyle(fontSize: 12)),
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
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.purple,
                                    ),
                                  ),
                                ),
                                Text(tr(" page?"), style: TextStyle(fontSize: 12)),
                              ],
                            ),
                            SizedBox(height: responsiveHeight(context, 24.3)),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  tr("Rest Password"),
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: responsiveHeight(context, 12)),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 24),
                                  child: Text(tr("Enter your E-mail or phone and we'll send you a link to get back into your account")
                                    ,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: responsiveHeight(context, 24)),
                            Text(
                              tr("email"),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                            SizedBox(height: responsiveHeight(context, 3)),
                            SizedBox(
                              width: responsiveWidth(context, 295),
                              child: InputWidget(textEditingController:
                                _emailController,
                                validator: validateEmail,
                                keyboardType: TextInputType.emailAddress,
                            ),
                            ),
                            SizedBox(height: responsiveHeight(context, 24)),
                            Padding(
                              padding: const EdgeInsets.only(left: 76),
                              child: CustomButton(onPress: () {
                                if (_formKey.currentState!.validate()) {
                                  showDialog(
                                    context: context,
                                    barrierColor: Colors.black.withOpacity(0.6),
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
                                            color: Colors.black.withOpacity(
                                              0.3,
                                            ),
                                          ),
                                        ),

                                        Center(
                                          child: Dialog(
                                            backgroundColor:
                                            Colors.transparent,
                                            child: Column(
                                              mainAxisSize:
                                              MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                  width: responsiveWidth(
                                                    context,
                                                    343,
                                                  ),
                                                  height: responsiveHeight(
                                                    context,
                                                    300,
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(bottom: 28),
                                                    child: Card(
                                                      color: Colors.purple[100],
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                        EdgeInsets.all(
                                                          20,
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            SizedBox(
                                                              height:
                                                              responsiveHeight(
                                                                context,
                                                                10,
                                                              ),
                                                            ),
                                                            Text(
                                                              tr("4-digit"),
                                                              style: TextStyle(
                                                                  color: Colors.black,fontSize: 14),
                                                              textAlign: TextAlign.center,

                                                            ),
                                                            SizedBox(
                                                              height:
                                                              responsiveHeight(
                                                                context,
                                                                24,
                                                              ),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                              children:
                                                              List.generate(
                                                                4,
                                                                    (index) {
                                                                  return _buildTextField1(
                                                                    index,
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                              responsiveHeight(
                                                                context,
                                                                24,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(left: 75),
                                                              child: SizedBox(
                                                                width:
                                                                responsiveHeight(
                                                                  context,
                                                                  100,
                                                                ),
                                                                height:
                                                                responsiveHeight(
                                                                  context,
                                                                  48,
                                                                ),
                                                                child: ElevatedButton(
                                                                  style: ElevatedButton.styleFrom(
                                                                    backgroundColor:
                                                                    Colors.purple,
                                                                    shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                      BorderRadius.circular(
                                                                        10,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  onPressed: () {
                                                                    Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (
                                                                            context,
                                                                            ) =>
                                                                            RestPassword2(),
                                                                      ),
                                                                    );
                                                                  },
                                                                  child: Text(
                                                                    tr("Verify"),
                                                                    style: TextStyle(
                                                                      fontSize:
                                                                      14,
                                                                      color:
                                                                      Colors
                                                                          .white,
                                                                    ),
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
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                                  height: responsiveHeight(context, 50),width: responsiveWidth(context, 100), title: tr("Send")),
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
        ],
      ),
    );
  }
  Widget _buildTextField1(int index) {
    return SizedBox(
      width: responsiveWidth(context, 50),
      height: responsiveHeight(context, 46),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        maxLength: 1,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 3) {
            FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
          }

          if (value.isEmpty && index > 0) {
            FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
          }
        },
      ),
    );
  }
}



import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../controller/auth_controller.dart';
import '../core/function/validation_functions.dart';
import '../core/helper/responsive.dart';
import '../core/helper/shared_preferences_helper.dart';
import '../model/user_model.dart';
import '../widget/custom_button_widget.dart';
import '../widget/date_input_widget.dart';
import '../widget/input_widgets.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final AuthController _authController = AuthController();
  String? selectedDate;
  bool isValid = false;
  String searchQuery = "";
  bool showError = false;

  _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(tr('signUp_successful'))));
      await SharedPreferencesHelper().savePrefBool(
        key: 'isLoggedIn',
        value: true,
      );
      await _authController.saveUser(
        UserModel(
          name: fullNameController.text,
          email: emailController.text,
          password: passwordController.text,
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr("Please_fill_all_fields_correctly"))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 80,
                  left: 30,
                  right: 30,
                  bottom: 100,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/img/logoo.png',
                        height: responsiveHeight(context, 85),
                        width: responsiveWidth(context, 307),
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
                              IconButton(
                                icon: Icon(Icons.arrow_back),
                                onPressed: () => Navigator.pop(context),
                              ),
                              Text(
                                tr('Sign_up'),
                                style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(tr("already_have_account")),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => LoginScreen()),
                                      );
                                    },
                                    child: Text(
                                      tr("login"),
                                      style: TextStyle(color: Colors.purple),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                tr("Full Name"),
                                style: TextStyle(color: Colors.black),
                              ),
                              InputWidget(
                                textEditingController: fullNameController,
                                isPassword: false,
                                validator: validateName,
                              ),
                              SizedBox(height: responsiveHeight(context, 10)),
                              Text(
                                tr("email"),
                                style: TextStyle(color: Colors.black),
                              ),
                              InputWidget(
                                textEditingController: emailController,
                                isPassword: false,
                                keyboardType: TextInputType.emailAddress,
                                validator: validateEmail,
                              ),
                              SizedBox(height: responsiveHeight(context, 10)),
                              Text(
                                tr("Barth_Of_Data"),
                                style: TextStyle(color: Colors.black),
                              ),
                              DateInputWidget(
                                controller: dateController,
                                suffixIcon: Icon(Icons.calendar_today_outlined),
                                validator: validateDOB,
                              ),
                              SizedBox(height: responsiveHeight(context, 10)),
                              Text(
                                tr("Set_Password"),
                                style: TextStyle(color: Colors.black),
                              ),
                              InputWidget(
                                textEditingController: passwordController,
                                isPassword: true,
                                validator: validatePassword,
                              ),
                              SizedBox(height: responsiveHeight(context, 15)),
                              Padding(
                                padding: const EdgeInsets.only(left: 70),
                                child: CustomButton(
                                  onPress: () async {
                                    _submitForm();
                                  },
                                  width: responsiveWidth(context, 120),
                                  height: responsiveHeight(context, 50),
                                  title: tr("register"),
                                ),
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
          ),
        ],
      ),
    );
  }
}

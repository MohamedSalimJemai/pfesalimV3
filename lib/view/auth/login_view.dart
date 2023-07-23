import 'package:flutter/material.dart';
import 'package:pfe_salim/view/auth/forgot_password/forgot_first_view.dart';
import 'package:pfe_salim/view/splash_screen.dart';

import '../../api/view_model/auth_view_model.dart';
import '../../utils/api_view_handler.dart';
import '../../utils/language/localization.dart';
import '../../utils/theme/theme_styles.dart';
import '../../utils/user_session.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // API
  AuthViewModel authViewModel = AuthViewModel();

  // UI
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  late TextEditingController emailTFController = TextEditingController();
  late TextEditingController passwordTFController = TextEditingController();

  bool passwordIsInvisible = true;

  void login() {
    ApiViewHandler.handleApiCallWithAlert(
      context: context,
      apiCall: () => authViewModel.login(
          email: emailTFController.text.toLowerCase(),
          password: passwordTFController.text),
      successFunction: () {
        UserSession.instance
            .saveUserSession(authViewModel.apiResponse.data!)
            .then(
              (value) => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const SplashScreen()),
                (Route<dynamic> route) => false,
              ),
            );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Colors.black,
      body: Form(
        key: _keyForm,
        child: Center(
          child: Scrollbar(
            controller: _scrollController,
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("assets/images/logo.png",
                        width: 200, height: 200),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: emailTFController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.alternate_email),
                        labelText: intl.email,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (String? value) {
                        RegExp regex = RegExp(
                            r"^[a-zA-Z0-9a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                        if (value!.isEmpty) {
                          return intl.inputControl(intl.email);
                        } else if (!regex.hasMatch(value)) {
                          return intl.inputControlInvalid(intl.email);
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: passwordTFController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: passwordIsInvisible
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                          onPressed: () => setState(
                              () => passwordIsInvisible = !passwordIsInvisible),
                        ),
                        labelText: intl.password,
                        hintStyle: const TextStyle(),
                      ),
                      obscureText: passwordIsInvisible,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return intl.inputControl(intl.password);
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        if (_keyForm.currentState!.validate()) {
                          _keyForm.currentState!.save();
                          login();
                        }
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                          Text(
                            intl.login,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotFirstView(),
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            const MaterialStatePropertyAll(Colors.transparent),
                        foregroundColor:
                            MaterialStatePropertyAll(Styles.primaryColor),
                      ),
                      child: Text(intl.forgotPassword),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

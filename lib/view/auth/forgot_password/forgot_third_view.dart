import 'package:flutter/material.dart';
import 'package:pfe_salim/utils/language/localization.dart';
import 'package:pfe_salim/view/auth/login_view.dart';

import '../../../api/view_model/auth_view_model.dart';
import '../../../utils/alert_utils.dart';
import '../../../utils/api_view_handler.dart';
import '../../../utils/dimensions.dart';

class ForgotThirdView extends StatefulWidget {
  final String token;

  const ForgotThirdView({
    super.key,
    required this.token,
  });

  @override
  State<ForgotThirdView> createState() => _ForgotThirdViewState();
}

class _ForgotThirdViewState extends State<ForgotThirdView> {
  // API
  AuthViewModel authViewModel = AuthViewModel();

  // UI
  final ScrollController _scrollController = ScrollController();

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final TextEditingController passwordTEController = TextEditingController();
  final TextEditingController passwordConfirmationTEController =
      TextEditingController();

  bool passwordIsInvisible = true;

  void resetPassword() {
    ApiViewHandler.handleApiCallWithAlert(
      context: context,
      apiCall: () => authViewModel.resetPassword(
        token: widget.token,
        plainPassword: passwordTEController.text,
      ),
      successFunction: () {
        AlertMaker.showSingleActionAlertDialog(
          context: context,
          title: intl.success,
          content: intl.passwordEdited,
          action: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginView()),
            (Route<dynamic> route) => false,
          ),
          isSuccess: true,
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
      body: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: Dimensions.bigPadding,
            child: Form(
              key: _keyForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Text(
                    intl.resetCodeCaps,
                    style: const TextStyle(
                        fontSize: 45, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    intl.resetCodeTip,
                    style: const TextStyle(fontSize: 25),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    intl.resetCodeTipAlt,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 100),
                  Text(
                    intl.doubleDotPlaceholder(intl.password),
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: passwordTEController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_open_outlined),
                      suffixIcon: IconButton(
                        icon: passwordIsInvisible
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                        onPressed: () => setState(
                            () => passwordIsInvisible = !passwordIsInvisible),
                      ),
                      labelText: intl.hint(intl.password),
                    ),
                    obscureText: passwordIsInvisible,
                    validator: (String? value) {
                      if (value!.isEmpty || value.length < 5) {
                        return intl.inputControlInvalid(intl.password);
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 25),
                  Text(
                    intl.inputControl(intl.passwordConfirmation),
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: passwordConfirmationTEController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_open_outlined),
                      suffixIcon: IconButton(
                        icon: passwordIsInvisible
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                        onPressed: () => setState(
                            () => passwordIsInvisible = !passwordIsInvisible),
                      ),
                      labelText: intl.hint(intl.passwordConfirmation),
                    ),
                    obscureText: passwordIsInvisible,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return intl.inputControl(intl.confirmation);
                      }

                      if (value != passwordTEController.text) {
                        return intl.inputControlInvalid(intl.confirmation);
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(120, 40)),
                      onPressed: () {
                        if (_keyForm.currentState!.validate()) {
                          _keyForm.currentState!.save();
                          resetPassword();
                        }
                      },
                      child: Text(intl.next),
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

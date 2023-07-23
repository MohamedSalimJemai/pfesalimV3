import 'package:flutter/material.dart';
import 'package:pfe_salim/view/auth/forgot_password/forgot_third_view.dart';

import '../../../api/view_model/auth_view_model.dart';
import '../../../utils/api_view_handler.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/language/localization.dart';

class ForgotSecondView extends StatefulWidget {
  final String token;

  const ForgotSecondView({
    super.key,
    required this.token,
  });

  @override
  State<ForgotSecondView> createState() => _ForgotSecondViewState();
}

class _ForgotSecondViewState extends State<ForgotSecondView> {
  // API
  AuthViewModel authViewModel = AuthViewModel();

  // UI
  final ScrollController _scrollController = ScrollController();

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final TextEditingController resetCodeTFController = TextEditingController();

  void submit() {
    if (_keyForm.currentState!.validate()) {
      _keyForm.currentState!.save();
    } else {
      return;
    }

    ApiViewHandler.handleApiCallWithAlert(
      context: context,
      apiCall: () => authViewModel.verifyResetPasswordToken(
        resetCode: resetCodeTFController.text,
        token: widget.token,
      ),
      successFunction: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ForgotThirdView(token: widget.token),
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
                    intl.doubleDotPlaceholder(intl.resetCode),
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: resetCodeTFController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.numbers),
                      labelText: intl.hint(intl.resetCode),
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return intl.inputControl(intl.resetCode);
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(120, 40)),
                      onPressed: () => submit(),
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

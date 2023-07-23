import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pfe_salim/api/view_model/auth_view_model.dart';
import 'package:pfe_salim/view/auth/forgot_password/forgot_second_view.dart';

import '../../../utils/api_view_handler.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/language/localization.dart';

class ForgotFirstView extends StatefulWidget {
  const ForgotFirstView({Key? key}) : super(key: key);

  @override
  State<ForgotFirstView> createState() => _ForgotFirstViewState();
}

class _ForgotFirstViewState extends State<ForgotFirstView> {
  // API
  AuthViewModel authViewModel = AuthViewModel();

  // UI
  final ScrollController _scrollController = ScrollController();

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final TextEditingController emailTFController = TextEditingController();

  void sendConfirmationCode() {
    ApiViewHandler.handleApiCallWithAlert(
      context: context,
      apiCall: () => authViewModel.forgotPassword(
        email: emailTFController.text,
      ),
      successFunction: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ForgotSecondView(
            token: authViewModel.apiResponse.data,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context) as AppLocalizations;

    return Scaffold(
      appBar: AppBar(title: Text(intl.resetPassword)),
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
                    intl.resetYourPasswordCaps,
                    style: const TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    intl.resetYourPasswordTip,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Text(
                    intl.fieldDescription(intl.email),
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: emailTFController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.alternate_email),
                      labelText: intl.hint(intl.yourEmail),
                    ),
                    validator: (String? value) {
                      RegExp regex = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                      if (value!.isEmpty) {
                        return intl.inputControl(intl.email);
                      } else if (!regex.hasMatch(value)) {
                        return localization.inputControlInvalid(intl.email);
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_keyForm.currentState!.validate()) {
                          _keyForm.currentState!.save();
                          sendConfirmationCode();
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

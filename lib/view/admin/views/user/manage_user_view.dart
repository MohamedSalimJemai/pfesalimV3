import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pfe_salim/api/view_model/user_view_model.dart';
import 'package:pfe_salim/utils/alert_utils.dart';
import 'package:pfe_salim/utils/api_view_handler.dart';
import 'package:pfe_salim/utils/file_manager.dart';
import 'package:pfe_salim/utils/language/localization.dart';
import 'package:pfe_salim/view/widgets/api_image_widget.dart';

import '../../../../../model/user.dart';

class ManageUserView extends StatefulWidget {
  final UserViewModel userViewModel;
  final bool isEdit;

  const ManageUserView({
    Key? key,
    required this.userViewModel,
    required this.isEdit,
  }) : super(key: key);

  @override
  State<ManageUserView> createState() => _ManageUserViewState();
}

class _ManageUserViewState extends State<ManageUserView> {
  // UI
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailTFController;
  late TextEditingController _passwordTFController;
  late TextEditingController _firstNameTFController;
  late TextEditingController _lastNameTFController;

  // VARIABLES
  String? _imageFilename;
  User? user;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) user = widget.userViewModel.item;

    _firstNameTFController = TextEditingController(
      text: user?.firstname ?? '',
    );
    _lastNameTFController = TextEditingController(
      text: user?.lastname ?? '',
    );
    _emailTFController = TextEditingController(
      text: user?.email ?? '',
    );
    _passwordTFController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameTFController.dispose();
    _lastNameTFController.dispose();
    _emailTFController.dispose();
    _passwordTFController.dispose();
    super.dispose();
  }

  void addOrUpdate() {
    if (_formKey.currentState!.validate()) {
      User newUser = User(
        id: user?.id ?? -1,
        email: _emailTFController.text,
        firstname: _firstNameTFController.text,
        lastname: _lastNameTFController.text,
      );

      if (user == null) newUser.plainPassword = _passwordTFController.text;
      if (_imageFilename == null) {
        AlertMaker.showSimpleAlertDialog(
          context: context,
          title: intl.warning,
          content: intl.youDidntChooseAnyMedia,
          isWarning: true,
        );
        return;
      }

      ApiViewHandler.handleApiCallWithAlert(
        context: context,
        apiCall: () => user == null
            ? widget.userViewModel.add(
                user: newUser,
                imageFilePath: _imageFilename!,
              )
            : widget.userViewModel.update(
                user: newUser,
                imageFilePath: _imageFilename,
              ),
        successFunction: () => Navigator.of(context).pop(),
      );
    }
  }

  void _selectImage() {
    FileManager.pickImage(context).then((value) {
      setState(() => _imageFilename = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user == null ? 'Add User' : 'Edit User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 300,
                  width: 300,
                  child: user?.imageFilename != null
                      ? ApiImageWidget(
                          imageFilename: user?.imageFilename,
                          isCircular: true,
                        )
                      : _imageFilename != null
                          ? CircleAvatar(
                              foregroundImage: FileImage(
                                File(_imageFilename!),
                              ),
                            )
                          : const CircleAvatar(
                              foregroundImage: AssetImage(
                                "assets/images/no-profile-pic.png",
                              ),
                            ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _selectImage,
                  child: const Text('Select Image'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _firstNameTFController,
                  decoration: const InputDecoration(labelText: 'First Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a first name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _lastNameTFController,
                  decoration: const InputDecoration(labelText: 'Last Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a last name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailTFController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    // You can add additional email validation logic here
                    return null;
                  },
                ),
                if (user == null) const SizedBox(height: 20),
                if (user == null)
                  StatefulBuilder(
                    builder: (context, setTFState) {
                      late bool showPassword = false;

                      return TextFormField(
                        controller: _passwordTFController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: !showPassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setTFState(() => showPassword = !showPassword);
                            },
                            icon: Icon(showPassword
                                ? Icons.visibility
                                : Icons
                                    .visibility_off), // Show different icons based on password visibility
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          // You can add additional password validation logic here
                          return null;
                        },
                      );
                    },
                  ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.maxFinite,
                  child: FilledButton(
                    onPressed: () => addOrUpdate(),
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pfe_salim/api/view_model/user_view_model.dart';
import 'package:pfe_salim/utils/alert_utils.dart';
import 'package:pfe_salim/utils/api_view_handler.dart';
import 'package:pfe_salim/utils/language/localization.dart';
import 'package:pfe_salim/view/admin/views/user/manage_user_view.dart';
import 'package:provider/provider.dart';

import '../../../../../model/user.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../api/response/status.dart';
import '../../../../utils/theme/theme_styles.dart';
import '../../../widgets/api_image_widget.dart';
import '../../../widgets/custom_error_widget.dart';
import '../../../widgets/loading_widget.dart';

class UserDetailsView extends StatelessWidget {
  final User user;

  const UserDetailsView({
    super.key,
    required this.user,
  });

  void delete(BuildContext context) {
    UserViewModel userViewModel = UserViewModel();

    AlertMaker.showActionAlertDialog(
      context: context,
      title: intl.confirmation,
      content: intl.deleteConfirmation(intl.user),
      positiveAction: () => ApiViewHandler.handleApiCallWithAlert(
        context: context,
        apiCall: () => userViewModel.delete(id: user.id),
        successFunction: () => Navigator.of(context).pop(),
      ),
      negativeAction: () {},
      positiveActionTitle: intl.yes,
      negativeActionTitle: intl.no,
      isDanger: true,
    );
  }

  void edit(BuildContext context, UserViewModel userViewModel) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ManageUserView(
          userViewModel: userViewModel,
          isEdit: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // API
    UserViewModel userViewModel = UserViewModel();
    userViewModel.setItem(item: user, notifyChanges: false);

    return Scaffold(
      appBar: AppBar(title: Text("${intl.user} ${intl.details}")),
      body: Container(
        width: double.maxFinite,
        padding: Dimensions.mediumPadding,
        child: ChangeNotifierProvider<UserViewModel>(
          create: (context) => userViewModel,
          child: Consumer<UserViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.apiResponse.status == Status.completed) {
                return _buildUserDetailsWidget(
                  context: context,
                  userViewModel: viewModel,
                  user: viewModel.item,
                );
              } else if (viewModel.apiResponse.status == Status.loading) {
                return const LoadingWidget();
              } else {
                return const CustomErrorWidget();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildUserDetailsWidget({
    required BuildContext context,
    required UserViewModel userViewModel,
    required User user,
  }) {
    return SingleChildScrollView(
      child: Card(
        margin: const EdgeInsets.all(5),
        shape: const RoundedRectangleBorder(
          borderRadius: Dimensions.roundedBorderBig,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30),
              ApiImageWidget(
                height: 150,
                width: 150,
                imageFilename: user.imageFilename,
                isCircular: true,
              ),
              const SizedBox(height: 30),
              Text(
                "${intl.doubleDotPlaceholder(intl.id)} "
                "${user.id}",
              ),
              const SizedBox(height: 10),
              Text(
                "${intl.doubleDotPlaceholder(intl.email)} "
                "${user.email}",
              ),
              const SizedBox(height: 10),
              Text(
                "${intl.doubleDotPlaceholder(intl.firstname)} "
                "${user.firstname}",
              ),
              const SizedBox(height: 10),
              Text(
                "${intl.doubleDotPlaceholder(intl.lastname)} "
                "${user.lastname}",
              ),
              const SizedBox(height: 50),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: FilledButton.tonalIcon(
                      onPressed: () => edit(
                        context,
                        userViewModel,
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          warningColor.withOpacity(0.2),
                        ),
                        foregroundColor: const MaterialStatePropertyAll(
                          warningColor,
                        ),
                      ),
                      label: Text(intl.edit),
                      icon: const Icon(Icons.edit),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FilledButton.tonalIcon(
                      onPressed: () => delete(context),
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          dangerColor.withOpacity(0.2),
                        ),
                        foregroundColor: const MaterialStatePropertyAll(
                          dangerColor,
                        ),
                      ),
                      label: Text(intl.delete),
                      icon: const Icon(
                        Icons.delete,
                        color: dangerColor,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

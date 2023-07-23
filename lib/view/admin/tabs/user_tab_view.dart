import 'package:flutter/material.dart';
import 'package:pfe_salim/view/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

import '../../../../../api/response/status.dart';
import '../../../../../api/view_model/user_view_model.dart';
import '../../../utils/language/localization.dart';
import '../../widgets/custom_error_widget.dart';
import '../views/user/manage_user_view.dart';
import '../views/user/user_details_view.dart';
import '../widgets/user/user_widget.dart';

class UserTabView extends StatefulWidget {
  const UserTabView({Key? key}) : super(key: key);

  @override
  State<UserTabView> createState() => _UserTabViewState();
}

class _UserTabViewState extends State<UserTabView>
    with AutomaticKeepAliveClientMixin<UserTabView> {
  @override
  bool get wantKeepAlive => true;

  // API
  UserViewModel userViewModel = UserViewModel();

  // UI
  final ScrollController _scrollController = ScrollController();

  // METHODS

  Future<void> loadData({bool withoutLoading = false}) async {
    await userViewModel.getAll(withoutLoading: withoutLoading);
  }

  // LIFECYCLE

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => loadData(),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      intl.listPlaceholder(intl.user.toLowerCase()),
                      softWrap: true,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  IconButton(
                    onPressed: () => loadData(),
                    icon: const Icon(Icons.refresh),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context)
                        .push(
                          MaterialPageRoute(
                            builder: (context) => ManageUserView(
                              userViewModel: userViewModel,
                              isEdit: false,
                            ),
                          ),
                        )
                        .whenComplete(
                          () => loadData(withoutLoading: true),
                        ),
                    icon: const Icon(Icons.add),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ChangeNotifierProvider(
                create: (context) => userViewModel,
                child: Consumer<UserViewModel>(
                  builder: (context, viewModel, child) {
                    if (viewModel.apiResponse.status == Status.completed) {
                      return viewModel.itemList.isEmpty
                          ? Center(child: Text(intl.noContent))
                          : Scrollbar(
                              controller: _scrollController,
                              child: ListView.builder(
                                controller: _scrollController,
                                padding: const EdgeInsets.only(
                                  left: 15,
                                  right: 15,
                                  top: 10,
                                  bottom: 50,
                                ),
                                itemCount: viewModel.itemList.length,
                                itemBuilder: (context, index) {
                                  final user = viewModel.itemList[index];
                                  return UserWidget(
                                    user: user,
                                    tapAction: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UserDetailsView(
                                          key: Key(user.id.toString()),
                                          user: user,
                                        ),
                                      ),
                                    ).whenComplete(
                                      () => loadData(withoutLoading: true),
                                    ),
                                  );
                                },
                              ),
                            );
                    } else if (viewModel.apiResponse.status == Status.loading) {
                      return const LoadingWidget();
                    } else {
                      return CustomErrorWidget(tapFunction: () => loadData());
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

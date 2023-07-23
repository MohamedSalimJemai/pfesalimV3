import 'package:flutter/material.dart';
import 'package:pfe_salim/utils/language/localization.dart';
import 'package:pfe_salim/view/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

import '../../../../../api/response/status.dart';
import '../../../api/view_model/line_view_model.dart';
import '../../widgets/custom_error_widget.dart';
import '../views/line/line_details_view.dart';
import '../widgets/line/line_widget.dart';

class LinesTabView extends StatefulWidget {
  const LinesTabView({Key? key}) : super(key: key);

  @override
  State<LinesTabView> createState() => _LinesTabViewState();
}

class _LinesTabViewState extends State<LinesTabView>
    with AutomaticKeepAliveClientMixin<LinesTabView> {
  @override
  bool get wantKeepAlive => true;

  // API
  LineViewModel lineViewModel = LineViewModel();

  // UI
  final ScrollController _scrollController = ScrollController();

  // METHODS

  Future<void> loadData({bool withoutLoading = false}) async {
    await lineViewModel.getAll(withoutLoading: withoutLoading);
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
                      intl.listPlaceholder(intl.line.toLowerCase()),
                      softWrap: true,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  IconButton(
                    onPressed: () => loadData(),
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ChangeNotifierProvider(
                create: (context) => lineViewModel,
                child: Consumer<LineViewModel>(
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
                                  final line = viewModel.itemList[index];
                                  return LineWidget(
                                    line: line,
                                    tapAction: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LineDetailsView(
                                          key: Key(line.id.toString()),
                                          line: line,
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

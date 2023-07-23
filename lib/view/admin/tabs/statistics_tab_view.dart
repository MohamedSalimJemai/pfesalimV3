import 'package:flutter/material.dart';
import 'package:pfe_salim/utils/language/localization.dart';
import 'package:pfe_salim/view/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

import '../../../../../api/response/status.dart';
import '../../../api/view_model/statistic_view_model.dart';
import '../../widgets/custom_error_widget.dart';
import '../views/statistic/statistic_details_view.dart';
import '../widgets/statistic/statistic_widget.dart';

class StatisticsTabView extends StatefulWidget {
  const StatisticsTabView({Key? key}) : super(key: key);

  @override
  State<StatisticsTabView> createState() => _StatisticsTabViewState();
}

class _StatisticsTabViewState extends State<StatisticsTabView>
    with AutomaticKeepAliveClientMixin<StatisticsTabView> {
  @override
  bool get wantKeepAlive => true;

  // API
  StatisticViewModel statisticViewModel = StatisticViewModel();

  // UI
  final ScrollController _scrollController = ScrollController();

  // METHODS

  Future<void> loadData({bool withoutLoading = false}) async {
    await statisticViewModel.getAll(withoutLoading: withoutLoading);
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
                      intl.listPlaceholder(intl.statistic.toLowerCase()),
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
                create: (context) => statisticViewModel,
                child: Consumer<StatisticViewModel>(
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
                                  final statistic = viewModel.itemList[index];
                                  return StatisticWidget(
                                    statistic: statistic,
                                    tapAction: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            StatisticDetailsView(
                                          key: Key(statistic.id.toString()),
                                          statistic: statistic,
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

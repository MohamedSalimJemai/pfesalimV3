import '../../model/statistic.dart';
import '../repository/statistic_repository.dart';
import '../response/api_response.dart';
import 'base_view_model.dart';

class StatisticViewModel extends BaseViewModel<Statistic> {
  @override
  Future<ApiResponse> getAll({bool withoutLoading = false}) async {
    return await makeApiCall(
      apiCall: () => StatisticRepository.getAll(),
      withoutLoading: withoutLoading,
    );
  }

  Future<ApiResponse> add({required Statistic statistic}) async {
    return await makeApiCall(apiCall: () => StatisticRepository.add(statistic));
  }

  Future<ApiResponse> update({required Statistic statistic}) async {
    return await makeApiCall(
      apiCall: () => StatisticRepository.update(statistic),
    );
  }

  Future<ApiResponse> delete({required int id}) async {
    return await makeApiCall(apiCall: () => StatisticRepository.delete(id));
  }
}

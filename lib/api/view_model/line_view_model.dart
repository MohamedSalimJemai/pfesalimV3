import '../../model/line.dart';
import '../repository/line_repository.dart';
import '../response/api_response.dart';
import 'base_view_model.dart';

class LineViewModel extends BaseViewModel<Line> {
  @override
  Future<ApiResponse> getAll({bool withoutLoading = false}) async {
    return await makeApiCall(
      apiCall: () => LineRepository.getAll(),
      withoutLoading: withoutLoading,
    );
  }

  Future<ApiResponse> add({required Line line}) async {
    return await makeApiCall(apiCall: () => LineRepository.add(line));
  }

  Future<ApiResponse> update({required Line line}) async {
    return await makeApiCall(apiCall: () => LineRepository.update(line));
  }

  Future<ApiResponse> delete({required int id}) async {
    return await makeApiCall(apiCall: () => LineRepository.delete(id));
  }
}

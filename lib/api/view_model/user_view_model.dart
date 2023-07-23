import '../../model/user.dart';
import '../repository/user_repository.dart';
import '../response/api_response.dart';
import 'base_view_model.dart';

class UserViewModel extends BaseViewModel<User> {
  @override
  Future<ApiResponse> getAll({bool withoutLoading = false}) async {
    return await makeApiCall(
      apiCall: () => UserRepository.getAll(),
      withoutLoading: withoutLoading,
    );
  }

  Future<ApiResponse> getById({required int id}) async {
    return await makeApiCall(apiCall: () => UserRepository.getById(id));
  }

  Future<ApiResponse> add({
    required User user,
    required String imageFilePath,
  }) async {
    return await makeApiCall(
        apiCall: () => UserRepository.add(user, imageFilePath));
  }

  Future<ApiResponse> update({
    required User user,
    required String? imageFilePath,
  }) async {
    return await makeApiCall(
      apiCall: () => UserRepository.update(user, imageFilePath),
    );
  }

  Future<ApiResponse> delete({required int id}) async {
    return await makeApiCall(apiCall: () => UserRepository.delete(id));
  }
}

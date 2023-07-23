import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:pfe_salim/api/response/api_response.dart';

import '../../model/user.dart';
import '../repository/auth_repository.dart';
import 'base_view_model.dart';

class AuthViewModel extends BaseViewModel<User> {
  Future<ApiResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await AuthRepository.login(email: email, password: password);
      setApiResponse(ApiResponse.completed(data: user));
    } catch (e, stackTrace) {
      log('Network error : $e');
      if (kDebugMode) print(stackTrace);
      setApiResponse(ApiResponse.error(message: e.toString()));
    }

    return apiResponse;
  }

  Future<ApiResponse> forgotPassword({required String email}) async {
    return await makeApiCall(
      apiCall: () => AuthRepository.forgotPassword(
        email: email,
      ),
    );
  }

  Future<ApiResponse> verifyResetPasswordToken({
    required String resetCode,
    required String token,
  }) async {
    return await makeApiCall(
      apiCall: () => AuthRepository.verifyResetPasswordToken(
        resetCode: resetCode,
        token: token,
      ),
    );
  }

  Future<ApiResponse> resetPassword({
    required String token,
    required String plainPassword,
  }) async {
    return await makeApiCall(
      apiCall: () => AuthRepository.resetPassword(
        token: token,
        plainPassword: plainPassword,
      ),
    );
  }
}

import 'package:pfe_salim/utils/user_session.dart';

import '../../env.dart';
import '../../model/user.dart';
import '../../utils/token_manager.dart';
import '../network/api_service.dart';
import '../network/http_method.dart';

class AuthRepository {
  static const String apiUrl = '$baseUrl/auth';

  static Future<User> login({
    required String email,
    required String password,
  }) async {
    final Map<String, dynamic> json = await ApiService.instance.sendRequest(
      url: "$apiUrl/login",
      httpMethod: HttpMethod.post,
      body: {
        "email": email.toLowerCase().replaceAll(" ", ""),
        "password": password,
      },
      authIsRequired: false,
    );

    final user = User.fromJson(json["data"]["user"]);
    await TokenManager.saveToken(json["data"]["token"]);
    await UserSession.instance.saveUserSession(user);

    return user;
  }

  static Future<String> forgotPassword({required String email}) async {
    final Map<String, dynamic> json = await ApiService.instance.sendRequest(
      url: "$apiUrl/forgot-password/send-email",
      httpMethod: HttpMethod.post,
      body: {'email': email.toLowerCase().replaceAll(" ", "")},
      authIsRequired: false,
    );

    return json["data"]["token"];
  }

  static Future<bool> verifyResetPasswordToken({
    required String resetCode,
    required String token,
  }) async {
    await ApiService.instance.sendRequest(
      url: "$apiUrl/forgot-password/validate-token",
      httpMethod: HttpMethod.post,
      body: {
        'resetCode': resetCode,
        'token': token,
      },
      authIsRequired: false,
    );

    return true;
  }

  static Future<bool> resetPassword({
    required String token,
    required String plainPassword,
  }) async {
    await ApiService.instance.sendRequest(
      url: "$apiUrl/forgot-password/new-password",
      httpMethod: HttpMethod.post,
      body: {
        'token': token,
        'plainPassword': plainPassword,
      },
      authIsRequired: false,
    );

    return true;
  }
}

import '../../env.dart';
import '../../model/user.dart';
import '../network/api_service.dart';
import '../network/http_method.dart';

class UserRepository {
  static const String apiUrl = "$baseUrl/api/users";

  static Future<List<User>> getAll() async {
    final Map<String, dynamic> json = await ApiService.instance.sendRequest(
      url: apiUrl,
      httpMethod: HttpMethod.get,
      authIsRequired: true,
    );

    return List<User>.from(
      (json["data"] as List<dynamic>).map((model) => User.fromJson(model)),
    );
  }

  static Future<User> getById(int id) async {
    final Map<String, dynamic> json = await ApiService.instance.sendRequest(
      url: "$apiUrl/$id",
      httpMethod: HttpMethod.get,
      authIsRequired: true,
    );

    return User.fromJson(json["data"]);
  }

  static Future<User> add(User user, String imageFilePath) async {
    final Map<String, dynamic> json =
        await ApiService.instance.sendMultipartRequest(
      url: apiUrl,
      httpMethod: HttpMethod.post,
      body: user.toJson(),
      multipartParamName: 'image',
      filesPathList: [imageFilePath],
      authIsRequired: true,
    );

    return User.fromJson(json["data"]);
  }

  static Future<User> update(User user, String? imageFilePath) async {
    final Map<String, dynamic> json =
        await ApiService.instance.sendMultipartRequest(
      url: "$apiUrl/${user.id}",
      httpMethod: HttpMethod.post,
      body: user.toJson(),
      multipartParamName: 'image',
      filesPathList: imageFilePath != null ? [imageFilePath] : [],
      authIsRequired: true,
    );

    return User.fromJson(json["data"]);
  }

  static Future<bool> delete(int id) async {
    await ApiService.instance.sendRequest(
      url: "$apiUrl/$id",
      httpMethod: HttpMethod.delete,
      authIsRequired: true,
    );

    return true;
  }
}

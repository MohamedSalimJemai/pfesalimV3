import '../../env.dart';
import '../../model/line.dart';
import '../network/api_service.dart';
import '../network/http_method.dart';

class LineRepository {
  static const String apiUrl = "$baseUrl/api/lines";

  static Future<List<Line>> getAll() async {
    final Map<String, dynamic> json = await ApiService.instance.sendRequest(
      url: apiUrl,
      httpMethod: HttpMethod.get,
      authIsRequired: true,
    );

    return List<Line>.from(
      (json["data"] as List<dynamic>).map((model) => Line.fromJson(model)),
    );
  }

  static Future<Line> add(Line line) async {
    final Map<String, dynamic> json = await ApiService.instance.sendRequest(
      url: apiUrl,
      httpMethod: HttpMethod.post,
      body: line.toJson(),
      authIsRequired: true,
    );

    return Line.fromJson(json["data"]);
  }

  static Future<Line> update(Line line) async {
    final Map<String, dynamic> json = await ApiService.instance.sendRequest(
      url: "$apiUrl/${line.id}",
      httpMethod: HttpMethod.put,
      body: line.toJson(),
      authIsRequired: true,
    );

    return Line.fromJson(json["data"]);
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

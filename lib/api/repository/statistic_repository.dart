import '../../env.dart';
import '../../model/statistic.dart';
import '../network/api_service.dart';
import '../network/http_method.dart';

class StatisticRepository {
  static const String apiUrl = "$baseUrl/api/statistics";

  static Future<List<Statistic>> getAll() async {
    final Map<String, dynamic> json = await ApiService.instance.sendRequest(
      url: apiUrl,
      httpMethod: HttpMethod.get,
      authIsRequired: true,
    );

    return List<Statistic>.from(
      (json["data"] as List<dynamic>).map((model) => Statistic.fromJson(model)),
    );
  }

  static Future<Statistic> add(Statistic statistic) async {
    final Map<String, dynamic> json = await ApiService.instance.sendRequest(
      url: apiUrl,
      httpMethod: HttpMethod.post,
      body: statistic.toJson(),
      authIsRequired: true,
    );

    return Statistic.fromJson(json["data"]);
  }

  static Future<Statistic> update(Statistic statistic) async {
    final Map<String, dynamic> json = await ApiService.instance.sendRequest(
      url: "$apiUrl/${statistic.id}",
      httpMethod: HttpMethod.put,
      body: statistic.toJson(),
      authIsRequired: true,
    );

    return Statistic.fromJson(json["data"]);
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

// lib/core/services/helper_service.dart
import '../../models/helper_model.dart';
import 'api_service.dart';

class HelperRequest {
  final ApiService apiService = ApiService();

  // Récupérer la liste complète des helpers
  Future<List<HelperModel>> getHelpers() async {
    List<dynamic> data = await apiService.getRequest("get_helpers.php");
    return data.map((helper) => HelperModel.fromJson(helper)).toList();
  }

  // Récupérer un helper par son ID
  Future<HelperModel?> getHelperById(int id) async {
    Map<String, String> queryParams = {"id": id.toString()};
    List<dynamic> data = await apiService.getRequest("get_helpers.php", queryParams: queryParams);
    if (data.isNotEmpty) {
      return HelperModel.fromJson(data.first);
    }
    return null;
  }
}
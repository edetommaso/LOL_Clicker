import '../../models/shop_item_model.dart';
import 'api_service.dart';

class ShopItemRequest {
  final ApiService apiService = ApiService();

  Future<List<ShopItemModel>> getShopItems() async {
    List<dynamic> data = await apiService.getRequest("get_items.php");
    return data.map((items) => ShopItemModel.fromJson(items)).toList();
  }
  
    Future<ShopItemModel?> getEnemyById(int id) async {
    Map<String, String> queryParams = {"id": id.toString()};
    List<dynamic> data = await apiService.getRequest("get_items.php", queryParams: queryParams);
    if (data.isNotEmpty) {
      return ShopItemModel.fromJson(data.first);
    }
    return null;
  }
}
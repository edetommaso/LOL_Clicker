import '../../models/ennemy_model.dart';
import 'api_service.dart';

class EnemyRequest {
  final ApiService apiService = ApiService();
  
  /*---------------------*/
  /* Lectures de données */
  /*---------------------*/
  
  // Récupérer la liste complète des ennemis
  Future<List<EnemyModel>> getEnemies() async {
    List<dynamic> data = await apiService.getRequest("get_enemies.php");
    return data.map((enemy) => EnemyModel.fromJson(enemy)).toList();
  }
  
  // Récupérer un ennemi par son id
  Future<EnemyModel?> getEnemyById(int id) async {
    Map<String, String> queryParams = {"id": id.toString()};
    List<dynamic> data = await apiService.getRequest("get_enemies.php", queryParams: queryParams);
    if (data.isNotEmpty) {
      return EnemyModel.fromJson(data.first);
    }
    return null;
  }
  
  // Récupérer les ennemis par niveau
  Future<List<EnemyModel>> getEnemiesByCategorie(int categorie) async {
    Map<String, String> queryParams = {"categorie": categorie.toString()};
    List<dynamic> data = await apiService.getRequest("get_enemies.php", queryParams: queryParams);
    return data.map((enemy) => EnemyModel.fromJson(enemy)).toList();
  }
  
  // Récupérer les ennemis ayant plus d'une certaine quantité d'expérience
  Future<List<EnemyModel>> getEnemiesByExperience(int experience) async {
    Map<String, String> queryParams = {"experience": experience.toString()};
    List<dynamic> data = await apiService.getRequest("get_enemies.php", queryParams: queryParams);
    return data.map((enemy) => EnemyModel.fromJson(enemy)).toList();
  }

}
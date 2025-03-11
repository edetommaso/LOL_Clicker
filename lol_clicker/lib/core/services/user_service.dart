import '../../models/user_model.dart';
import 'api_service.dart';

class UserRequest {
  final ApiService apiService = ApiService();
  
  Future<List<UserModel>> getUsers() async {
    List<dynamic> data = await apiService.getRequest("get_users.php");
    return data.map((user) => UserModel.fromJson(user)).toList();
  }
  
  Future<UserModel?> getUserById(int id) async {
    Map<String, String> queryParams = {"id_user": id.toString()};
    List<dynamic> data = await apiService.getRequest("get_users.php", queryParams: queryParams);
    if (data.isNotEmpty) {
      return UserModel.fromJson(data.first);
    }
    return null;
  }

  Future<List<UserModel>> getUserByLastname(String lastname) async {
    Map<String, String> queryParams = {"lastname": Uri.encodeComponent(lastname)};
    List<dynamic> data = await apiService.getRequest("get_users.php", queryParams: queryParams);
    return data.map((user) => UserModel.fromJson(user)).toList();
  }

  Future<List<UserModel>> getAdultUsers(int age) async {
    Map<String, String> queryParams = {"age": age.toString()};
    List<dynamic> data = await apiService.getRequest("get_users.php", queryParams: queryParams);
    return data.map((userData) => UserModel.fromJson(userData)).toList();
  }

  Future<List<UserModel>> getUsersByFilters({String? lastname, int? age}) async {
    Map<String, String> queryParams = {};
    if (lastname != null) queryParams['lastname'] = Uri.encodeComponent(lastname);
    if (age != null) queryParams['age'] = age.toString();
    
    List<dynamic> data = await apiService.getRequest("get_users.php", queryParams: queryParams);
    return data.map((userData) => UserModel.fromJson(userData)).toList();
  }

  Future<void> insertUser(String firstname, String lastname, String birthdate) async {
    await apiService.postRequest("post_users.php", {
      "action": "insert",
      "firstname": firstname,
      "lastname": lastname,
      "birthdate": birthdate
    });
  }
  
  Future<void> updateUser(int id, {String? firstname, String? lastname, String? birthdate}) async {
    Map<String, dynamic> data = {
      "action": "update",
      "id_user": id.toString(),
    };
    if (firstname != null) data["firstname"] = firstname;
    if (lastname != null) data["lastname"] = lastname;
    if (birthdate != null) data["birthdate"] = birthdate;

    await apiService.postRequest("post_users.php", data);
  }
  
  Future<void> deleteUser(int id) async {
    await apiService.postRequest("post_users.php", {
      "action": "delete",
      "id_user": id.toString(),
    });
  }
}
import 'package:flutter/material.dart';
import '../core/services/user_service.dart';
import '../models/user_model.dart';
class UserViewModel extends ChangeNotifier {
  final UserRequest _userRequest = UserRequest();
  List<UserModel> _users = [];
  bool _isLoading = false;
  String _error = '';
  List<UserModel> get users => _users;
  
  bool get isLoading => _isLoading;
  String get errorMessage => _error;

  List<UserModel> _filteredUsers = [];
  List<UserModel> get filteredUsers => _filteredUsers;

  Future<void> fetchUsers() async {
    _isLoading = true;
    _error = '';
    notifyListeners();
    
    try {
      _users = await _userRequest.getUsers();
      _filteredUsers = List.from(_users);
    } catch (e) {
      _error = e.toString();
    }
    
    _isLoading = false;
    notifyListeners();
  }
  
  Future<void> fetchUserById(int id) async {
    _isLoading = true;
    _error = '';
    notifyListeners();
    
    try {
      _users = await _userRequest.getUserById(id) as List<UserModel>;
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchUsersByLastname(String lastname) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _users = await _userRequest.getUserByLastname(lastname);
    } catch (e) {
      _error = e.toString();
    }
    
    _isLoading = false;
    notifyListeners();
  }

  void filterUsers(String query) {
    if (query.isEmpty) {
      _filteredUsers = List.from(_users);
    } else {
      _filteredUsers = _users
          .where((user) =>
      user.lastname.toLowerCase().contains(query.toLowerCase()) ||
          user.firstname.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  Future<void> addUser(String firstname, String lastname, String birthdate) async {
    try {
      await _userRequest.insertUser(firstname, lastname, birthdate);
      await fetchUsers();
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
  }

  Future<void> updateUser(int id, {String? firstname, String? lastname, String? birthdate}) async {
    try {
      await _userRequest.updateUser(id, firstname: firstname, lastname: lastname, birthdate: birthdate);
      await fetchUsers();
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
  }

  Future<void> deleteUser(int id) async {
    try {
      await _userRequest.deleteUser(id);
      await fetchUsers();
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
  }
}
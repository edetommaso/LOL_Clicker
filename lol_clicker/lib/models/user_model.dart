import 'package:intl/intl.dart';

class UserModel {
  final int id;
  final String lastname;
  final String firstname;
  final String birthdate;
  
  UserModel({
    required this.id,
    required this.lastname,
    required this.firstname,
    required this.birthdate,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id_user'] ?? 0,
      lastname: json['lastname'] ?? 'Nom inconnu',
      firstname: json['firstname'] ?? 'Prénom inconnu',
      birthdate: json['birthdate'] ?? 'Date inconnue',
    );
  }

  int get age {
    try {
      DateTime birth = DateFormat('yyyy-MM-dd').parse(birthdate);
      DateTime now = DateTime.now();
      int age = now.year - birth.year;
      if (now.month < birth.month || (now.month == birth.month && now.day < birth.day)) {
        age--;
      }
      return age;
    } catch (e) {
      return 0;
    }
  }

}
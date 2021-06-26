import 'dart:convert';

class UserModel {
  final String name;
  final String? photoURL; // ? -> a imagem pode vir nula

  UserModel(
    {
      required this.name, required this.photoURL
    }
  );

    factory UserModel.fromMap(Map<String,dynamic> map){
    return UserModel(name: map['name'], photoURL: map['photoURL']);
  }

  factory UserModel.fromJson(String json) => UserModel.fromMap(jsonDecode(json));

  Map<String, dynamic> toMap() => { // transforma as variáveis name e photo em um toMap
    "name" : name,
    "photoURL" : photoURL,
  };

  String toJson() => jsonEncode(toMap()); // transforma o map em uma string
}
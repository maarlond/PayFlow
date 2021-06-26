import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  //var _isAuthenticated = false; //variável privada
  UserModel? _user;

  UserModel get user =>
      _user!; // ! -> garantir que o usuário esta logado, e que não seja nulo
  // não pode ser alterada em nenhum lugar do código, somente na função onde é chamado

  void setUser(BuildContext context, UserModel? user) {
    // ? -> pode receber nulo para validar
    // verificação de usuário, caso for diferente de nulo, a autentificação recebe true
    if (user != null) {
      saveUser(
          user); // se o usuário for diferente de nulo, chama a função para guardar as informações de login
      _user = user;
      //_isAuthenticated = true;
      Navigator.pushReplacementNamed(context, "/home", arguments: user);
    } else {
      //_isAuthenticated = false;
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  Future<void> saveUser(UserModel user) async {
    // função future para salvar as informações do usuário logado
    final instance = await SharedPreferences
        .getInstance(); // buscando a instancia do shared_preferences
    await instance.setString("user", user.toJson());
    return;
  }

  Future<void> currentUser(BuildContext context) async {
    // função para buscar o user atual
    final instance = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 2));
    if (instance.containsKey("user")) {
      final json = instance.get("user")
          as String; // quando utilizamos o get não precisamos do await, pois ele pega direto, diferente do set
      setUser(context, UserModel.fromJson(json));
      return;
    } else {
      setUser(context, null);
    }
  }
}

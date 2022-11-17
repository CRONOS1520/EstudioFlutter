import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:star_up/models/entities/Usuario.dart';

class UsuariosApi {
  //Obtener todos los usuarios
  Future<List<Usuario>?> getAllUsuarios() async {
    var client = http.Client();
    var uri = Uri.http('10.0.2.2:5000', 'usuario');
    //var uri = Uri.parse('http://127.0.0.1:5000/usuario/');

    try {
      var response = await client.get(uri);
      if (response.statusCode == 200) {
        var json = utf8.decode(response.bodyBytes);
        return usuarioFromJson(json);
      }
    } catch (e) {
      print(e);
    }

    return null;
  }
}

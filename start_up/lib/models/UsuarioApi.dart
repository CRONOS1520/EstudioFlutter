import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:star_up/models/entities/Usuario.dart';

class UsuariosApi {
  Future<List<Usuario>?> getUsuario(nombreUsuario) async {
    var client = http.Client();
    String path = "usuario/" + nombreUsuario;
    var uri = Uri.http('10.0.2.2:5000', path);

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

  //Obtener todos los usuarios
  Future<List<Usuario>?> getAllUsuarios() async {
    var client = http.Client();
    var uri = Uri.http('10.0.2.2:5000', 'usuario');

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

  //Insertar Usuario
  Future<bool> addUsuario(List<Usuario> usuarios) async {
    var client = http.Client();
    var uri = Uri.http('10.0.2.2:5000', 'usuario/add');
    try {
      var response = await client.post(uri,
          headers: {'content-type': 'application/json;charset=utf-8'},
          body: utf8.encode(json.encode(usuarioToJson(usuarios))));
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      print(e);
    }

    return false;
  }
}

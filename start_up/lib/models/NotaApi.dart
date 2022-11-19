import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:star_up/models/entities/Nota.dart';

class NotasApi {
  //Obtener todos los notas
  Future<List<Nota>?> getNota(nombreUsuario, fechaNota) async {
    var client = http.Client();
    String path = "nota/" + nombreUsuario + "/" + fechaNota;
    var uri = Uri.http('10.0.2.2:5000', path);

    try {
      var response = await client.get(uri);
      if (response.statusCode == 200) {
        var json = utf8.decode(response.bodyBytes);
        return notaFromJson(json);
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  //Insertar Nota
  Future<bool> addNota(List<Nota> notas) async {
    var client = http.Client();
    var uri = Uri.http('10.0.2.2:5000', 'nota/add');
    try {
      var response = await client.post(uri,
          headers: {'content-type': 'application/json;charset=utf-8'},
          body: utf8.encode(json.encode(notaToJson(notas))));
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      print(e);
    }

    return false;
  }

  //Actualizar nota
  Future<bool> updateNota(List<Nota> notas) async {
    var client = http.Client();
    String path = "nota/update/" + notas[0].id.toString();
    var uri = Uri.http('10.0.2.2:5000', path);

    try {
      var response = await client.put(uri,
          headers: {'content-type': 'application/json;charset=utf-8'},
          body: utf8.encode(json.encode(notaToJson(notas))));
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      print(e);
    }

    return false;
  }

  //Eliminar nota
  Future<bool> deleteNota(id) async {
    var client = http.Client();
    String path = "nota/delete/" + id;
    var uri = Uri.http('10.0.2.2:5000', path);

    try {
      var response = await client.delete(uri);
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      print(e);
    }

    return false;
  }
}

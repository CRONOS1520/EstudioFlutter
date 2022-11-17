// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

List<Usuario> usuarioFromJson(String str) =>
    List<Usuario>.from(json.decode(str).map((x) => Usuario.fromJson(x)));

String usuarioToJson(List<Usuario> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Usuario {
  Usuario({
    this.clave,
    this.email,
    this.fechaCreacion,
    this.id,
    this.nombre,
  });

  String? clave;
  String? email;
  String? fechaCreacion;
  int? id;
  String? nombre;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        clave: json["clave"],
        email: json["email"],
        fechaCreacion: json["fechaCreacion"],
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "clave": clave,
        "email": email,
        "fechaCreacion": fechaCreacion,
        "id": id,
        "nombre": nombre,
      };
}

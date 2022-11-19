// To parse this JSON data, do
//
//     final nota = notaFromJson(jsonString);

import 'dart:convert';

List<Nota> notaFromJson(String str) =>
    List<Nota>.from(json.decode(str).map((x) => Nota.fromJson(x)));

String notaToJson(List<Nota> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Nota {
  Nota(
      {this.titulo,
      this.duracion,
      this.fechaNota,
      this.fechaFinalizacion,
      this.id,
      this.fkestado,
      this.fkusuario});

  String? titulo;
  String? duracion;
  String? fechaNota;
  String? fechaFinalizacion;
  int? id;
  String? fkestado;
  String? fkusuario;

  factory Nota.fromJson(Map<String, dynamic> json) => Nota(
      titulo: json["titulo"],
      duracion: json["duracion"],
      fechaNota: json["fechanota"],
      id: json["id"],
      fechaFinalizacion: json["fechafinalizacion"],
      fkestado: json["fkestado"]);

  Map<String, dynamic> toJson() => {
        "titulo": titulo,
        "duracion": duracion,
        "fechanota": fechaNota,
        "id": id,
        "fechafinalizacion": fechaFinalizacion,
        "fkestado": fkestado,
        "fkusuario": fkusuario
      };
}

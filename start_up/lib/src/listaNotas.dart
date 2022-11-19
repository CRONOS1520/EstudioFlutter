import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:star_up/models/NotaApi.dart';
import 'package:star_up/models/entities/Nota.dart';

import 'globals.dart' as globals;
import 'package:star_up/utils/Helper.dart';

class MyListaNotas extends StatefulWidget {
  const MyListaNotas({super.key});

  @override
  State<MyListaNotas> createState() => _MyListaNotasState();
}

class _MyListaNotasState extends State<MyListaNotas> {
  TextEditingController tituloController = new TextEditingController();
  TimeOfDay _hora = TimeOfDay.now();

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        _hora = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notas del " +
            DateFormat('dd-MM-yyyy').format(globals.diaSeleccionado)),
      ),
      body: ListView.builder(
        itemCount: globals.listaNotas.length,
        itemBuilder: ((context, index) {
          try {
            Nota nota = globals.listaNotas[index];
            tituloController =
                new TextEditingController(text: nota.titulo.toString());
            TimeOfDay _horaNota = TimeOfDay.fromDateTime(
                (new DateFormat('HH:mm:ss')
                    .parse(nota.fechaNota.toString().split(" ")[1])));
            return Card(
                child: ListTile(
              title: Text(nota.titulo.toString()),
              subtitle: Text("Hora " + _horaNota.format(context).toString()),
              trailing: Icon(Icons.edit),
              onTap: () {
                _hora = TimeOfDay.fromDateTime((new DateFormat('HH:mm:ss')
                    .parse(nota.fechaNota.toString().split(" ")[1])));
                tituloController.text = nota.titulo.toString();
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      String horaStr =
                          "Hora " + _hora.format(context).toString();
                      return AlertDialog(
                          backgroundColor: Color.fromARGB(255, 155, 209, 240),
                          scrollable: true,
                          title: Text('Editar Nota'),
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    controller: tituloController,
                                    decoration: InputDecoration(
                                      labelText: 'Titulo',
                                      icon: Icon(Icons.message),
                                    ),
                                  ),
                                  const Divider(
                                    height: 20.0,
                                  ),
                                  Text(
                                    horaStr,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  const Divider(
                                    height: 20.0,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      _showTimePicker();

                                      setState(() {});
                                    },
                                    child: Text(
                                      'CAMBIAR HORA',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 70, 152, 253)),
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Color.fromARGB(
                                                    255, 235, 237, 240))),
                                  ),
                                  const Divider(
                                    height: 20.0,
                                  ),
                                  TextButton(
                                    onPressed: () => editarNota(
                                        nota, tituloController.text, _hora),
                                    child: Text(
                                      'ACTUALIZAR NOTA',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255)),
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Color.fromARGB(
                                                    255, 70, 152, 253))),
                                  ),
                                ],
                              ),
                            ),
                          ));
                    });
              },
            ));
          } catch (e) {
            print(e);
            return Card();
          }
        }),
      ),
    );
  }

  void editarNota(Nota nota, String titulo, TimeOfDay hora) async {
    try {
      nota.titulo = titulo;
      nota.fechaNota = Helper.formatTimeOfDay(globals.diaSeleccionado, hora);

      List<Nota> notas = [];
      notas.add(nota);

      bool seGuardo = await NotasApi().updateNota(notas);

      if (seGuardo) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  backgroundColor: Color.fromARGB(255, 143, 235, 120),
                  scrollable: true,
                  title: Text('Mensaje'),
                  content: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      child: Column(
                        children: <Widget>[
                          const Text(
                            'La nota se guardo con exito',
                          ),
                        ],
                      ),
                    ),
                  ));
            });
        List<Nota>? notas = await NotasApi().getNota(globals.usuario.nombre,
                DateFormat('dd-MM-yyyy').format(globals.diaSeleccionado))
            as List<Nota>;
        globals.listaNotas = notas;
        _hora = TimeOfDay.now();
        tituloController.text = "";

        setState(() {});
      } else {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  backgroundColor: Color.fromARGB(255, 245, 230, 130),
                  scrollable: true,
                  title: Text('Mensaje de alerta'),
                  content: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      child: Column(
                        children: <Widget>[
                          const Text(
                            'Ocurrió  un error al momento de agregar la nota',
                          ),
                        ],
                      ),
                    ),
                  ));
            });
      }
    } catch (e) {
      print(e);
    }
  }
}

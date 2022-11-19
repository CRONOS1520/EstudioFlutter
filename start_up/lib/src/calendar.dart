import 'package:flutter/material.dart';
import 'package:star_up/models/NotaApi.dart';
import 'package:star_up/models/entities/Nota.dart';
import 'package:star_up/src/listaNotas.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import 'globals.dart' as globals;
import 'package:star_up/utils/Helper.dart';

class MyCalendar extends StatefulWidget {
  const MyCalendar({super.key});

  @override
  State<MyCalendar> createState() => _MyCalendarSate();
}

class _MyCalendarSate extends State<MyCalendar> {
  TextEditingController tituloController = new TextEditingController();
  TextEditingController calendarController = new TextEditingController();
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  TimeOfDay _hora = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    verificarTareas();
  }

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        _hora = value!;
      });
      Navigator.pop(context);
      agregarNota();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 182, 205, 217),
        body: ListView(children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TableCalendar(
                selectedDayPredicate: (day) => _selectedDay == day,
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _focusedDay = focusedDay;
                    _selectedDay = selectedDay;
                  });
                  globals.diaSeleccionado = _selectedDay;
                },
                firstDay: DateTime.utc(2010, 10, 20),
                lastDay: DateTime.utc(2040, 10, 20),
                focusedDay: _focusedDay,
              ),
              const Divider(
                height: 20.0,
              ),
              TextButton(
                onPressed: () => agregarNota(),
                child: Text(
                  'AGREGAR NOTA DE ESTUDIO',
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 70, 152, 253))),
              ),
              TextButton(
                onPressed: () => cargarListaNotas(),
                child: Text(
                  'VER NOTAS',
                  style: TextStyle(color: Color.fromARGB(255, 70, 152, 253)),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 255, 255, 255))),
              ),
            ],
          )
        ]));
  }

  void agregarNota() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: Color.fromARGB(255, 155, 209, 240),
              scrollable: true,
              title: Text('Agregar Nota'),
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
                        "Hora " + _hora.format(context).toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                      const Divider(
                        height: 20.0,
                      ),
                      TextButton(
                        onPressed: () => _showTimePicker(),
                        child: Text(
                          'CAMBIAR HORA',
                          style: TextStyle(
                              color: Color.fromARGB(255, 70, 152, 253)),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 235, 237, 240))),
                      ),
                      const Divider(
                        height: 20.0,
                      ),
                      TextButton(
                        onPressed: () => insertarNota(),
                        child: Text(
                          'AGREGAR NOTA DE ESTUDIO',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 70, 152, 253))),
                      ),
                    ],
                  ),
                ),
              ));
        });
  }

  void insertarNota() async {
    try {
      List<Nota> notas = [];
      Nota nota = new Nota(
          titulo: tituloController.text.trim().toString(),
          duracion: globals.tiempoPomodoro.toString(),
          fechaNota: Helper.formatTimeOfDay(globals.diaSeleccionado, _hora),
          fkestado: "1",
          fkusuario: globals.usuario.id.toString());

      notas.add(nota);

      bool seGuardo = await NotasApi().addNota(notas);

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
        _hora = TimeOfDay.now();
        tituloController.text = "";
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

  void cargarListaNotas() async {
    try {
      List<Nota>? notas = await NotasApi().getNota(globals.usuario.nombre,
              DateFormat('dd-MM-yyyy').format(globals.diaSeleccionado))
          as List<Nota>;
      globals.listaNotas = notas;

      if (notas.length > 0) {
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new MyListaNotas()));
      } else {
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
                            'No hay notas asignadas a este día',
                          ),
                        ],
                      ),
                    ),
                  ));
            });
      }
    } catch (e) {
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
                          'Ocurrio un error al momento de cargar las notas',
                        ),
                      ],
                    ),
                  ),
                ));
          });
    }
  }

  void verificarTareas() async {
    List<Nota>? notas = await NotasApi().getNota(globals.usuario.nombre,
        DateFormat('dd-MM-yyyy').format(DateTime.now())) as List<Nota>;
    globals.listaNotas = notas;

    if (notas.length > 0) {
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
                          'RECUERDA TIENES PENDIENTES ASIGNADOS PARA HOY!!!',
                        ),
                      ],
                    ),
                  ),
                ));
          });
    }
  }
}

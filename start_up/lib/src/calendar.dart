import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MyCalendar extends StatefulWidget {
  const MyCalendar({super.key});

  @override
  State<MyCalendar> createState() => _MyCalendarSate();
}

class _MyCalendarSate extends State<MyCalendar> {
  TextEditingController calendarController = new TextEditingController();
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 244, 244, 242),
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
                    backgroundColor: MaterialStateProperty.all(Colors.indigo)),
              ),
              const Divider(
                height: 20.0,
              ),
              Text(
                'LISTA DE TAREAS',
                style: TextStyle(),
                textAlign: TextAlign.left,
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
              scrollable: true,
              title: Text('Agregar Nota'),
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Titulo Tarea',
                          icon: Icon(Icons.title),
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Detalle',
                          icon: Icon(Icons.message),
                        ),
                      )
                    ],
                  ),
                ),
              ));
        });
  }
}

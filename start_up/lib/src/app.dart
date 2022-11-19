import 'package:flutter/material.dart';
import 'package:star_up/main.dart';
import 'package:star_up/models/UsuarioApi.dart';
import 'package:star_up/models/entities/Usuario.dart';
import 'package:star_up/src/calendar.dart';
import 'package:star_up/src/registro.dart';
import 'globals.dart' as globals;

class MyAppForm extends StatefulWidget {
  const MyAppForm({super.key});

  @override
  State<MyAppForm> createState() => _MyAppFormState();
}

class _MyAppFormState extends State<MyAppForm> {
  List<Usuario>? usuarios;
  var isLoaded = false;

  String _nombre = '';
  String _clave = '';
  TextEditingController nombreController = new TextEditingController();
  TextEditingController claveController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    globals.usuario = new Usuario();
    globals.diaSeleccionado = DateTime.now();
    globals.listaNotas = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 182, 205, 217),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 90.0,
        ),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 100.0,
                backgroundColor: Color.fromARGB(255, 252, 217, 158),
                backgroundImage: AssetImage("images/tomate.png"),
              ),
              const Text(
                'Login',
                style: TextStyle(fontFamily: 'cursive', fontSize: 50.0),
              ),
              const Divider(
                height: 15.0,
              ),
              TextField(
                controller: nombreController,
                enableInteractiveSelection: false,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                  hintText: 'Nombre de usuario',
                  labelText: 'Nombre',
                  suffixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (valor) {
                  _nombre = valor;
                  print('El nombre es: $_nombre');
                },
              ),
              const Divider(
                height: 15.0,
              ),
              TextField(
                controller: claveController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Contraseña',
                  labelText: 'Contraseña',
                  suffixIcon: Icon(Icons.password),
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (valor) {
                  _clave = valor;
                  print('El nombre es: $_clave');
                },
              ),
              const Divider(
                height: 15.0,
              ),
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 70, 152, 253))),
                child: const Text('Ingresar',
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 30.0,
                        fontFamily: 'NerkoOne')),
                onPressed: () => redirectionCalendar(),
              ),
              const Divider(
                height: 15.0,
              ),
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 255, 255, 255))),
                child: const Text('Registrate',
                    style: TextStyle(
                        color: Color.fromARGB(255, 70, 152, 253),
                        fontSize: 30.0,
                        fontFamily: 'NerkoOne')),
                onPressed: () => redirectionRegistro(),
              )
            ],
          )
        ],
      ),
    );
  }

  void redirectionCalendar() async {
    List<Usuario>? usuarios =
        await UsuariosApi().getAllUsuarios() as List<Usuario>;
    bool esIgual = false;

    if (usuarios != null) {
      usuarios.forEach((usuario) {
        if (!esIgual) {
          esIgual =
              (usuario.nombre?.compareTo(nombreController.text.trim()) == 0 &&
                  usuario.clave?.compareTo(claveController.text.trim()) == 0);
          globals.usuario = usuario;
        }
      });

      if (esIgual) {
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new MyCalendar()));
        claveController.text = "";
        nombreController.text = "";
        return;
      }
    }
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
                        'El nombre o contraseña incorrecta',
                      ),
                    ],
                  ),
                ),
              ));
        });
  }

  void redirectionRegistro() {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => new MyRegistro()));
    claveController.text = "";
    nombreController.text = "";
  }
}

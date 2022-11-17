import 'package:flutter/material.dart';
import 'package:star_up/main.dart';
import 'package:star_up/models/UsuarioApi.dart';
import 'package:star_up/models/entities/Usuario.dart';
import 'package:star_up/src/calendar.dart';
import 'package:star_up/src/registro.dart';

class MyAppForm extends StatefulWidget {
  const MyAppForm({super.key});

  @override
  State<MyAppForm> createState() => _MyAppFormState();
}

class _MyAppFormState extends State<MyAppForm> {
  List<Usuario>? usuarios;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    _getRecord();
  }

  _getRecord() async {
    usuarios = await UsuariosApi().getAllUsuarios();
    if (usuarios != null) {
      setState(() {
        isLoaded = true;
      });
      print(usuarios);
    }
  }

  String _nombre = '';
  String _password = '';
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

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
                controller: emailController,
                enableInteractiveSelection: false,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                  hintText: 'Correo de usuario',
                  labelText: 'Correo',
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
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Contraseña',
                  labelText: 'Contraseña',
                  suffixIcon: Icon(Icons.password),
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (valor) {
                  _password = valor;
                  print('El nombre es: $_password');
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

  void redirectionCalendar() {
    if (emailController.text.toLowerCase() == 'nando' &&
        passwordController.text.toLowerCase() == '123') {
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new MyCalendar()));
    }
  }

  void redirectionRegistro() {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => new MyRegistro()));
  }
}

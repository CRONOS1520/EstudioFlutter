import 'package:flutter/material.dart';

class MyAppForm extends StatefulWidget {
  const MyAppForm({super.key});

  @override
  State<MyAppForm> createState() => _MyAppFormState();
}

class _MyAppFormState extends State<MyAppForm> {
  String _nombre = '';
  String _password = '';

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
                enableInteractiveSelection: false,
                autofocus: true,
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
                style: TextButton.styleFrom(primary: Color.fromARGB(255, 142, 189, 144)),
                child: const Text('Ingresar',
                    style: TextStyle(
                        color: Color.fromARGB(255, 75, 140, 206),
                        fontSize: 30.0,
                        fontFamily: 'NerkoOne')),
                onPressed: () {},
              )
            ],
          )
        ],
      ),
    );
  }
}

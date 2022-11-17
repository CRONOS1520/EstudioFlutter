import 'package:flutter/material.dart';
import 'package:star_up/models/UsuarioApi.dart';
import 'package:star_up/models/entities/Usuario.dart';

class MyRegistro extends StatefulWidget {
  const MyRegistro({super.key});

  @override
  State<MyRegistro> createState() => _MyRegistroState();
}

class _MyRegistroState extends State<MyRegistro> {
  List<Usuario>? usuarios;
  var isLoaded = false;

  String _nombre = '';
  String _email = '';
  String _clave = '';
  TextEditingController nombreController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController claveController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 182, 205, 217),
        body: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 90.0,
            ),
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Registro',
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 45.0),
                  ),
                  const Divider(
                    height: 30.0,
                  ),
                  TextField(
                    controller: nombreController,
                    enableInteractiveSelection: false,
                    textCapitalization: TextCapitalization.characters,
                    decoration: const InputDecoration(
                      hintText: 'Nombre de usuario',
                      labelText: 'Nombre',
                      suffixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (valor) {
                      _nombre = valor;
                    },
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
                      _email = valor;
                    },
                  ),
                  const Divider(
                    height: 15.0,
                  ),
                  TextField(
                    controller: claveController,
                    enableInteractiveSelection: false,
                    obscureText: true,
                    textCapitalization: TextCapitalization.characters,
                    decoration: const InputDecoration(
                      hintText: 'Contraseña',
                      labelText: 'Contraseña',
                      suffixIcon: Icon(Icons.password),
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (valor) {
                      _clave = valor;
                    },
                  ),
                  const Divider(
                    height: 20.0,
                  ),
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 70, 152, 253))),
                    child: const Text('Registrar',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 30.0,
                            fontFamily: 'NerkoOne')),
                    onPressed: () => registrarUsuario(),
                  ),
                ],
              )
            ]));
  }

  void registrarUsuario() async {
    if (claveController.text.trim().isEmpty &&
        emailController.text.trim().isEmpty &&
        nombreController.text.trim().isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                scrollable: true,
                title: Text('Mensaje de alerta'),
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        const Text(
                          'Todos los campos son obligatorios',
                        ),
                      ],
                    ),
                  ),
                ));
          });
      return;
    }

    List<Usuario>? usuarios =
        await UsuariosApi().getAllUsuarios() as List<Usuario>;
    bool esIgual = false;

    if (usuarios != null) {
      usuarios.forEach((usuario) {
        esIgual = usuario.nombre?.compareTo(nombreController.text.trim()) == 0;

        if (esIgual) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    scrollable: true,
                    title: Text('Mensaje de alerta'),
                    content: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        child: Column(
                          children: <Widget>[
                            const Text(
                              'El nombre de usuario ya se encuentra en uso',
                            ),
                          ],
                        ),
                      ),
                    ));
              });
          return;
        }
      });
    }
  }
}

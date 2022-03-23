import 'package:flutter/material.dart';

import '../widget/widgets.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Container(
          child: Stack(
            children: [
              Center(
                child: FlutterLogo(
                  size: MediaQuery.of(context).size.width,
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: const [
                      _Logo(),
                      _FormulariosLogin(),
                      _InferiorTextos(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FormulariosLogin extends StatefulWidget {
  const _FormulariosLogin({
    Key? key,
  }) : super(key: key);

  @override
  State<_FormulariosLogin> createState() => _FormulariosLoginState();
}

class _FormulariosLoginState extends State<_FormulariosLogin> {
  bool verPass = true;
  @override
  Widget build(BuildContext context) {
    TextEditingController controllerCorreo = TextEditingController();
    TextEditingController controllerPass = TextEditingController();
    return Expanded(
        flex: 6,
        child: Container(
          // color: Colors.red,
          margin: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DataFromInput(
                textControler: controllerCorreo,
                iconPrefix: Icons.email,
                hint: 'Correo',
              ),
              DataFromInput(
                  textControler: controllerPass,
                  callback: () {
                    verPass = !verPass;
                    setState(() {});
                    print(verPass);
                  },
                  oculto: verPass,
                  hint: 'Password',
                  iconSufix: verPass
                      ? Icons.remove_red_eye
                      : Icons.no_encryption_gmailerrorred),
              const SizedBox(
                height: 5,
              ),
              Boton(txt: 'Ingresar', function: () {}),
            ],
          ),
        ));
  }
}

class _InferiorTextos extends StatelessWidget {
  const _InferiorTextos({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 5,
        child: Container(
          //color: Colors.indigo,
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, 'newUser');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.person_add_alt_sharp),
                    SizedBox(
                      width: 20,
                    ),
                    Text(' Crear Una Nueva Cuenta   ')
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class _Logo extends StatelessWidget {
  const _Logo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(
        flex: 2,
        child: CircleAvatar(
            backgroundColor: Colors.white54,
            radius: 70,
            child: Icon(Icons.people_outline_outlined, size: 100)));
  }
}

import 'package:chat/provider/provider_Usuario.dart';
import 'package:chat/provider/provider_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/widgets.dart';

class NewUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: const Text('New User'),
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
                    children: [
                      const _Logo(),
                      _FormulariosLogin(),
                      const _InferiorTextos(),
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
  _FormulariosLogin({
    Key? key,
  }) : super(key: key);

  @override
  State<_FormulariosLogin> createState() => _FormulariosLoginState();
}

    final controllerCorreo = TextEditingController();
    final controllerPass = TextEditingController();
    final controllerNombre = TextEditingController();
class _FormulariosLoginState extends State<_FormulariosLogin> {
  bool verPass = true;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 6,
        child: Container(
          // color: Colors.red,
          margin: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DataFromInput(
                  textControler: controllerNombre, hint: 'Nombre y Apellido'),
              DataFromInput(
                textControler: controllerCorreo,
                iconPrefix: Icons.email,
                hint: 'Correo',
              ),
              DataFromInput(
                textControler: controllerPass,
                oculto: verPass,
                iconSufix: verPass
                    ? Icons.remove_red_eye
                    : Icons.no_encryption_gmailerrorred,
                callback: () {
                  verPass = !verPass;
                  setState(() {});
                },
                hint: 'Password',
              ),
              const SizedBox(
                height: 20,
              ),
              Boton(
                  txt: 'Crear Usuario',
                  function: () async{
                    final provider=Provider.of<ProviderApi>(context,listen: false);
                    final response = await provider.newUser(controllerNombre.text, controllerCorreo.text, controllerPass.text);
                    print('CREAR USUARIO ${controllerNombre.text}');
                  }),
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
                onPressed: null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    //Icon(Icons.person_add_alt_sharp),
                    SizedBox(
                      width: 20,
                    ),
                    Text('Terminos y Condiciones ')
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

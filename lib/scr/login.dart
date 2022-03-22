import 'package:flutter/material.dart';

import '../widget/widgets.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: const [
                Logo(),
                FormulariosLogin(),
                InferiorTextos(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FormulariosLogin extends StatelessWidget {
  const FormulariosLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 6,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              const DataFromInput(),
              const DataFromInput(),
              Boton(
                  txt: 'Ingresar',
                  function: () {
                    print('hola mundo');
                  }),
            ],
          ),
        ));
  }
}

class InferiorTextos extends StatelessWidget {
  const InferiorTextos({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2,
        child: Container(
          color: Colors.indigo,
        ));
  }
}

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 3,
        child: Container(
          color: Colors.amber,
        ));
  }
}

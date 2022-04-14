import 'dart:math';

import 'package:chat/models/ususrio.dart';
import 'package:chat/provider/provider_Usuario.dart';
import 'package:chat/scr/scr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPrivado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final modal = ModalRoute.of(context)!.settings.arguments as Usuario;

    final provider = Provider.of<ProviderDataChat>(context);
    //provider.dataChat = modal;
    return SafeArea(
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(onPressed: () {
        //   for (int i = 0; i < provider.dataChat.txt.length; i++) {
        //     print(provider.dataChat.id);
        //     print(provider.dataChat.txt);
        //   }
        // }
        //),
        appBar: AppBar(
          title: Text(provider.dataChat.nombre),
          leading: BackButton(
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CajaLectura(),
              _CajaTexto(),
            ],
          ),
        ),
      ),
    );
  }
}

class CajaLectura extends StatefulWidget {
  const CajaLectura({
    Key? key,
  }) : super(key: key);

  @override
  State<CajaLectura> createState() => _CajaLecturaState();
}

class _CajaLecturaState extends State<CajaLectura> {
  @override
  Widget build(BuildContext context) {
    final modal = Provider.of<ProviderDataChat>(context);
    return Flexible(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: Colors.blue[50],
        child: ListView.builder(
            reverse: true,
            itemCount: modal.dataChat.txt.length,
            itemBuilder: (context, index) {
              return modal.dataChat.id[index] == '1'
                  ? _Yo(modal, index)
                  : _tu(modal, index);
            }),
      ),
    );
  }

  Widget _tu(ProviderDataChat modal, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Chip(
          backgroundColor: Color(0xD44B9FEE),
          onDeleted: () {
            modal.deleteTxt(index);
          },
          label: Padding(
            padding: const EdgeInsets.only(
              right: 8,
              left: 20,
              top: 5,
              bottom: 5,
            ),
            child: Text(
              modal.dataChat.txt[index],
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ),
    );
  }
}

class _CajaTexto extends StatefulWidget {
  const _CajaTexto({
    Key? key,
  }) : super(key: key);

  @override
  State<_CajaTexto> createState() => _CajaTextoState();
}

TextEditingController controllerTF = TextEditingController();
FocusNode focusNode = FocusNode();
final rnd = Random();

class _CajaTextoState extends State<_CajaTexto> {
  @override
  Widget build(BuildContext context) {
    final modal = Provider.of<ProviderDataChat>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              // textInputAction: TextInputAction.go,
              //enableInteractiveSelection: true,
              focusNode: focusNode,
              controller: controllerTF,
              onSubmitted: (c) {
                if (modal.botonEnviar) {
                  focusNode.requestFocus();
                  sen(modal);
                } else {
                  focusNode.requestFocus();
                }
              },
              onChanged: (z) {
                if (z.length > 0) {
                  // print('hay datos ${controllerTF.text}');
                  modal.botonEnviar = true;
                } else {
                  // print('no hay dato');
                  modal.botonEnviar = false;
                }
              },
              decoration: const InputDecoration.collapsed(hintText: 'Mensaje'),
            ),
          ),
          Chip(
              onDeleted: () {
                controllerTF.clear();
                modal.botonEnviar = false;
              },
              label: GestureDetector(
                  onTap: modal.botonEnviar
                      ? () {
                          sen(modal);
                        }
                      : null,
                  child: Text(modal.botonEnviar ? 'Enviar' : '------')))
        ],
      ),
    );
  }

  void sen(ProviderDataChat modal) {
    modal.addTxt(controllerTF.text.toString(), rnd.nextInt(2).toString());
    controllerTF.clear();
    modal.botonEnviar = false;
    //setState(() {});
    focusNode.requestFocus();
  }
}

class _Yo extends StatefulWidget {
  final index;
  final modal;
  _Yo(this.modal, this.index);

  @override
  State<_Yo> createState() => _YoState();
}

class _YoState extends State<_Yo> {
  @override
  Widget build(BuildContext context) {
    final _random = Random();
    return Padding(
      padding: const EdgeInsets.only(top: 4, right: 15),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: AnimatedContainer(
          curve: Curves.bounceIn,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 131, 194, 144),
              borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.symmetric(
            horizontal: _random.nextInt(8).toDouble() + 8,
            vertical: 7,
          ),
          duration: const Duration(milliseconds: 200),
          child: Text(
            widget.modal.dataChat.txt[widget.index],
            textAlign: TextAlign.right,
          ),
        ),
      ),
    );
  }
}

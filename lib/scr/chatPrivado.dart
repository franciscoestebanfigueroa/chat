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

class CajaLectura extends StatelessWidget {
  const CajaLectura({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final modal = Provider.of<ProviderDataChat>(context);
    return Flexible(
      child: Container(
        color: Colors.blue[50],
        child: ListView.builder(
            reverse: true,
            itemCount: modal.dataChat.txt.length,
            itemBuilder: (context, index) {
              return modal.dataChat.id == '0'
                  ? _yo(modal, index)
                  : _tu(modal, index);
            }),
      ),
    );
  }

  Align _yo(ProviderDataChat modal, int index) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Chip(
        backgroundColor: Colors.blue[400],
        onDeleted: () {
          modal.deleteTxt(index);
          modal.dataChat.txt.forEach(print);

          print(index);
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
    );
  }

  Align _tu(ProviderDataChat modal, int index) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Chip(
        backgroundColor: Colors.grey[400],
        onDeleted: () {
          modal.deleteTxt(index);
          modal.dataChat.txt.forEach(print);

          print(index);
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

              controller: controllerTF,
              onSubmitted: (c) {},
              onChanged: (z) {
                if (z.length > 0) {
                  print('hay datos ${controllerTF.text}');

                  modal.botonEnviar = true;
                } else {
                  print('no hay dato');
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
                          if (modal.dataChat.id == '0') {
                            modal.dataChat.id = '1';
                          } else {
                            modal.dataChat.id = '0';
                          }

                          modal.addTxt(controllerTF.text.toString());
                          controllerTF.clear();
                          modal.botonEnviar = false;
                        }
                      : null,
                  child: Text(modal.botonEnviar ? 'Enviar' : '------')))
        ],
      ),
    );
  }
}

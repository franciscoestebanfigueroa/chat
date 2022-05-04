import 'dart:math';

import 'package:chat/models/modal_chat.dart';
import 'package:chat/models/ususrio.dart';
import 'package:chat/provider/provider_Usuario.dart';
import 'package:chat/provider/provider_api.dart';
import 'package:chat/provider/provider_socket.dart';
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
            children: [
              Chats(),
              const _CajaTexto(),
            ],
          ),
        ),
      ),
    );
  }
}

class Chats extends StatefulWidget {
  Chats({
    Key? key,
  }) : super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  void initState() {
    print('init caja lectura*****************');
    final providerSocket = Provider.of<ProviderSocket>(context, listen: false);
    final providerChat = Provider.of<ProviderDataChat>(context, listen: false);
    providerSocket.socket.on('sala', (data) => _escuchar(data));
    super.initState();
  }

  _escuchar(dynamic data) {
    final providerChat = Provider.of<ProviderDataChat>(context, listen: false);

    print('payload $data');

    providerChat.insertarMensajes(data);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final providerChat = Provider.of<ProviderDataChat>(context);
    final prviderApi = Provider.of<ProviderApi>(context);

    final miUid = prviderApi.usuario.uid;
    final usuario = providerChat.dataChat;
    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        color: Colors.blue[50],
        child: ListView.builder(
            reverse: true,
            itemCount: providerChat.listaMensajes.length, //ver
            itemBuilder: (context, index) {
              return providerChat.listaMensajes[index].de == miUid
                  ? _Yo(mensajesChat: providerChat.listaMensajes[index])
                  : _tu(providerChat.listaMensajes[index]);
            }),
      ),
    );
  }

  Widget _tu(MensajesChat modal) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Chip(
          backgroundColor: Color(0xD44B9FEE),
          onDeleted: () {
            //modal.deleteTxt(index);
          },
          label: Padding(
            padding: const EdgeInsets.only(
              right: 8,
              left: 20,
              top: 5,
              bottom: 5,
            ),
            child: Text(
              modal.data,
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
    final providerSocket = Provider.of<ProviderSocket>(context, listen: false);
    final providerApi = Provider.of<ProviderApi>(context, listen: false);
    providerSocket.socket.emit('sala', {
      'de': providerApi.usuario.uid.toString(),
      'para': modal.dataChat.uid,
      'data': controllerTF.text.toString()
    });
    print(controllerTF.text);
    modal.addTxt(controllerTF.text.toString(), rnd.nextInt(2).toString());
    controllerTF.clear();
    modal.botonEnviar = false;
    //setState(() {});
    focusNode.requestFocus();
  }
}

class _Yo extends StatefulWidget {
  final MensajesChat mensajesChat;
  _Yo({required this.mensajesChat});

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
              color: const Color.fromARGB(255, 131, 194, 144),
              borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.symmetric(
            horizontal: _random.nextInt(8).toDouble() + 8,
            vertical: 7,
          ),
          duration: const Duration(milliseconds: 200),
          child: Text(
            widget.mensajesChat.data,
            textAlign: TextAlign.right,
          ),
        ),
      ),
    );
  }
}

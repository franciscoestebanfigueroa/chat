import 'package:chat/models/ususrio.dart';
import 'package:chat/provider/provider_Usuario.dart';
import 'package:chat/provider/provider_api.dart';

import 'package:chat/provider/provider_socket.dart';
import 'package:chat/scr/scr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Usuario> lista = [];
    //   Usuario(
    //       txt: [
    //         'hola',
    //         'mundo',
    //         'que haces',
    //       ],
    //       nombre: 'Pancho',
    //       id: ['1', '0', '1']),
    //   Usuario(txt: [], nombre: 'Lara', id: ['2'], estado: true),
    //   Usuario(txt: [], nombre: 'Caro', id: ['3']),
    //   Usuario(txt: [], nombre: 'Esteban', id: ['4'])
    // ];
    final onLine = Provider.of<ProviderSocet>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  final provider =
                      Provider.of<ProviderApi>(context, listen: false);
                  provider.token = '';
                  onLine.estadoSocket();
                  //  ProviderApi().eliminarToken();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return Login();
                  }));
                },
                child: Icon(
                  Icons.power_off,
                  color: Colors.red,
                )),
            Icon(
              Icons.online_prediction,
              color: onLine.estadoLine ? Colors.green : Colors.red,
            ),
            const SizedBox(
              width: 20,
            ),
          ],
          title: Row(
            children: const [
              CircleAvatar(
                child: Text('FF'),
              ),
              SizedBox(
                width: 10,
              ),
              Text('Francisco Figueroa')
            ],
          ),
        ),
        body: Container(
          child: ListView.builder(
            itemCount: lista.length,
            itemBuilder: (context, index) {
              return _ListaUsuarios(context, lista[index]);
            },
          ),
        ),
      ),
    );
  }

  ListTile _ListaUsuarios(BuildContext context, Usuario usr) {
    final modal = Provider.of<ProviderDataChat>(context);
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, 'chatPrivado', arguments: usr);
        modal.dataChat = usr;
      },
      title: Text(usr.nombre),
      subtitle: Text(usr.online ? 'Desconectado' : 'Conectado'),
      leading: CircleAvatar(
          backgroundColor: usr.online ? Colors.red[400] : Colors.green[300],
          child: Text(usr.nombre.substring(0, 2).toUpperCase())),
    );
  }
}

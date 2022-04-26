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
    
    final onLine = Provider.of<ProviderSocket>(context);
    final providerApi = Provider.of<ProviderApi>(context);
    providerApi.listadoUser();
    lista=providerApi.listado;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  providerApi.listadoUser();

                  //onLine.conectar = false;
                  //onLine.conectarSocket();

                  //  ProviderApi().eliminarToken();
//
                //  Navigator.pushReplacement(context,
                //      MaterialPageRoute(builder: (context) {
                //    return Login();
                //  }));
                },
                child: const Icon(
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
            children: [
              CircleAvatar(
                child: Text(providerApi.usuario.nombre
                    .toString()
                    .substring(0, 2)
                    .toUpperCase()),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(providerApi.usuario.nombre.toString().toUpperCase())
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

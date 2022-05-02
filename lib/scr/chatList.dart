import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat/models/ususrio.dart';
import 'package:chat/provider/provider_Usuario.dart';
import 'package:chat/provider/provider_api.dart';

import 'package:chat/provider/provider_socket.dart';
import 'package:chat/scr/scr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatList extends StatefulWidget {
  @override
  State<ChatList> createState() => _ChatListState();
}

RefreshController _refreshController = RefreshController(initialRefresh: false);

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    List<Usuario> lista = [];

    final onLine = Provider.of<ProviderSocket>(context);
    final providerApi = Provider.of<ProviderApi>(context);

    lista = providerApi.listado;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  // providerApi.listadoUser();

                  // onLine.conectarSocket();
                  onLine.onOffSocket(false);

                  //  ProviderApi().eliminarToken();
                  providerApi.borrarListado();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return Login();
                  }));
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
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          enablePullUp: true,
          header: const WaterDropMaterialHeader(),
          onRefresh: () async {
            // monitor network fetch
            await Future.delayed(const Duration(milliseconds: 1000));
            // if failed,use refreshFailed()
            providerApi.listadoUser();
            _refreshController.refreshCompleted();
          },
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
      subtitle: Text(usr.online ? 'Conectado' : 'Desconectado'),
      leading: CircleAvatar(
          backgroundColor: usr.online ? Colors.green[300] : Colors.red[400],
          child: Text(usr.nombre.substring(0, 2).toUpperCase())),
    );
  }
}

import 'package:chat/models/ususrio.dart';
import 'package:chat/provider/provider_Usuario.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Usuario> lista = [
      Usuario(txt: [
        'hola',
        'mundo',
        'que haces',
      ], nombre: 'Pancho', id: '1'),
      Usuario(txt: [], nombre: 'Lara', id: '2', estado: true),
      Usuario(txt: [], nombre: 'Caro', id: '3'),
      Usuario(txt: [], nombre: 'Esteban', id: '4')
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
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
      subtitle: Text(usr.estado ? 'Desconectado' : 'Conectado'),
      leading: CircleAvatar(
          backgroundColor: usr.estado ? Colors.red[400] : Colors.green[300],
          child: Text(usr.nombre.substring(0, 2).toUpperCase())),
    );
  }
}

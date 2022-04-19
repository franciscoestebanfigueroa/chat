import 'package:chat/provider/provider_api.dart';
import 'package:chat/scr/login.dart';
import 'package:chat/statcs.dart/staticRouter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chatList.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: FutureBuilder(
          future: check(context),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) { 
            return Container(
          height: 400,
          child:  Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:const [
                CircularProgressIndicator(),
                Text('Cargando')
              ],
            ),
          ),
        );

           },),
      ),
    );
  }

Future check(BuildContext context)async{

  final provider=Provider.of<ProviderApi>(context);

  if(await provider.isItokenValidate()){
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context)=>ChatList()));
  }
  else{
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context)=>Login()));
  }



}

}

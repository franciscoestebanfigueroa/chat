import 'package:flutter/material.dart';
import 'package:misil_baez/model.dart';
import 'package:misil_baez/provider/provider_data.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AppProvider());
  }

class AppProvider extends StatelessWidget {
  const AppProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      
      providers: [
        Provider<ProviderData>(create: (_)=>ProviderData(),)
      ],
      child: const MyApp());
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
        final x = Provider.of<ProviderData>(context).datos;
      
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text("Misil Baez"),),
      body: data(),
      floatingActionButton: FloatingActionButton(onPressed: () { 
        x.x=50;
       },),
      
      );
  }

  Center data() {
    //DataModel dataModel=DataModel(x: 10, y: 20, z: 30);
    final datos= ProviderData().datos;
    return Center(
      child: SizedBox(
        width: 200,
        height: 200,
        //color: Colors.red,
        child: Column(
          children: [
            Text(" Dato x  => ${datos.x}"),
            Text(" Dato y  => ${datos.y}"),
            Text(" Dato z  => ${datos.z}"),
          ],
        ),
      ),
    );
  }
}
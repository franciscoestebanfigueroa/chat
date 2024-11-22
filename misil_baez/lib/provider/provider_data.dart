import 'package:flutter/material.dart';
import 'package:misil_baez/model.dart';

class ProviderData extends ChangeNotifier {

DataModel data = DataModel(x: 100, y: 200, z: 300);

ProviderData(){

print("hola provider");
}


DataModel get datos => data;

set (DataModel datos){
  data.x=datos.x;
  data.y=datos.y;
  data.z=datos.z;
  notifyListeners();

}


} 
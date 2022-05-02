import 'dart:io';

class Env {
  static String dir = Platform.isAndroid ? '10.0.2.2' : 'localhost';
  //static String dir = 'localhost';
  //static String dir = '10.0.2.2';
  static Uri uriLogin = Uri.parse('http://$dir:3000/api/login/');
  static Uri uriNewUser = Uri.parse('http://$dir:3000/api/login/new/');
  static Uri uriReNewToken = Uri.parse('http://$dir:3000/api/login/renew/');
  static Uri uriListado = Uri.parse('http://$dir:3000/api/usuarios/listado/');

  static String uriSocket = 'http://$dir:3000';
}

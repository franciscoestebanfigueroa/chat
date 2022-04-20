class Env {
  static String dir = '10.0.2.2';
  static Uri uriLocal = Uri.parse('http://$dir:3000/api/login/');
  static Uri uriLocalNew = Uri.parse('http://$dir:3000/api/login/new/');
  static Uri uriLocalreNew = Uri.parse('http://$dir:3000/api/login/renew/');

  static Uri uriEmu = Uri.http('10.0.2.2:3000', '/api/login/');
}

class Usuario {
  final String nombre;
  List id;
  List txt;
  bool estado;

  Usuario({
    required this.txt,
    required this.nombre,
    required this.id,
    this.estado = false,
  });
}

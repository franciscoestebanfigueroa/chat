import 'package:flutter/material.dart';

class Boton extends StatelessWidget {
  final String txt;
  final VoidCallback function;
  Boton({
    required this.txt,
    Key? key,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: 30,
        color: Colors.indigo,
        child: TextButton(
          onPressed: function,
          child: Text(
            txt,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

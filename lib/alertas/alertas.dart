import 'package:flutter/material.dart';

alertaCustom(BuildContext context, String titulo, String dialogo) {
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(dialogo),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('ok'))
          ],
        );
      });
}

import 'package:flutter/material.dart';

class DataFromInput extends StatelessWidget {
  final IconData? iconSufix;
  final IconData? iconPrefix;
  final String hint;
  final bool oculto;
  final VoidCallback? callback;
  final TextEditingController textControler;

  const DataFromInput({
    this.iconSufix,
    this.iconPrefix,
    this.oculto = false,
    required this.hint,
    this.callback,
    required this.textControler,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 4),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          color: Colors.white54,
          borderRadius: BorderRadius.circular(40),
        ),
        child: TextField(
          controller: textControler,
          obscureText: oculto,
          decoration: InputDecoration(
            prefixIcon: iconPrefix != null ? Icon(iconPrefix) : null,
            suffixIcon: iconSufix != null
                ? IconButton(
                    icon: Icon(iconSufix),
                    onPressed: callback,
                  )
                : null,
            hintText: hint,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

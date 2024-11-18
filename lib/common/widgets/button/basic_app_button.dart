import 'package:flutter/material.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double ? height; // Para parametros opcionales
  const BasicAppButton({required this.title,required this.onPressed, this.height,super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(height ?? 80)
      ),
        onPressed: onPressed,
        child: Text(title,style:const TextStyle(color: Colors.white),)
    );
  }
}

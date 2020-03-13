import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  
  final double radius;
  final List<Color>  colores;
  const Circle({Key key,this.radius, this.colores}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: radius * 2,
        height: radius * 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(this.radius),
          gradient: LinearGradient(colors: this.colores, begin: Alignment.bottomLeft, end: Alignment.topRight)

        ),
    );
  }
}
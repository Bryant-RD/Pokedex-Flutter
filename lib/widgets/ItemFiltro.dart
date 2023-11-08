import 'package:flutter/material.dart';

class itemFiltro extends StatelessWidget {

  final IconData icono;
  final String texto;

  const itemFiltro({
    super.key, required this.icono, required this.texto,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => ,
        //   )
        // );
      },
      child: ListTile(
        leading: Icon(icono), // Agrega un icono a la izquierda
        title: Text(texto),
        onTap: () {
          // Agrega tu lógica de filtrado aquí
        },
      ),
    );
  }
}
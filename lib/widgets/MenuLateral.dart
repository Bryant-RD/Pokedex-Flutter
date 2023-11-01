import 'package:flutter/material.dart';

class MenuLateral extends StatelessWidget {
  const MenuLateral({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          itemFiltro(icono: Icons.pets, texto: 'Filtrado por especies'),
          itemFiltro(icono: Icons.explore, texto: 'Filtrado por generaion'),
          itemFiltro(icono: Icons.star, texto: 'Favoritos'),
        ],
      ),
    );
  }
}

class itemFiltro extends StatelessWidget {

  final IconData icono;
  final String texto;

  const itemFiltro({
    super.key, required this.icono, required this.texto,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icono), // Agrega un icono a la izquierda
      title: Text(texto),
      onTap: () {
        // Agrega tu lógica de filtrado aquí
      },
    );
  }
}

import 'package:flutter/material.dart';

class MenuLateral extends StatelessWidget {
  const MenuLateral({Key? key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.red, // Fondo rojo
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/pokedex.png', // Reemplaza con la ruta de tu imagen
                    width: 150, // Ajusta el ancho de la imagen según tus necesidades
                    height: 150, // Ajusta la altura de la imagen según tus necesidades
                  ),
                ),
              ],
            ),
          ),
          const itemFiltro(icono: Icons.pets, texto: 'Filtrado por especies'),
          const itemFiltro(icono: Icons.explore, texto: 'Filtrado por generación'),
          const itemFiltro(icono: Icons.star, texto: 'Favoritos'),
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

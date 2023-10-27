import 'package:flutter/material.dart';
import 'package:pokedex_final_proyect/Entitys/Pokemon.dart';
import 'package:cached_network_image/cached_network_image.dart';



class ListItemPokemon extends StatefulWidget {
  final Pokemon? pokemon;
  const ListItemPokemon({super.key, required this.pokemon});

  @override
  State<ListItemPokemon> createState() => _ListItemPokemonState();
}

class _ListItemPokemonState extends State<ListItemPokemon> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0)
      ),
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
      tileColor: Colors.green,      
      title: Text(
        "${widget.pokemon?.name}",
        style: const TextStyle(
          fontSize: 25.0,
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),
      ),
      // trailing: Image.network(
      //   widget.pokemon?.image ?? "",
      //   width: 200,
      //   height: 600,
      //   fit: BoxFit.fill,
      // ),
        trailing: Expanded(
          child: AspectRatio(
            aspectRatio: 16 / 9, // Puedes ajustar la relación de aspecto según tus necesidades
            child: Image.network(
              widget.pokemon?.image ?? "",
              fit: BoxFit.cover, // Ajusta la imagen para llenar el espacio disponible
            ),
          ),
        ),

        subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "#${widget.pokemon?.id}",
            style: const TextStyle(
              color: Color.fromARGB(125, 51, 51, 75),
              fontWeight: FontWeight.bold,
              fontSize: 15.0
            ),
          ),
          Row(
          children: widget.pokemon?.types.map((tipo) => Card(
            color:const Color.fromARGB(45, 255, 255, 255),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)
            ),
            child: Text(
              tipo,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
          )).toList() ?? [],
          )
        ],
      ),     
    ),
    );
  }
}
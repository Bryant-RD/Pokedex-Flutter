import 'package:flutter/material.dart';
import 'package:pokedex_final_proyect/Entitys/Pokemon.dart';
import 'package:pokedex_final_proyect/services/PokemonService.dart';

//BORRA ESTE COMENTARIO

class ListItemPokemon extends StatefulWidget {

  final Pokemon? pokemon;
  final colors = ['red', 'blue', 'green', 'yellow', 'brown', 'purple', 'gray', 'white', 'pink', 'black'];
  final speciesByColor = Map<String, List<String>>();
  Color? color;


  ListItemPokemon({super.key, required this.pokemon, this.color});

  @override
  State<ListItemPokemon> createState() => _ListItemPokemonState();
}

class _ListItemPokemonState extends State<ListItemPokemon> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDataByColor();
    checkAndAssignColor();
  }

  Future<void> fetchDataByColor() async {
    print("ENTRANDO A FETCH");
    for (var color in widget.colors) {
      final species = await getPokemonSpeciesByColor(color);
      if (mounted) {
              setState(() {
        widget.speciesByColor[color] = species;
      });
      }
    }
  }

  Future<void> checkAndAssignColor() async {
    print("checkAndAssignColor");
    for (var item in widget.colors) {
        if (widget.speciesByColor[item] != null)  {
          if (widget.speciesByColor[item]!.contains(widget.pokemon?.species.toLowerCase())) {
                  // Asigna el color correspondiente al atributo titleColor del Pokémon
                widget.color = getColorForColorName(item);     
          }
      }
    }
  }

  Color getColorForColorName(String colorName) {
    print("Asignando color");
    // Define un mapeo de nombres de colores a objetos Color
    Map<String, Color> colorMap = {
      'red': Colors.red,
      'blue': Colors.blue,
      'green': Colors.green,
      'yellow': Colors.yellow,
      'brown': Colors.brown,
      'purple':Colors.purple,
      'gray': Colors.grey,
      'white':Colors.white,
      'pink':Colors.pink,
      'black':Colors.black
    };

    // Devuelve el color correspondiente o uno predeterminado si no se encuentra
    return colorMap[colorName] ?? Colors.grey;
  }


  @override
  Widget build(BuildContext context) {

    // print("Color que toca: " + widget.color.toString());


    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0)
      ),
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
      tileColor: widget.color,     
      title: Text(
        "${widget.pokemon?.name}",
        style: const TextStyle(
          fontSize: 25.0,
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),
      ),
      trailing: Image.network(
        widget.pokemon?.image ?? "",
        fit: BoxFit.contain,
        // width: 200,
        // height: 200,
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
              color:Color.fromARGB(70, 255, 255, 255),
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
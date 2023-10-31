import 'package:flutter/material.dart';
import 'package:pokedex_final_proyect/Entitys/Pokemon.dart';
import 'package:pokedex_final_proyect/pages/PokemonDetail.dart';
import 'package:pokedex_final_proyect/services/PokemonService.dart';

class ListItemPokemon extends StatefulWidget {
  final Pokemon? pokemon;

  ListItemPokemon({super.key, required this.pokemon});

  @override
  State<ListItemPokemon> createState() => _ListItemPokemonState();
}

class _ListItemPokemonState extends State<ListItemPokemon> {
  Color? color;
  bool colorLoaded = false;

  @override
  void initState() {
    super.initState();
    fetchColorForPokemon();
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
    return colorMap[colorName] ?? Colors.green.shade600;
  }

  Future<void> fetchColorForPokemon() async {
    final List<String> colors = ['red', 'blue', 'green', 'yellow', 'brown', 'purple', 'gray', 'white', 'pink', 'black'];

    for (var colorName in colors) {
      final species = await getPokemonSpeciesByColor(colorName);

      if (species.contains(widget.pokemon?.species.toLowerCase())) {
        if (mounted) {
          setState(() {
          color = getColorForColorName(colorName);
          colorLoaded = true;
        });
        }
        break; // Una vez que se encuentra el color, no es necesario seguir buscando.
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PokemonDetail(pokemon: widget.pokemon),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: const EdgeInsets.all(8.0),
        color: colorLoaded ? color : Colors.transparent,
        child: ListTile(
          title: Text(
            "${widget.pokemon?.name}",
            style: const TextStyle(
              fontSize: 25.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Image.network(
            widget.pokemon?.image ?? "",
            width: 40,
            height: 40,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "#${widget.pokemon?.id}",
                style: const TextStyle(
                  color: Color.fromARGB(125, 51, 51, 75),
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
              Row(
                children: widget.pokemon?.types.map((tipo) => Card(
                  color: Color.fromARGB(70, 255, 255, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Text(
                    tipo,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                )).toList() ?? [],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


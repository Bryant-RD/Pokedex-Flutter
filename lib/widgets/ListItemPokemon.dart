import 'package:flutter/material.dart';
import 'package:pokedex_final_proyect/Entitys/Pokemon.dart';
import 'package:pokedex_final_proyect/pages/PokemonDetail.dart';
import 'package:pokedex_final_proyect/services/PokemonService.dart';

class ListItemPokemon extends StatefulWidget {
  final Pokemon? pokemon;

  const ListItemPokemon({super.key, required this.pokemon});

  @override
  State<ListItemPokemon> createState() => _ListItemPokemonState();
}

class _ListItemPokemonState extends State<ListItemPokemon> {
  Color? color;
  bool colorLoaded = false;

  final TextStyle _textStyle = const TextStyle(
    fontFamily: 'Google Sans',
    fontSize: 15.0,
    fontWeight: FontWeight.bold,
  );

  @override
  void initState() {
    super.initState();
    fetchColorForPokemon();
  }

  Color getColorForColorName(String colorName) {
    print("Asignando color");
    Map<String, Color> colorMap = {
      'red': Colors.red,
      'blue': Colors.blue,
      'green': Colors.green,
      'yellow': Colors.yellow,
      'brown': Colors.brown,
      'purple': Colors.purple,
      'gray': Colors.grey,
      'white': Colors.white,
      'pink': Colors.pink,
      'black': Colors.black
    };

    return colorMap[colorName] ?? Colors.green.shade600;
  }

  Future<void> fetchColorForPokemon() async {
    final List<String> colors = [
      'red',
      'blue',
      'green',
      'yellow',
      'brown',
      'purple',
      'gray',
      'white',
      'pink',
      'black'
    ];

    for (var colorName in colors) {
      final species = await getPokemonSpeciesByColor(colorName);

      if (species.contains(widget.pokemon?.species.toLowerCase())) {
        if (mounted) {
          setState(() {
            color = getColorForColorName(colorName);
            colorLoaded = true;
          });
        }
        break;
      }
    }
  }

  Color getTextColor() {
    if (color == Colors.white || color == Colors.yellow) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  String capitalize(String text) {
    return text.isNotEmpty ? text[0].toUpperCase() + text.substring(1) : text;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(widget.pokemon!.toMap());
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PokemonDetail(
              pokemon: widget.pokemon,
              backgroundColor: getColorForColorName(widget.pokemon!.specieData!.color),
            ),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17.0),
        ),
        margin: const EdgeInsets.all(8.0),
        color: colorLoaded ? color : Colors.transparent,
        child: SizedBox(
          height: 135.0,
          child: Stack(
            children: [
              Positioned(
                right: 5,
                top: 5,
                child: Image.asset(
                  color == Colors.white || color == Colors.yellow
                      ? 'assets/pokeballblack.png'
                      : 'assets/pokeball.png',
                  height: 125,
                  width: 125,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 5,
                top: 5,
                child: Image.network(
                  widget.pokemon?.image ?? "",
                  width: 125,
                  height: 125,
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                title: Text(
                  capitalize(widget.pokemon?.name ?? ''),
                  style: TextStyle(
                    fontSize: 28.0,
                    color: getTextColor(),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "#${widget.pokemon?.id}",
                      style: TextStyle(
                        color: getTextColor(),
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      child: Wrap(
                        spacing: 8.0, // Espacio entre los elementos
                        runSpacing: 8.0, // Espacio entre las líneas
                        children: widget.pokemon?.types.map((tipo) => Image.asset(
                          'assets/icon_types/${tipo}.png',
                          width: 30.0,
                          height: 30.0,
                        )).toList() ?? [],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

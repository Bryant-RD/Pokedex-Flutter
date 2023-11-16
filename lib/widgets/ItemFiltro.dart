import 'package:flutter/material.dart';
import 'package:pokedex_final_proyect/pages/PokemonListFiltro.dart';
import 'package:pokedex_final_proyect/services/PokemonProvider.dart';
import 'package:pokedex_final_proyect/services/PokemonService.dart';
import 'package:provider/provider.dart';

class ItemFiltro extends StatefulWidget {
  final IconData icono;
  final String texto;

  const ItemFiltro({
    Key? key,
    required this.icono,
    required this.texto,
  }) : super(key: key);

  @override
  _ItemFiltroState createState() => _ItemFiltroState();
}

class _ItemFiltroState extends State<ItemFiltro> {
  late Set<String> selectedTypes;

  @override
  void initState() {
    super.initState();
    selectedTypes = Set<String>();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> pokemonTypes = [
      'normal',
      'fire',
      'water',
      'electric',
      'grass',
      'ice',
      'fighting',
      'poison',
      'ground',
      'flying',
      'psychic',
      'bug',
      'rock',
      'ghost',
      'dark',
      'steel',
      'fairy',
      'dragon'
    ];

    return Consumer<TypeSelected>(builder: (context, filterNotifier, child) {
      return InkWell(
        child: ListTile(
          leading: Icon(widget.icono),
          title: Text(widget.texto),
          onTap: () {
            
            if (widget.texto == "Filtrado por Tipo") {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.6,
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Selecciona los tipos de pokemones',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 20.0),
                              ElevatedButton(
                                onPressed: () async {
                                  final tipos = Provider.of<TypeSelected>(context, listen: false).selectedTypes;
                                  final test = await getPokemonNamesByTypes(tipos.first, tipos.last);


                                  Navigator.of(Provider.of<TypeSelected>(context, listen: false).ctx).push(
                                    MaterialPageRoute(
                                      builder: (context) => PokemonListFiltro(pokemonNames: test),
                                    ),
                                  );

                                  print(test.length);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red, // Color de fondo del botón
                                ),
                                child: const Text(
                                  "Aplicar",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 6,
                              crossAxisSpacing: 3.0,
                              mainAxisSpacing: 3.0,
                            ),
                            itemCount: 18,
                            itemBuilder: (BuildContext context, int index) {
                              final type = pokemonTypes[index];
                              bool isSelected = filterNotifier.selectedTypes.contains(type);

                              return TypeGridItem(
                                type: type,
                                isSelected: isSelected,
                                onSelected: (value) {
                                  filterNotifier.toggleType(type);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      );
    });
  }
}

class TypeGridItem extends StatefulWidget {
  final String type;
  late bool isSelected;
  final Function(bool) onSelected;

  TypeGridItem({
    Key? key,
    required this.type,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: key);

  @override
  _TypeGridItemState createState() => _TypeGridItemState();
}

class _TypeGridItemState extends State<TypeGridItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.isSelected = !widget.isSelected;
          widget.onSelected(widget.isSelected);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: sombreado(context, widget.type),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Image.asset(
          'assets/icon_types/${widget.type}.png',
          width: 15.0,
          height: 15.0,
        ),
      ),
    );
  }
}

Color? sombreado (context, type) {
  final providerSelected = Provider.of<TypeSelected>(context).selectedTypes;
  if (providerSelected.length == 2 && !providerSelected.contains(type)) {
    return null;
  } else if(providerSelected.length <= 2 && providerSelected.contains(type)) {
    return Colors.grey.withOpacity(0.5);
  }

}
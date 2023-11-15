import 'package:flutter/material.dart';


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
    final List<String> pokemonTypes = ['normal','fire','water','electric','grass','ice','fighting','poison','ground','flying','psychic','bug','rock','ghost','dark','steel','fairy','dragon'];

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
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(
                                    12.0), // Ajusta el radio según tus preferencias
                              ),
                              child: const Text(
                              "aplicar",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                backgroundColor: Colors.red
                              ),
                            ),
                            )
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        GridView.builder(
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 6,
                            crossAxisSpacing: 3.0,
                            mainAxisSpacing: 3.0,
                          ),
                          itemCount: 18,
                          itemBuilder: (BuildContext context, int index) {
                            final type = pokemonTypes[index];
                            bool isSelected = selectedTypes.contains(type);

                            return TypeGridItem(
                              type: type,
                              isSelected: isSelected,
                              onSelected: (value) {
                                setState(() {
                                  if (value) {
                                    if (selectedTypes.length < 2) {
                                      selectedTypes.add(type);
                                      print(selectedTypes);
                                    }
                                  } else {
                                    selectedTypes.remove(type);
                                    print(selectedTypes);
                                  }
                                });
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
          color: widget.isSelected ? Colors.grey.withOpacity(0.5) : null,
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

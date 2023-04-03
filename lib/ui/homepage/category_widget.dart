import 'package:flutter/material.dart';
import 'package:eventos_deportivos/common/utils/styleguide.dart';

import 'package:eventos_deportivos/models/Categoria.dart';

class CategoryWidget extends StatelessWidget {
  final Categoria categoria;

  const CategoryWidget({Key? key, required this.categoria}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final appState = Provider.of<AppState>(context);
    //final isSelected = appState.selectedCategoryId == categoria.id;
    final isSelected = false;

    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          //appState.updateCategoryId(categoria.id);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? Colors.white : Color(0x99FFFFFF), width: 3),
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: isSelected ? Colors.white : Colors.transparent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              //categoria.icon,
              Icons.sports,
              color: isSelected ? Theme.of(context).primaryColor : Colors.white,
              size: 40,
            ),
            SizedBox(height: 10,),
            Text(
              categoria.name,
              style: isSelected ? selectedCategoryTextStyle : categoryTextStyle,
            )
          ],
        ),
      ),
    );
  }
}

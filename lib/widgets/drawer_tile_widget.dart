import 'package:flutter/material.dart';

class DrawerTileWidget extends StatelessWidget {
  const DrawerTileWidget({
    Key? key,
    this.onTap,
    required this.text,
    required this.iconData,
    required this.selected,
  }) : super(key: key);
  final void Function()? onTap;
  final String text;
  final IconData iconData;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      selectedColor: Theme.of(context).primaryColor,
      selected: selected,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      leading: Icon(iconData),
      title: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwitchPreference extends StatelessWidget {
  final String title;
  final IconData? icon;
  final ValueChanged<bool> onChanged;
  final bool value;

  SwitchPreference({
    Key? key,
    required this.onChanged,
    required this.title,
    this.icon,
    this.value = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      //leading: CircleIcon(widget.icon),
      title: Text(title),
      trailing: SizedBox(
        width: 48,
        child: FittedBox(
          child: CupertinoSwitch(
            value: value,
            onChanged: (value) => onChanged(value),
            activeColor: Theme.of(context).colorScheme.primary
          )
        )
      ),
      onTap: () => onChanged(!value),
    );
  }
}
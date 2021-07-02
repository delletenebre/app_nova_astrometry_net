import 'package:flutter/material.dart';

class TextPreference extends StatelessWidget {
  const TextPreference({
    Key? key,
    required this.value,
    required this.onChanged,
    this.title = '',
    this.hint = '',
    this.defaultValue = '',
  }) : super(key: key);

  final String value;
  final String title;
  final String hint;
  final String defaultValue;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final _textEditindController = TextEditingController.fromValue(TextEditingValue(text: value));

    return ListTile(
      title: Text(title),
      subtitle: Text(value.isEmpty ? hint : value),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(title),
              content: TextField(
                controller: _textEditindController,
              ),
              actions: [
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    onChanged(_textEditindController.text);
                    Navigator.pop(context);
                  },
                )
              ],
            );
          },
        );
      },
    );
  }
}
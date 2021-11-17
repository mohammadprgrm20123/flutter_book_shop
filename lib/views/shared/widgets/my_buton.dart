import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function() onTap;
  final String label;
  final bool loading;
  final Color backgroundColor;

  const MyButton(
      {final Key key,
      final this.onTap,
      final this.label,
      final this.loading,
      final this.backgroundColor = const Color(0xFFF9A825)})
      : super(key: key);

  @override
  Widget build(final BuildContext context) => ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor)),
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (loading)
            const SizedBox(
              width: 15,
              height: 15,
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
              ),
            )
          else
            const SizedBox(),
          Text(label)
        ],
      ));
}

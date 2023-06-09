import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function() onTap;
  final String label;
  final bool loading;
  final Color backgroundColor;

  const MyButton(
      {
      required final this.onTap,
      required final this.label,
      required final this.loading,
      final this.backgroundColor = const Color(0xFFF9A825)});

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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

class TitleList extends StatelessWidget {
  final String title;
  final void Function() onTap;

  const TitleList({final this.title, final Key key, final this.onTap})
      : super(key: key);

  @override
  Widget build(final BuildContext context) => _titleOfList(context, title);

  Widget _titleOfList(final BuildContext context, final String text) =>
      GestureDetector(
        onTap: () {
          onTap?.call();
        },
        child: Row(
          children: [
            _textTitleList(context, text),
            _textMore(context),
            _iconArrow()
          ],
        ),
      );

  Widget _textMore(final BuildContext context) => Text(S.of(context).more);

  Widget _textTitleList(final BuildContext context, final String popular) =>
      Expanded(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(popular),
      ));

  Widget _iconArrow() => const Padding(
        padding: EdgeInsets.all(8.0),
        child: IconButton(
          onPressed: null,
          icon: Icon(Icons.arrow_forward_ios),
        ),
      );
}

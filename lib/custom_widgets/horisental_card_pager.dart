import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'card_item.dart';

typedef PageChangedCallback = void Function(double page);
typedef PageSelectedCallback = void Function(int index);

class HorizontalCardPager extends StatefulWidget {
  final List<CardItem> items;
  final PageChangedCallback onPageChanged;
  final PageSelectedCallback onSelectedItem;
  final int initialPage;

  const HorizontalCardPager(
      {required this.items,
      required this.onPageChanged,
      this.initialPage = 2,
      required this.onSelectedItem});

  @override
  _HorizontalCardPagerState createState() => _HorizontalCardPagerState();
}

class _HorizontalCardPagerState extends State<HorizontalCardPager> {
  bool _isScrolling = false;
  double _currentPosition = 2;
  PageController? _controller;

  @override
  void initState() {
    super.initState();

    _currentPosition = widget.initialPage.toDouble();
    _controller = PageController(initialPage: widget.initialPage);

    _controller!.addListener(() {
      setState(() {
        _currentPosition = _controller!.page!;

        Future(() => widget.onPageChanged(_currentPosition));
      });
    });
  }

  @override
  Widget build(final BuildContext context) =>
      LayoutBuilder(builder: (final context, final constraints) {
        final double viewWidth = constraints.maxWidth;
        final double viewHeight = viewWidth / 5.0;

        final double cardMaxWidth = viewHeight;
        final double cardMaxHeight = cardMaxWidth;

        return GestureDetector(
            onHorizontalDragEnd: (final details) {
              _isScrolling = false;
            },
            onHorizontalDragStart: (final details) {
              _isScrolling = true;
            },
            onTapUp: (final details) {
              if (_isScrolling == true) {
                return;
              }

              if ((_currentPosition - _currentPosition.floor()).abs() <= 0.15) {
                final int selectedIndex = _onTapUp(
                    context, viewHeight, viewWidth, _currentPosition, details);

                if (selectedIndex == 2) {
                  if (widget.onSelectedItem != null) {
                    Future(
                        () => widget.onSelectedItem(_currentPosition.round()));
                  }
                } else if (selectedIndex >= 0) {
                  final int goToPage =
                      _currentPosition.toInt() + selectedIndex - 2;
                  _controller!.animateToPage(goToPage,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOutExpo);
                }
              }
            },
            child: CardListWidget(
              items: widget.items,
              controller: _controller!,
              viewWidth: viewWidth,
              selectedIndex: _currentPosition,
              cardMaxHeight: cardMaxHeight + 90,
              cardMaxWidth: cardMaxWidth + 60,
            ));
      });

  int _onTapUp(final context, final cardMaxWidth, final viewWidth,
      final currentPosition, final details) {
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);

    final double dx = localOffset.dx;

    for (int i = 0; i < 5; i++) {
      final double cardWidth = _getCardSize(cardMaxWidth, i, 2.0);
      final double left =
          _getStartPosition(cardWidth, cardMaxWidth, viewWidth, i, 2.0);

      if (left <= dx && dx <= left + cardWidth) {
        return i;
      }
    }
    return -1;
  }
}

class CardListWidget extends StatefulWidget {
  final PageController controller;
  final double cardMaxWidth;
  final double cardMaxHeight;
  final double viewWidth;
  final List<CardItem> items;
  final double selectedIndex;

  const CardListWidget({
    required this.controller,
    required this.cardMaxHeight,
    required this.cardMaxWidth,
    required this.items,
    required this.viewWidth,
    this.selectedIndex = 2.0,
  });

  @override
  _CardListWidgetState createState() => _CardListWidgetState();
}

class _CardListWidgetState extends State<CardListWidget> {
  double selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    selectedIndex = widget.selectedIndex;

    widget.controller.addListener(() {
      setState(() {
        selectedIndex = widget.controller.page!;
      });
    });
  }

  @override
  Widget build(final BuildContext context) {
    final List<Widget> cardList = [];

    for (int i = 0; i < widget.items.length; i++) {
      final double cardWidth =
          _getCardSize(widget.cardMaxWidth, i, selectedIndex);
      final double cardHeight = cardWidth;

      final Widget card = Positioned.directional(
          textDirection: TextDirection.ltr,
          top: _getTopPositon(cardHeight, widget.cardMaxHeight),
          start: _getStartPosition(cardWidth, widget.cardMaxWidth,
              widget.viewWidth, i, selectedIndex),
          child: Opacity(
            opacity: _getOpacity(i),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                width: cardWidth,
                height: cardHeight,
                child: Center(
                  child: widget.items[i]
                      .buildWidget((i.toDouble() - selectedIndex).abs()),
                ),
              ),
            ),
          ));

      cardList.add(card);
    }

    return Stack(children: [
      Container(
        height: widget.cardMaxHeight,
        child: Stack(
          children: cardList,
        ),
      ),
      Positioned.fill(
        child: PageView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.items.length,
          controller: widget.controller,
          itemBuilder: (final context, final index) => Container(),
        ),
      )
    ]);
  }

  double _getOpacity(final int cardIndex) {
    final double diff = selectedIndex - cardIndex;

    if (diff >= -2 && diff <= 2) {
      return 1.0;
    } else if (diff > -3 && diff < -2) {
      return 3 - diff.abs();
    } else if (diff > 2 && diff < 3) {
      return 3 - diff.abs();
    } else {
      return 0;
    }
  }
}

double _getTopPositon(final double cardHeigth, final double viewHeight) =>
    (viewHeight - cardHeigth) / 2;

double _getStartPosition(final double cardWidth, final double cardMaxWidth,
    final double viewWidth, final int cardIndex, final double selectedIndex) {
  final double diff = selectedIndex - cardIndex;
  final double diffAbs = diff.abs();

  final double basePosition = (viewWidth / 2) - (cardWidth / 2);

  if (diffAbs == 0) {
    return basePosition;
  }
  if (diffAbs > 0.0 && diffAbs <= 1.0) {
    if (diff >= 0) {
      return basePosition - (cardMaxWidth * 1.1) * diffAbs;
    } else {
      return basePosition + (cardMaxWidth * 1.1) * diffAbs;
    }
  } else if (diffAbs > 1.0 && diffAbs < 2.0) {
    if (diff >= 0) {
      return basePosition -
          (cardMaxWidth * 1.1) -
          cardMaxWidth * 0.9 * (diffAbs - diffAbs.floor()).abs();
    } else {
      return basePosition +
          (cardMaxWidth * 1.1) +
          cardMaxWidth * 0.9 * (diffAbs - diffAbs.floor()).abs();
    }
  } else {
    if (diff >= 0) {
      return basePosition - cardMaxWidth * 2;
    } else {
      return basePosition + cardMaxWidth * 2;
    }
  }
}

double _getCardSize(final double cardMaxWidth, final int cardIndex,
    final double selectedIndex) {
  final double diff = (selectedIndex - cardIndex).abs();

  if (diff >= 0.0 && diff < 1.0) {
    return cardMaxWidth - cardMaxWidth * (1 / 5) * ((diff - diff.floor()));
  } else if (diff >= 1.0 && diff < 2.0) {
    return cardMaxWidth - cardMaxWidth * (1 / 5) - 10 * ((diff - diff.floor()));
  } else if (diff >= 2.0 && diff < 3.0) {
    final size = cardMaxWidth -
        cardMaxWidth * (1 / 8) -
        10 -
        5 * ((diff - diff.floor()));

    return size > 0 ? size : 0;
  } else {
    final size = cardMaxWidth - cardMaxWidth * (1 / 8) - 15;

    return size > 0 ? size : 0;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum SliderIndicatorPosition {
  top,
  bottom,
}

class PageSlider extends StatefulWidget {
  ///
  /// the list for widget passed to the [PageView]
  ///
  final List<Widget> widgets;

  ///
  /// true to hide slider indicator widget (dots), false otherwise.
  ///
  final bool hideSliderIndicator;

  ///
  /// true to hide pagination indexer widget (left and right arrows), false otherwise
  ///
  final bool hidePaginationIndexer;

  ///
  /// true to hide put the slider indicator on top of the [widgets],
  /// false to put it before/after the widgets according to [sliderIndicatorPosition] value.
  ///
  final bool overlaySliderIndicator;

  ///
  /// true to hide pagination indexer widget (left and right arrows), false otherwise
  ///
  final bool disableSWiping;

  /// Set to false to disable page snapping, useful for custom scroll behavior.
  final bool pageSnapping;

  ///
  /// see [PageView.reverse]
  ///
  final bool reverse;

  ///
  /// see [PageView.scrollDirection]
  ///
  final Axis scrollDirection;

  ///
  /// height og the pageView, if not specified, the [widgets] will take available space.
  ///
  final double height;

  ///
  /// the position of the slider Indicator widget
  /// with two possible value
  ///   [SliderIndicatorPosition.top]
  ///   [SliderIndicatorPosition.bottom]
  ///
  final SliderIndicatorPosition sliderIndicatorPosition;

  ///
  /// callBack when the page changes
  ///
  final Function(int value) onPageChanged;

  ///
  /// initial page index, starting from 0,..., [widgets.length]-1
  ///
  final int initialPage;

  @override
  _PageSliderState createState() => _PageSliderState();

  const PageSlider({
    final Key key,
    final this.widgets = const <Widget>[],
    final this.hideSliderIndicator = false,
    final this.hidePaginationIndexer = false,
    final this.overlaySliderIndicator = false,
    final this.disableSWiping = false,
    final this.reverse = false,
    final this.pageSnapping = true,
    final this.onPageChanged,
    final this.height,
    final this.initialPage = 0,
    final this.scrollDirection = Axis.horizontal,
    final this.sliderIndicatorPosition = SliderIndicatorPosition.bottom,
  })  : assert(
            initialPage == 0 && widgets.length == 0 ||
                initialPage < widgets.length,
            'InitialPage cannot be null and it should be strictly less than the number of widgets'),
        super(key: key);
}

class _PageSliderState extends State<PageSlider> {
  PageController pageController;
  int _currentIndex;

  final scrollController = ScrollController(initialScrollOffset: 0);

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: widget.initialPage ?? 0,
    );
    _currentIndex = widget.initialPage ?? 0;
  }

  @override
  Widget build(final BuildContext context) {
    final bool isFullScreen = widget.height == null;
    final Widget sliderIndicator = widget.hideSliderIndicator
        ? Container()
        : getSliderIndexer(_currentIndex, widget.widgets.length);

    final List<Widget> widgetsListForColumn = <Widget>[
      if (!isFullScreen)
        getPageViewWidget()
      else
        Expanded(flex: 20, child: getPageViewWidget()),
      sliderIndicator,
    ];

    return widget.overlaySliderIndicator
        ? Column(
            children: <Widget>[
              if (!isFullScreen)
                getPageViewWidget(sliderIndicator: sliderIndicator)
              else
                Expanded(
                  flex: 20,
                  child: getPageViewWidget(sliderIndicator: sliderIndicator),
                )
            ],
          )
        : Column(
            children:
                widget.sliderIndicatorPosition == SliderIndicatorPosition.bottom
                    ? widgetsListForColumn
                    : widgetsListForColumn.reversed.toList(),
          );
  }

  Widget getPageViewWidget({final Widget sliderIndicator}) => Container(
        height: widget.height,
        child: Stack(
          children: <Widget>[
            PageView(
              controller: pageController,
              physics: widget.disableSWiping
                  ? const NeverScrollableScrollPhysics()
                  : null,
              pageSnapping: widget.pageSnapping,
              reverse: widget.reverse,
              scrollDirection: widget.scrollDirection,
              onPageChanged: (final page) {
                setState(() => _currentIndex = page);
                if (widget.onPageChanged != null) {
                  widget.onPageChanged(page);
                }
              },
              children: widget.widgets,
            ),
            if (widget.hidePaginationIndexer)
              Container()
            else
              Container(
                height: widget.height,
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        getPaginationIndexer(
                          Icons.navigate_before,
                          () {
                            if (_currentIndex > 0) {
                              setState(() => --_currentIndex);
                              animateTo(_currentIndex, increase: false);
                            }
                          },
                        ),
                        getPaginationIndexer(
                          Icons.navigate_next,
                          () {
                            if (_currentIndex < widget.widgets.length - 1) {
                              setState(() => ++_currentIndex);
                              animateTo(_currentIndex);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            Container(
              height: widget.height,
              child: Column(
                mainAxisAlignment: widget.sliderIndicatorPosition ==
                        SliderIndicatorPosition.bottom
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: <Widget>[sliderIndicator ?? Container()],
              ),
            )
          ],
        ),
      );

  void animateTo(final int page, {final bool increase = true}) {
    pageController.animateToPage(
      _currentIndex,
      duration: const Duration(seconds: 1),
      curve: Curves.ease,
    );
    if (scrollController.hasClients) {
      double offset = _currentIndex + 10.0;
      offset =
          increase ? offset + 3 * _currentIndex : offset - 3 * _currentIndex;
      scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.linear,
      );
    }
  }

  Widget getPaginationIndexer(final IconData icon, final Function onPressed) =>
      Container(
        width: 30,
        height: 30,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(128, 128, 128, 0.7),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: Icon(
            icon,
            color: Colors.white,
          ),
          onPressed: onPressed,
        ),
      );

  Widget getSliderIndexer(final int currentIndex, final int length) => Center(
        child: Container(
          height: 30,
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: scrollController,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List<Padding>.generate(
                  length,
                  (final i) => Padding(
                        padding: const EdgeInsets.only(right: 3),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentIndex == i
                                  ? Colors.grey
                                  : const Color(0xffe2e2e2),
                            ),
                          ),
                          onTap: () {
                            setState(() => _currentIndex = i);
                            animateTo(_currentIndex);
                          },
                        ),
                      )),
            ),
          ),
        ),
      );
}

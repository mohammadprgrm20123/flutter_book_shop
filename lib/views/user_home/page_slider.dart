import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum SliderIndicatorPosition {
  TOP,
  BOTTOM,
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
  ///   [SliderIndicatorPosition.TOP]
  ///   [SliderIndicatorPosition.BOTTOM]
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
    Key key,
    this.widgets = const <Widget>[],
    this.hideSliderIndicator = false,
    this.hidePaginationIndexer = false,
    this.overlaySliderIndicator = false,
    this.disableSWiping = false,
    this.reverse = false,
    this.pageSnapping = true,
    this.onPageChanged,
    this.height,
    this.initialPage = 0,
    this.scrollDirection = Axis.horizontal,
    this.sliderIndicatorPosition = SliderIndicatorPosition.BOTTOM,
  })  : assert(
  initialPage == 0 && widgets.length == 0 ||
      initialPage < widgets.length,
  "InitialPage cannot be null and it should be strictly less than the number of widgets"),
        super(key: key);
}

class _PageSliderState extends State<PageSlider> {
  PageController pageController;
  int _currentIndex;

  ScrollController _scrollController = ScrollController(initialScrollOffset: 0);

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: widget.initialPage ?? 0,
    );
    _currentIndex = widget.initialPage ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    bool isFullScreen = widget.height == null;
    Widget sliderIndicator = widget.hideSliderIndicator
        ? Container()
        : getSliderIndexer(_currentIndex, widget.widgets.length);

    List<Widget> widgetsListForColumn = <Widget>[
      !isFullScreen
          ? getPageViewWidget()
          : Expanded(child: getPageViewWidget(), flex: 20),
      sliderIndicator,
    ];

    return widget.overlaySliderIndicator
        ? Column(
      children: <Widget>[
        !isFullScreen
            ? getPageViewWidget(sliderIndicator: sliderIndicator)
            : Expanded(
          child:
          getPageViewWidget(sliderIndicator: sliderIndicator),
          flex: 20,
        )
      ],
    )
        : Column(
      children:
      widget.sliderIndicatorPosition == SliderIndicatorPosition.BOTTOM
          ? widgetsListForColumn
          : widgetsListForColumn.reversed.toList(),
    );
  }

  Widget getPageViewWidget({Widget sliderIndicator}) {
    return Container(
      height: widget.height,
      child: Stack(
        children: <Widget>[
          PageView(
            controller: pageController,
            physics:
            widget.disableSWiping ? NeverScrollableScrollPhysics() : null,
            pageSnapping: widget.pageSnapping,
            reverse: widget.reverse,
            scrollDirection: widget.scrollDirection,
            onPageChanged: (page) {
              setState(() => _currentIndex = page);
              if (widget.onPageChanged != null) {
                widget.onPageChanged(page);
              }
            },
            children: widget.widgets,
          ),
          widget.hidePaginationIndexer
              ? Container()
              : Container(
            height: widget.height,
            padding: EdgeInsets.all(2.0),
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
                  SliderIndicatorPosition.BOTTOM
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: <Widget>[sliderIndicator ?? Container()],
            ),
          )
        ],
      ),
    );
  }

  void animateTo(int page, {bool increase = true}) {
    pageController.animateToPage(
      _currentIndex,
      duration: Duration(seconds: 1),
      curve: Curves.ease,
    );
    if (_scrollController.hasClients) {
      double offset = _currentIndex + 10.0;
      offset =
      increase ? offset + 3 * _currentIndex : offset - 3 * _currentIndex;
      _scrollController.animateTo(
        offset,
        duration: Duration(milliseconds: 500),
        curve: Curves.linear,
      );
    }
  }

  Widget getPaginationIndexer(IconData icon, Function onPressed) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: Color.fromRGBO(128, 128, 128, 0.7),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        padding: EdgeInsets.all(0.0),
        onPressed: onPressed,
      ),
    );
  }

  Widget getSliderIndexer(int currentIndex, int length) {
    return Center(
      child: Container(
        height: 30,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List<Padding>.generate(length, (i) {
              return Padding(
                padding: EdgeInsets.only(right: 3),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 10,
                    width: 10,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentIndex == i ? Colors.grey : Color(0xffe2e2e2),
                    ),
                  ),
                  onTap: () {
                    setState(() => _currentIndex = i);
                    animateTo(_currentIndex);
                  },
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
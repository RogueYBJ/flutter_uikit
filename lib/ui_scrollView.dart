/*
 * @Author Bangjin Yu
 * @Email: 1227169416@qq.com
 * @Address: 梦想小镇互联网村
 * @Date 2019-12-25 11:10:42 Wednesday
 */

import 'dart:async';

import 'package:flutter/material.dart';

import 'flutter_uikit.dart';

class UIPageView extends StatefulWidget {
  final List dataSource;

  final EdgeInsetsGeometry padding;

  final double height;

  final Function child;

  final Function onTap;

  const UIPageView({
    Key key,
    this.dataSource,
    this.padding,
    this.height,
    this.child,
    this.onTap,
  }) : super(key: key);

  _UIPageView createState() => new _UIPageView();
}

class _UIPageView extends State<UIPageView> {
  PageController _pageController = new PageController();

  int _pages = 0;

  Timer _timer;

  int _times = 0;

  void _countdown() {
    if (!mounted) {
      return;
    }
    _timer = new Timer.periodic(new Duration(seconds: 1), (timer) {
      if (!mounted) {
        return;
      }
      if (widget.dataSource == null || widget.dataSource.length == 0) {
        return;
      } else {
        _times += 1;
        if (_times == 3) {
          _pages += 1;
          _pageController.animateToPage(_pages,
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      _times = 0;
      _pages = _pageController.offset ~/ MediaQuery.of(context).size.width;
      if (_pageController.offset / MediaQuery.of(context).size.width <= 0) {
        _pageController.jumpToPage(widget.dataSource.length - 2);
      } else if (_pageController.offset / MediaQuery.of(context).size.width ==
          widget.dataSource.length - 1) {
        _pageController.jumpToPage(1);
      }
      setState(() {});
    });
    _countdown();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    _timer = null;
    print('_timer');
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: widget.height ?? 170,
      child: new PageView.builder(
        controller: _pageController,
        physics: PageScrollPhysics(parent: BouncingScrollPhysics()),
        scrollDirection: Axis.horizontal,
        itemCount: widget.dataSource?.length ?? 0,
        itemBuilder: (BuildContext context, int position) {
          return widget.child != null
              ? widget.child(position, widget.dataSource[position])
              : new GestureDetector(
                  onTap: () => widget.onTap == null
                      ? () {}
                      : widget.onTap(position, widget.dataSource[position]),
                  child: new Container(
                    padding: widget.padding ??
                        EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                    child: UIImage(
                      imgStr: widget.dataSource[position],
                      fit: BoxFit.fill,
                    ),
                  ),
                );
        },
      ),
    );
  }
}

/*
 * @Author Bangjin Yu
 * @Email: 1227169416@qq.com
 * @Address: 梦想小镇互联网村
 * @Date 2019-12-25 11:10:42 Wednesday
 */

import 'dart:async';

import 'package:flutter/material.dart';

class UIScrollView extends StatefulWidget {
  final List dataSource;

  final EdgeInsetsGeometry padding;

  final double height;

  final Function child;

  final Function onTap;

  const UIScrollView({
    Key key,
    this.dataSource,
    this.padding,
    this.height,
    this.child,
    this.onTap,
  }) : super(key: key);

  _UIScrollView createState() => new _UIScrollView();
}

class _UIScrollView extends State<UIScrollView> {
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
          return widget.child(position, widget.dataSource[position]);
        },
      ),
    );
  }
}

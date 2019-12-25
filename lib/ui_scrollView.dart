/*
 * @Author Bangjin Yu
 * @Email: 1227169416@qq.com
 * @Address: 梦想小镇互联网村
 * @Date 2019-12-25 11:10:42 Wednesday
 */

import 'package:flutter/material.dart';

class UIScrollView extends StatefulWidget {
  final List dataSource;
  final Function item;
  const UIScrollView({
    Key key,
    this.dataSource,
    this.item,
  }) : super(key: key);
  _UIScrollView createState() => new _UIScrollView();
}

class _UIScrollView extends State<UIScrollView> {
  List monthsOfTheYear = ['1', '2', '3', '4'];
  @override
  Widget build(BuildContext context) {
    return new Container();
  }
    // return PageView.builder(
    //   itemBuilder: ,
    // );
  //   return new CustomScrollView(
  //     cacheExtent: 20,
  //     scrollDirection: Axis.horizontal,
  //     controller: ScrollController(
  //         initialScrollOffset: 100), //FixedExtentScrollController
  //     reverse: false,
  //     primary: false,
  //     physics:
  //         ClampingScrollPhysics(), //BouncingScrollPhysics ios , ClampingScrollPhysics android , FixedExtentScrollPhysics 其他
  //     slivers: <Widget>[
  //       SliverList(
  //         delegate: SliverChildListDelegate(
  //           //返回组件集合
  //           List.generate(
  //             widget.dataSource?.length ?? 0,
  //             (int index) {
  //               return widget.item(index, widget.dataSource[index]);
  //             },
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}

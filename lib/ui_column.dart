/*
 * @Author BangJin Yu
 * @Email: 1227169416@qq.com
 * @Address: 梦想小镇互联网村
 * @Date 2019-12-25 20:47:52 Wednesday
 */



import 'package:flutter/material.dart';

class UIColumn extends StatelessWidget {

  final List dataSource;

  final Function view;

  final MainAxisAlignment mainAxisAlignment;

  final CrossAxisAlignment crossAxisAlignment;

  final MainAxisSize mainAxisSize;

  const UIColumn({Key key, this.dataSource, this.view, this.mainAxisAlignment, this.mainAxisSize, this.crossAxisAlignment}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: this.mainAxisAlignment ?? MainAxisAlignment.start,
      crossAxisAlignment: this.crossAxisAlignment ?? CrossAxisAlignment.start,
      mainAxisSize: this.mainAxisSize ?? MainAxisSize.max,
      children: _getListView(),
    );
  }

  List<Widget> _getListView() {
    List<Widget> list = [];
    for (var i = 0; i < this?.dataSource?.length ?? []; i++) {
      if (this.view != null) {
        list.add(this.view(i, this.dataSource[i]));
      } else {
        list.add(new Container());
      }
    }
    return list;
  }
}

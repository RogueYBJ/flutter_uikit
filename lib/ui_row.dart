/*
 * @Author Bangjin Yu
 * @Email: 1227169416@qq.com
 * @Address: 梦想小镇互联网村
 * @Date 2019-12-25 20:48:00 Wednesday
 */


import 'package:flutter/material.dart';

class UIRow extends StatefulWidget {
  final List dataSource;

  final Function view;

  final MainAxisAlignment mainAxisAlignment;

  final MainAxisSize mainAxisSize;

  const UIRow({Key key, this.dataSource, this.view, this.mainAxisAlignment, this.mainAxisSize}) : super(key: key);

  _UIRow createState() => new _UIRow();
}

class _UIRow extends State<UIRow> {
  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: widget.mainAxisAlignment ?? MainAxisAlignment.start,
      mainAxisSize: widget.mainAxisSize ?? MainAxisSize.max,
      children: _getListView(),
    );
  }

  List<Widget> _getListView() {
    List<Widget> list = [];
    for (var i = 0; i < widget.dataSource.length; i++) {
      if (widget.view != null) {
        list.add(widget.view(i, widget.dataSource[i]));
      } else {
        list.add(new Container());
      }
    }
    return list;
  }
}

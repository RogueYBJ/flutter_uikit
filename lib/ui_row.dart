/*
 * @Author Bangjin Yu
 * @Email: 1227169416@qq.com
 * @Address: 梦想小镇互联网村
 * @Date 2019-12-25 20:48:00 Wednesday
 */


import 'package:flutter/material.dart';

class UIRow<T> extends StatefulWidget {
  final List<T> dataSource;

  final Widget Function(int tag,T data) view;

  final MainAxisAlignment mainAxisAlignment;

  final CrossAxisAlignment crossAxisAlignment;

  final MainAxisSize mainAxisSize;

  const UIRow({Key key, this.dataSource, this.view, this.mainAxisAlignment, this.mainAxisSize, this.crossAxisAlignment}) : super(key: key);

  _UIRow createState() => new _UIRow();
}

class _UIRow extends State<UIRow> {
  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: widget.mainAxisAlignment ?? MainAxisAlignment.start,
      crossAxisAlignment: widget.crossAxisAlignment ?? CrossAxisAlignment.start,
      mainAxisSize: widget.mainAxisSize ?? MainAxisSize.max,
      children: _getListView(),
    );
  }

  List<Widget> _getListView() {
    List<Widget> list = [];
    for (var i = 0; i < widget.dataSource?.length ?? 0; i++) {
      if (widget.view != null) {
        list.add(widget.view(i, widget.dataSource[i]));
      } else {
        list.add(new Container());
      }
    }
    return list;
  }
}

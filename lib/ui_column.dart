/*
 * @Author Bangjin Yu
 * @Email: 1227169416@qq.com
 * @Address: 梦想小镇互联网村
 * @Date 2019-12-25 20:47:52 Wednesday
 */



import 'package:flutter/material.dart';

class UIColumn extends StatefulWidget {

  final List dataSource;

  final Function view;

  final MainAxisAlignment mainAxisAlignment;

  final CrossAxisAlignment crossAxisAlignment;

  final MainAxisSize mainAxisSize;

  const UIColumn({Key key, this.dataSource, this.view, this.mainAxisAlignment, this.mainAxisSize, this.crossAxisAlignment}) : super(key: key);

  _UIColumn createState() => new _UIColumn();
}

class _UIColumn extends State<UIColumn> {
  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: widget.mainAxisAlignment ?? MainAxisAlignment.start,
      crossAxisAlignment: widget.crossAxisAlignment ?? CrossAxisAlignment.start,
      mainAxisSize: widget.mainAxisSize ?? MainAxisSize.max,
      children: _getListView(),
    );
  }

  List<Widget> _getListView() {
    List<Widget> list = [];
    for (var i = 0; i < widget?.dataSource?.length ?? []; i++) {
      if (widget.view != null) {
        list.add(widget.view(i, widget.dataSource[i]));
      } else {
        list.add(new Container());
      }
    }
    return list;
  }
}

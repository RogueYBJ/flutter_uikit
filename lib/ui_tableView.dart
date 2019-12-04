/*
 * @Author Bangjin Yu
 * @Email: 1227169416@qq.com
 * @Address: 梦想小镇互联网村
 * @Date 2019-12-04 11:29:42 Wednesday
 */

import 'package:flutter/material.dart';
import 'package:flutter_refresh/flutter_refresh.dart';
import 'package:flutter_uikit/flutter_uikit.dart';

class UITableView extends StatefulWidget {
  final int group;
  final Function itemsNumAction;
  final Function item;
  final Widget header;
  final Widget footer;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final Function upData;
  final Function downData;
  final Function newData;
  final Widget backView;
  final String backImgStr;
  const UITableView({
    Key key,
    @required this.item,
    this.group = 1,
    @required this.itemsNumAction,
    this.upData,
    this.downData,
    this.header,
    this.footer,
    this.margin,
    this.padding,
    this.backView,
    this.backImgStr,
    this.newData,
  }) : super(key: key);
  _UITableView createState() => new _UITableView();
}

class _UITableView extends State<UITableView> {
  List<int> _itemsList = [];

  int _items = 0;

  // 顶部刷新
  Future<Null> onHeaderRefresh() {
    return new Future.delayed(new Duration(seconds: 1), () {
      widget.upData();
    });
  }

  // 底部加载
  Future<Null> onFooterRefresh() async {
    return new Future.delayed(new Duration(seconds: 1), () {
      widget.downData();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setItemsNum();
  }

  void _setItemsNum() {
    _itemsList = [];
    _items = 0;
    for (var i = 1; i <= widget.group; i++) {
      int index = widget.itemsNumAction(i);
      _items += index;
      _itemsList.add(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _getItemCount() == 0
        ? _backView()
        : (widget.upData != null || widget.downData != null)
            ? new Refresh(
                onHeaderRefresh: onHeaderRefresh,
                onFooterRefresh: onFooterRefresh,
                childBuilder: (BuildContext context,
                    {ScrollController controller, ScrollPhysics physics}) {
                  return new Container(
                    margin: widget.margin,
                    child:
                        _getListView(controller: controller, physics: physics),
                  );
                },
              )
            : _getListView();
  }

  Widget _backView() {
    return widget.backView != null
        ? widget.backView
        : new Container(
            child: new Center(
              child: new UIButton(
                onPressed: () {
                  if (widget.newData!=null) {
                    widget.newData();
                  }else{
                    if (widget.upData != null) {
                      widget.upData();
                    }
                  }
                },
                color: 0x00000000,
                buttonState: UIButtonState(
                    title: '点击刷新',
                    imgStr: widget.backImgStr,
                    color: 0xFF666666),
              ),
            ),
          );
  }

  int _getItemCount() {
    return _items +
        (widget.header == null ? 0 : 1) +
        (widget.footer == null ? 0 : 1);
  }

  Widget _getListView({ScrollController controller, ScrollPhysics physics}) {
    return new ListView.builder(
        padding: widget.padding,
        controller: controller,
        physics: physics,
        itemCount: _getItemCount(),
        itemBuilder: (BuildContext context, int position) {
          if (widget.header != null && widget.footer != null) {
            if (position == 0) {
              return widget.header;
            } else if (position == _getItemCount() - 1) {
              return widget.footer;
            } else {
              return _itemView(
                  group: _group(position - 1),
                  index: _index(position - 1)); //position - 1
            }
          } else if (widget.header != null) {
            return position == 0
                ? widget.header
                : _itemView(
                    group: _group(position - 1),
                    index: _index(position - 1)); //position - 1
          } else if (widget.footer != null) {
            return position == _getItemCount() - 1
                ? widget.footer
                : _itemView(
                    group: _group(position),
                    index: _index(position)); //position
          } else {
            return _itemView(
                group: _group(position), index: _index(position)); //position
          }
        });
  }

  Widget _itemView({int group, int index}) {
    return widget.item(group, index);
  }

  int _group(int position) {
    int items = 0;
    for (var i = 0; i <= _itemsList.length; i++) {
      items += _itemsList[i];
      if (items - 1 >= position) {
        return i + 1;
      }
    }
    return 1;
  }

  int _index(int position) {
    int items = 0;
    for (var i = 0; i <= _itemsList.length; i++) {
      items += _itemsList[i];
      if (items - 1 >= position) {
        return position - (items - _itemsList[i]);
      }
    }
    return 0;
  }
}

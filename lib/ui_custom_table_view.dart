/*
 * @author: 余邦锦（RogueYBJ） 
 * @date 2020/11/18.
 * slogan: 每行代码的开始都意味着新的征程
 * E-Mail Address：15179861454@163.com
 * Work Address: 浙江省杭州市滨江区聚光中心1704
 * file Address: lib/ui_kit/ui_custom_table_view
 * description: ui_custom_table_view
 */

import 'package:flutter/material.dart' hide Action;
import 'package:flutter_uikit/flutter_uikit.dart';
import 'package:flutter_refresh/flutter_refresh.dart';


class UICustomTableView extends StatefulWidget {
  final int group; // 组
  final int Function(int group) length; // 每组的长度
  final Widget Function(int group, int index) item; // itemView
  final Widget headerView; // 头部
  final Widget footerView; // 尾部
  final SliverChildDelegate Function(int group) delegate; // 协议
  final Widget Function(int group) itemList; // 每组的列表
  final Widget Function(int group) groupHeader; // 每组的头部
  final Widget Function(int group) groupFooter; // 每组的尾部
  final SliverPersistentHeader persistentHeader; // 吸顶头部
  final SliverAppBar appBar; // appbar
  final Widget sliverFill; // 底部填充

  final Function upData; // 下拉刷新
  final Function downData; // 上啦加载
  final EdgeInsetsGeometry margin; // 外边距
  final EdgeInsetsGeometry padding; // 内边距
  final Decoration decoration; // 样式
  final Axis axis; // 滑动方式
  final ScrollController controller; // 滑动控制器
  final ScrollPhysics physics; // 滑动样式
  final Color color; // 颜色 ps：样式会干掉颜色
  final bool removeTop; // 是否删除状态栏的高度

  const UICustomTableView({
    Key key,
    this.margin,
    this.padding,
    this.axis,
    this.controller,
    this.physics,
    this.itemList,
    this.headerView,
    this.footerView,
    this.groupHeader,
    this.groupFooter,
    this.group = 1,
    this.length,
    this.item,
    this.delegate,
    this.persistentHeader,
    this.appBar,
    this.sliverFill,
    this.color, this.removeTop, this.decoration, this.upData, this.downData,
  }) : super(key: key);

 @override
 _UICustomTableView createState() => _UICustomTableView();
}

class _UICustomTableView extends State<UICustomTableView> {
  // 顶部刷新
  Future<Null> onHeaderRefresh() {
    return new Future.delayed(new Duration(seconds: 1), () {
      if (widget.upData != null) {
        widget.upData();
      }
    });
  }

  // 底部加载
  Future<Null> onFooterRefresh() async {
    return new Future.delayed(new Duration(seconds: 1), () {
      if (widget.downData != null) {
        widget.downData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        removeTop: widget.removeTop ?? true,
        context: context,
        child: new Refresh(
          physics: widget.physics,
          scrollController: widget.controller,
          onHeaderRefresh: widget.upData != null ? onHeaderRefresh : null,
          onFooterRefresh: widget.downData != null ? onFooterRefresh : null,
          childBuilder: (BuildContext context,
              {ScrollController controller, ScrollPhysics physics}) {
            return new Container(
              margin: widget.margin,
              padding: widget.padding,
              decoration: widget.decoration ?? BoxDecoration(
                color: widget.color,
              ),
              child: _getListView(controller: controller, physics: physics),
            );
          },
        ));
  }

  Widget _getListView({ScrollController controller, ScrollPhysics physics}) {
    return CustomScrollView(
      controller: controller,
      physics: physics,
      slivers: sliversList(),
    );
  }

  List<Widget> sliversList() {
    // 创建空列表 slivers
    List<Widget> slivers = [];

    if (widget.appBar != null) {
      slivers.add(widget.appBar);
    }

    // 添加 列表头部 headerView
    if (widget.headerView != null) {
      slivers.add(SliverToBoxAdapter(
        child: widget.headerView,
      ));
    }

    // 添加 列表头部 headerView
    if (widget.persistentHeader != null) {
      slivers.add(widget.persistentHeader);
    }

    // 遍历 每组的数据 group
    for (int i = 0; i < (widget.group ?? 0); i++) {
      // 添加 每组的头部 groupHeader
      if (widget.groupHeader != null) {
        slivers.add(SliverToBoxAdapter(
          child: widget.groupHeader(i),
        ));
      }

      // 添加 每组的SliverList SliverList
      if(widget.itemList!=null){
        slivers.add( widget.itemList(i) ?? SliverList(
          delegate: widget.delegate != null ? widget.delegate(i) :  SliverChildBuilderDelegate(
                (BuildContext context, int position) {
              return widget.item == null ? Container() :  widget.item(i, position);
            },
            childCount: widget.length(i) ?? 0,
          ),
        ));
      }else{
        if (widget.length != null) {
          slivers.add(SliverList(
            delegate: widget.delegate != null ? widget.delegate(i) : SliverChildBuilderDelegate(
                  (BuildContext context, int position) {
                return widget.item == null ? Container() : widget.item(i, position);
              },
              childCount: widget.length(i) ?? 0,
            ),
          ));
        }
      }

      // 添加 每组的尾部 groupFooter
      if (widget.groupFooter != null) {
        slivers.add(SliverToBoxAdapter(
          child: widget.groupFooter(i),
        ));
      }
    }

    // 添加 列表尾部 footerView
    if (widget.footerView != null) {
      slivers.add(SliverToBoxAdapter(
        child: widget.footerView,
      ));
    }

//    slivers.add(SliverFillRemaining(
//      child: widget.sliverFill ?? Container(child: Text('asds'),),
//    ));

    return slivers;
  }
}

class CustomSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget Function(double shrinkOffset, bool overlapsContent) buildView;
  final double min;
  final double max;

  CustomSliverHeaderDelegate({
    @required this.buildView,
    this.min,
    this.max,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.buildView(shrinkOffset, overlapsContent);
  }

  @override
  double get maxExtent => this.max ?? 100; //this.max ?? 100;

  @override
  double get minExtent => this.min ?? 100; //this.min ?? 100;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class CustomVideoSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  CustomVideoSliverHeaderDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
  }

  @override
  double get maxExtent => 400;

  @override
  double get minExtent => 400;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
/*
 * @author: 余邦锦（RogueYBJ） 
 * @date 2020/12/1.
 * slogan: 每行代码的开始都意味着新的征程
 * E-Mail Address：15179861454@163.com
 * Work Address: 浙江省杭州市滨江区聚光中心1704
 * file Address: lib//ui_scroll_page
 * description: ui_scroll_page
 */

import 'package:flutter/material.dart' hide Action;

class UIScrollPage extends StatefulWidget {
  final List dataList; // 数据源
  final double viewport; // 缩小比例
  final double marginAll; // 边距
  final Function itemBuilder; // 构建item
  const UIScrollPage({Key key, this.viewport, this.marginAll, this.dataList, this.itemBuilder})
      : super(key: key);

  _UIScrollPage createState() => new _UIScrollPage();
}

class _UIScrollPage extends State<UIScrollPage> {
  // 定义控制器
  PageController _controller = PageController(viewportFraction: 1);

  // 标记用来获取空间大小
  GlobalKey _globalKey;

  // 当前页面
  int _index = 0;

  // 滑动进度
  double _alpha = 0;

  @override
  void initState() {
    super.initState();
    _globalKey = GlobalKey();
    _controller = PageController(viewportFraction: widget.viewport ?? 1);
    _controller.addListener(() {
      // 取得当前pageView的宽度
      double width = _globalKey?.currentContext?.size?.width ?? 0;
      // 计算pageView分页的宽度
      double pageWidth = width * (widget.viewport ?? 1);
      // 计算当前页面
      int index = (_controller.offset ~/ pageWidth);
      // 计算每一页的相对位置
      double offset = _controller.offset % pageWidth;
      // 监听滑动 0-1 之间的值
      double alpha = offset / pageWidth;

      print(index);
      setState(() {
        _index = index;
        _alpha = alpha;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      key: _globalKey,
      controller: _controller,
      itemCount: widget.dataList?.length ?? 0,
      onPageChanged: (q){

      },
      itemBuilder: (BuildContext context, int position) {
        return widget.itemBuilder(position,widget.dataList[position],_index == position
            ? 0 + ((widget.marginAll ?? 0) * _alpha)
            : (_index + 1 >= position
            ? (widget.marginAll ?? 0) -
            ((widget.marginAll ?? 0) * _alpha)
            : (widget.marginAll ?? 0)));
      },
    );
  }


}

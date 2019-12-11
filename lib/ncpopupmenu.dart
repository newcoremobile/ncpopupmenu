///
///Author: YoungChan
///Date: 2019-12-11 13:32:29
///LastEditors: YoungChan
///LastEditTime: 2019-12-11 14:54:01
///Description: Flutter 弹出菜单
///
library ncpopupmenu;

import 'package:flutter/material.dart';
import 'nc_popup_menu.dart';
export 'nc_popup_menu.dart';

///弹出菜单对话框
/// ctx: 注意context要传最顶层widget的context，通常取 State.build(BuildContext context)方法中的context 参数, 参考example
/// anchorViewKey: 要弹出菜单的锚点View 的key
/// menuItems: 菜单项
/// onMenuItemTap：菜单点击事件， 参数：NCMenuItem 设置的value
void ncShowPopupMenu(
  BuildContext ctx, {
  @required GlobalKey<State<StatefulWidget>> anchorViewKey,
  @required List<NCMenuItem> menuItems,
  void Function(dynamic) onMenuItemTap,
  double width = 130,
  double offsetX = 0,
  double offsetY = 0,
}) {
  assert(anchorViewKey != null && menuItems != null);
  showDialog(
      context: ctx,
      builder: (context) {
        RenderBox renderBox = anchorViewKey.currentContext.findRenderObject();
        //获取anchorView 左上角坐标
        var boxPoint = renderBox.localToGlobal(Offset.zero);
        var position = Offset(
            boxPoint.dx, boxPoint.dy - MediaQuery.of(ctx).padding.top + 20);

        return NCPopupMenu(
          anchorOffset: position,
          anchorSize: renderBox.size,
          menuItems: menuItems,
          width: width,
          offsetX: offsetX,
          offsetY: offsetY,
          onMenuItemTap: onMenuItemTap,
        );
      });
}

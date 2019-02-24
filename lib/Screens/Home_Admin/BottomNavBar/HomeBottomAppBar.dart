import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeBottomAppBarItem {
  HomeBottomAppBarItem({this.iconData, this.count});
  IconData iconData;
  int count;
}

class HomeBottomAppBar extends StatefulWidget {
  HomeBottomAppBar({
    this.host,
    this.list,
    this.items,
    this.height: 48.0,
    this.iconSize: 22.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.notchedShape,
    this.onTabSelected,
  })

  {
    assert(this.items.length == 3 || this.items.length == 4);
  }
  final String host;
  final List list;
  final List<HomeBottomAppBarItem> items;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;

  @override
  _HomeBottomAppBarState createState() => _HomeBottomAppBarState();
}

class _HomeBottomAppBarState extends State<HomeBottomAppBar> {
  int _selectedIndex = 0;

  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });

    return BottomAppBar(
      elevation: 0.0,
      shape: widget.notchedShape,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: items,
      ),
      color: widget.backgroundColor,
    );
  }

  Widget _buildTabItem({
    HomeBottomAppBarItem item,
    int index,
    ValueChanged<int> onPressed,
  }) {
    Color color = _selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BadgeIconButton(
                  itemCount: item.count,
                  badgeColor: Colors.blueAccent,
                  badgeTextColor: Colors.white,
                  icon: Icon(item.iconData, color: color, size: widget.iconSize),
                  hideZeroCount: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

class ListViewReordable extends StatefulWidget {
  const ListViewReordable({
    Key? key,
    required this.children,
    this.onReorder,
  }) : super(key: key);
  final List<Widget> children;
  final Function(int oldIndex, int newIndex)? onReorder;

  @override
  State<ListViewReordable> createState() => _ListViewReordableState();
}

class _ListViewReordableState extends State<ListViewReordable> {
  @override
  Widget build(BuildContext context) {
    void _onReorder(int oldIndex, int newIndex) {
      setState(() {
        if (widget.onReorder != null) {
          widget.onReorder!(oldIndex, newIndex);
        }
        final row = widget.children.removeAt(oldIndex);
        widget.children.insert(newIndex, row);
      });
    }

    // Make sure there is a scroll controller attached to the scroll view that contains ReorderableSliverList.
    // Otherwise an error will be thrown.
    final _scrollController =
        PrimaryScrollController.of(context) ?? ScrollController();

    return CustomScrollView(
      // A ScrollController must be included in CustomScrollView, otherwise
      // ReorderableSliverList wouldn't work
      controller: _scrollController,
      shrinkWrap: true,
      slivers: <Widget>[
        ReorderableSliverList(
          delegate: ReorderableSliverChildListDelegate(widget.children),
          // or use ReorderableSliverChildBuilderDelegate if needed
//          delegate: ReorderableSliverChildBuilderDelegate(
//            (BuildContext context, int index) => _rows[index],
//            childCount: _rows.length
//          ),
          onReorder: _onReorder,
        )
      ],
    );
  }
}

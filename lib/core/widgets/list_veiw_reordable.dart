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

    final _scrollController =
        PrimaryScrollController.of(context) ?? ScrollController();

    return CustomScrollView(
      // controller: _scrollController,
      shrinkWrap: true,
      slivers: <Widget>[
        ReorderableSliverList(
          controller: _scrollController,
          delegate: ReorderableSliverChildListDelegate(widget.children),
          onReorder: _onReorder,
        )
      ],
    );
  }
}

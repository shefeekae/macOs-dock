import 'package:flutter/material.dart';
import 'package:mac_dock/widgets/animated_icon.dart';
import 'package:reorderables/reorderables.dart';

class Dock extends StatefulWidget {
  /// Dock of the reorderable [items].

  const Dock({
    super.key,
  });

  @override
  State<Dock> createState() => _DockState();
}

class _DockState extends State<Dock> {
  List<IconData> items = [
    Icons.person,
    Icons.message,
    Icons.call,
    Icons.camera,
    Icons.photo,
  ];

  /// Updates the indices of the reordered items.
  void updateMytiles(int oldIndex, int newIndex) {
    setState(() {
      /// Gets the [tile] we are going to move.
      final tile = items.removeAt(oldIndex);

      /// Places the [tile] in a new position in the [items] array.
      items.insert(newIndex, tile);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// This the rectangular container in the background
    return AnimatedContainer(
      height: 100,
      width: 400,
      duration: const Duration(
        milliseconds: 300,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.black12,
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// This is the reorderable widget
          ReorderableWrap(
            buildDraggableFeedback: (context, constraints, child) {
              return Container(constraints: constraints, child: child);
            },
            padding: const EdgeInsets.all(8),
            direction: Axis.horizontal,
            runAlignment: WrapAlignment.center,
            needsLongPressDraggable: true,
            onReorder: (oldIndex, newIndex) {
              updateMytiles(oldIndex, newIndex);
            },
            children: List.generate(
              items.length,
              (index) => CustomAnimatedIcon(
                  translationY: 0, scaledSize: 40, icon: items[index]),
            ),
          ),
        ],
      ),
    );
  }
}

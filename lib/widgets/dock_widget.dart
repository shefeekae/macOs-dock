import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mac_dock/widgets/animated_icon.dart';
import 'package:reorderables/reorderables.dart';

/// Dock of the reorderable [items].
class Dock extends StatefulWidget {
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

  late int? hoveredIndex;
  late double baseItemHeight;
  late double baseTranslationY;
  late double verticlItemsPadding;

  ///Method to get the scaled size while hovering
  double getScaledSize(int index) {
    return getPropertyValue(
      index: index,
      baseValue: baseItemHeight,
      maxValue: 70,
      nonHoveredMaxValue: 50,
    );
  }

  ///Method to get the Y translation while hovering
  double getTranslationY(int index) {
    return getPropertyValue(
      index: index,
      baseValue: baseTranslationY,
      maxValue: -40,
      nonHoveredMaxValue: -14,
    );
  }

  /// Calculates a property value based on the index and hover state.
  double getPropertyValue({
    required int index,
    required double baseValue,
    required double maxValue,
    required double nonHoveredMaxValue,
  }) {
    late final double propertyValue;

    // If there is no hovered index, return the base value.
    if (hoveredIndex == null) {
      return baseValue;
    }

    // Calculate the absolute difference between the hovered index and the current index.
    final difference = (hoveredIndex! - index).abs();

    final itemsAffected = items.length;

    // If the hovered index matches the current index, return the max value.
    if (difference == 0) {
      propertyValue = maxValue;
    }

    // If the difference is within the range of affected items, interpolate the value.
    else if (difference <= itemsAffected) {
      final ratio = (itemsAffected - difference) / itemsAffected;

      // Use linear interpolation to determine the property value based on the ratio.
      propertyValue = lerpDouble(baseValue, nonHoveredMaxValue, ratio)!;
    }

    // If the index is too far from the hovered index, return the base value.
    else {
      propertyValue = baseValue;
    }

    return propertyValue;
  }

  //reorder method
  void updateMytiles(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex--;
      }

      //get the tile we are moving
      final tile = items.removeAt(oldIndex);

      //place the tile in the new position
      items.insert(newIndex, tile);

      // //Update the hovered Index
      // hoveredIndex = newIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    hoveredIndex = null;
    baseItemHeight = 40;

    verticlItemsPadding = 10;
    baseTranslationY = 0;
  }

  @override
  Widget build(BuildContext context) {
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
      child: SizedBox(
        // height: 100,
        // width: 400,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                    translationY: getTranslationY(index),
                    scaledSize: getScaledSize(index),
                    icon: items[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

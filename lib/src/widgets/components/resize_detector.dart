import 'dart:developer';

import 'package:flutter/widgets.dart';

/// A widget used to detect resizes.
class ResizeDetectorWidget extends StatefulWidget {
  final Function(Offset delta) onPanUpdate;
  final Function(Offset delta) onPanEnd;
  final Widget? child;

  const ResizeDetectorWidget({
    super.key,
    required this.onPanUpdate,
    required this.onPanEnd,
    this.child,
  });

  @override
  State<ResizeDetectorWidget> createState() => _ResizeDetectorWidgetState();
}

class _ResizeDetectorWidgetState extends State<ResizeDetectorWidget> {
  Offset _start = Offset.zero;
  Offset _delta = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanStart: (details) {
        _start = details.globalPosition;
      },
      onPanUpdate: (details) {
        final current = details.globalPosition;
        _delta = current - _start;
        widget.onPanUpdate.call(_delta);
      },
      onPanEnd: (details) {
        widget.onPanEnd.call(_delta);
        _delta = Offset.zero;
      },
      child: widget.child,
    );
  }
}

/// A widget used to detect resizes for multi-day events.
class MultiDayResizeDetectorWidget extends StatelessWidget {
  final Function(Offset delta) onPanUpdate;
  final Function(Offset delta) onPanEnd;
  final Widget? child;

  const MultiDayResizeDetectorWidget({
    super.key,
    required this.onPanUpdate,
    required this.onPanEnd,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanStart: (details) {
        onPanUpdate.call(details.globalPosition);
      },
      onPanUpdate: (details) {
        onPanUpdate.call(details.globalPosition);
      },
      onPanEnd: (details) {
        onPanEnd.call(details.globalPosition);
      },
      child: child,
    );
  }
}

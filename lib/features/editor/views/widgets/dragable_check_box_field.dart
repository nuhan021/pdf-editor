import 'package:flutter/material.dart';

class DraggableCheckboxField extends StatelessWidget {
  final int index;
  final Map<String, dynamic> field;
  final Function(int, double, double) onDrag;
  final VoidCallback onDelete;
  final Function(int, bool) onToggle;

  const DraggableCheckboxField({
    super.key,
    required this.index,
    required this.field,
    required this.onDrag,
    required this.onDelete,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: field['x'],
      top: field['y'],
      child: GestureDetector(
        onPanUpdate: (details) => onDrag(index, details.delta.dx, details.delta.dy),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            InkWell(
              onTap: () => onToggle(index, !(field['isChecked'] ?? false)),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: field['isChecked'] == true
                    ? const Icon(Icons.check, size: 24, color: Colors.blue)
                    : null,
              ),
            ),
            // Delete Button
            Positioned(
              right: -10,
              top: -10,
              child: GestureDetector(
                onTap: onDelete,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  child: const Icon(Icons.close, color: Colors.white, size: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
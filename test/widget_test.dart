import 'package:flutter_test/flutter_test.dart';
import 'package:pdf_editor/features/editor/controller/editor_controller.dart';

void main() {
  group('EditorController Tests', () {
    late EditorController controller;

    setUp(() {
      controller = EditorController();
    });

    test('Initial fields should be empty', () {
      expect(controller.textDraggableFields.length, 0);
    });

    test('Adding a text box should increase fields list', () {
      controller.addTextBox();
      expect(controller.textDraggableFields.length, 1);
      expect(controller.textDraggableFields[0]['type'], 'text');
    });

    test('Coordinate clamping should work', () {
      controller.pdfPageHeight.value = 1000.0;
      controller.addTextBox();

      controller.updateFieldPosition(0, -100, -100);

      expect(controller.textDraggableFields[0]['x'], 0.0);
      expect(controller.textDraggableFields[0]['y'], 0.0);
    });
  });
}
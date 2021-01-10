import 'dart:ui' as ui;
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';

enum Detector {
  text,
}

// Paints rectangles around all the text in the image.
class TextDetectorPainter extends CustomPainter {
  final Size absoluteImageSize;
  final VisionText visionText;
  TextDetectorPainter(this.absoluteImageSize, this.visionText);

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / absoluteImageSize.width;
    final double scaleY = size.height / absoluteImageSize.height;

    Rect scaleRect(TextContainer container) {
      return Rect.fromLTRB(
        container.boundingBox.left * scaleX,
        container.boundingBox.top * scaleY,
        container.boundingBox.right * scaleX,
        container.boundingBox.bottom * scaleY,
      );
    }

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement element in line.elements) {
          paint.color = Colors.green;
          canvas.drawRect(scaleRect(element), paint);
        }

        paint.color = Colors.yellow;
        canvas.drawRect(scaleRect(line), paint);
      }

      paint.color = Colors.red;
      canvas.drawRect(scaleRect(block), paint);
    }
  }

  @override
  bool shouldRepaint(TextDetectorPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.visionText != visionText;
  }
}

// Paints rectangles around all the text in the document image.
class DocumentTextDetectorPainter extends CustomPainter {
  DocumentTextDetectorPainter(this.absoluteImageSize, this.visionDocumentText);

  final Size absoluteImageSize;
  final VisionDocumentText visionDocumentText;

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / absoluteImageSize.width;
    final double scaleY = size.height / absoluteImageSize.height;

    Rect scaleRect(DocumentTextContainer container) {
      return Rect.fromLTRB(
        container.boundingBox.left * scaleX,
        container.boundingBox.top * scaleY,
        container.boundingBox.right * scaleX,
        container.boundingBox.bottom * scaleY,
      );
    }

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    for (DocumentTextBlock block in visionDocumentText.blocks) {
      for (DocumentTextParagraph paragraph in block.paragraphs) {
        for (DocumentTextWord word in paragraph.words) {
          for (DocumentTextSymbol symbol in word.symbols) {
            paint.color = Colors.green;
            canvas.drawRect(scaleRect(symbol), paint);
          }
          paint.color = Colors.yellow;
          canvas.drawRect(scaleRect(word), paint);
        }
        paint.color = Colors.red;
        canvas.drawRect(scaleRect(paragraph), paint);
      }
      paint.color = Colors.blue;
      canvas.drawRect(scaleRect(block), paint);
    }
  }

  @override
  bool shouldRepaint(DocumentTextDetectorPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.visionDocumentText != visionDocumentText;
  }
}

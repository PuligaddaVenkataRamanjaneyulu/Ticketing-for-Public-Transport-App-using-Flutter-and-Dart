import 'package:flutter/material.dart';

/// A deterministic, QR-like visual generator.
/// NOT a real QR code — for UI/demo only.
class FakeQrWidget extends StatelessWidget {
  final String data;
  final double size;
  final Color darkColor;
  final Color lightColor;
  final double padding; // inside padding around the matrix

  const FakeQrWidget({
    Key? key,
    required this.data,
    this.size = 200,
    this.darkColor = Colors.black,
    this.lightColor = Colors.white,
    this.padding = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _FakeQrPainter(data, darkColor, lightColor, padding),
    );
  }
}

class _FakeQrPainter extends CustomPainter {
  final String data;
  final Color darkColor;
  final Color lightColor;
  final double padding;
  final int matrixSize;

  // Fixed constructor: optional parameter handled correctly
  _FakeQrPainter(
    this.data,
    this.darkColor,
    this.lightColor,
    this.padding, {
    int? matrixSize,
  }) : matrixSize = matrixSize ?? 25; // default value if none provided

  @override
  void paint(Canvas canvas, Size size) {
    final paintDark = Paint()..color = darkColor;
    final paintLight = Paint()..color = lightColor;

    // Fill background
    canvas.drawRect(Offset.zero & size, paintLight);

    // Compute matrix area
    final double available = size.width - padding * 2;
    final double cellSize = available / matrixSize;

    // Generate deterministic bits from data
    final bits = _generateMatrix(matrixSize, data);

    // Add finder-style blocks
    _addFinderPatterns(bits);

    // Draw cells
    for (int r = 0; r < matrixSize; r++) {
      for (int c = 0; c < matrixSize; c++) {
        final bool black = bits[r][c];
        final rect = Rect.fromLTWH(
          padding + c * cellSize,
          padding + r * cellSize,
          cellSize,
          cellSize,
        );
        canvas.drawRect(rect, black ? paintDark : paintLight);
      }
    }

    // Optional border
    final borderPaint = Paint()
      ..color = darkColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), borderPaint);
  }

  /// Deterministic matrix generator
  List<List<bool>> _generateMatrix(int n, String seedString) {
    final List<List<bool>> m = List.generate(n, (_) => List.generate(n, (_) => false));
    int seed = 0x811C9DC5;
    for (final code in seedString.runes) {
      seed = (seed ^ code) & 0xFFFFFFFF;
      seed = (seed * 0x01000193) & 0xFFFFFFFF;
    }

    int state = seed;
    for (int r = 0; r < n; r++) {
      for (int c = 0; c < n; c++) {
        state = (state * 1664525 + 1013904223) & 0xFFFFFFFF;
        final bit = (state & 1) == 1;
        m[r][c] = bit;
      }
    }

    final quiet = 1;
    for (int i = 0; i < n; i++) {
      for (int q = 0; q < quiet; q++) {
        m[q][i] = false;
        m[n - 1 - q][i] = false;
        m[i][q] = false;
        m[i][n - 1 - q] = false;
      }
    }
    return m;
  }

  /// Add finder-like squares
  void _addFinderPatterns(List<List<bool>> bits) {
    final n = bits.length;
    void drawFinder(int sr, int sc) {
      for (int r = 0; r < 7; r++) {
        for (int c = 0; c < 7; c++) {
          final rr = sr + r;
          final cc = sc + c;
          if (rr < 0 || rr >= n || cc < 0 || cc >= n) continue;
          if ((r == 0 || r == 6) || (c == 0 || c == 6)) {
            bits[rr][cc] = true;
          } else if ((r == 1 || r == 5) || (c == 1 || c == 5)) {
            bits[rr][cc] = false;
          } else {
            bits[rr][cc] = true;
          }
        }
      }
    }

    drawFinder(0, 0); // top-left
    drawFinder(0, n - 7); // top-right
    drawFinder(n - 7, 0); // bottom-left
  }

  @override
  bool shouldRepaint(covariant _FakeQrPainter oldDelegate) {
    return oldDelegate.data != data ||
        oldDelegate.darkColor != darkColor ||
        oldDelegate.lightColor != lightColor ||
        oldDelegate.padding != padding ||
        oldDelegate.matrixSize != matrixSize;
  }
}

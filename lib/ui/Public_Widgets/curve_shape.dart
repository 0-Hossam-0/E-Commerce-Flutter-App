import 'package:flutter/material.dart';

class CustomCircularNotchedRectangle extends NotchedShape {
  @override
  Path getOuterPath(Rect host, Rect? guest) {
    if (guest == null || !guest.overlaps(host)) {
      return Path()..addRect(host);
    }

    final Path path = Path()..moveTo(host.left, host.top);

    final double notchRadius = guest.width / 2.0;
    final double notchCenter = guest.center.dx;

    path.lineTo(notchCenter - notchRadius - 10, host.top);

    path.arcToPoint(
      Offset(notchCenter + notchRadius + 10, host.top),
      radius: Radius.circular(notchRadius + 10),
      clockwise: false,
    );

    path.lineTo(host.right, host.top);
    path.lineTo(host.right, host.bottom);
    path.lineTo(host.left, host.bottom);
    path.close();

    return path;
  }
}

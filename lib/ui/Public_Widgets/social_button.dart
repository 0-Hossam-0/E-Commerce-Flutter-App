import 'package:flutter/material.dart';

class SocialButton extends StatefulWidget {
  final String imagePath;
  final Color hoverColor;
  final Function() onTapFunction;
  const SocialButton(
      {super.key, required this.imagePath, required this.hoverColor, required this.onTapFunction});

  @override
  _SocialButtonState createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) => setState(() => isPressed = false),
      onTapCancel: () => setState(() => isPressed = false),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFEEEBEB),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: IconButton(
          onPressed: widget.onTapFunction,
          icon: Image.asset(
            widget.imagePath,
            width: 30,
            height: 30,
            color: isPressed ? widget.hoverColor : Colors.grey,
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      ),
    );
  }
}

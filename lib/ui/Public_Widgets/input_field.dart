import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/data/Search/logic/search_cubit.dart';
import 'package:sizer/sizer.dart';

class InputField extends StatefulWidget {
  final String placeholder;
  final Icon prefixIcon;
  final bool isSecured;
  final bool isOnChange;
  final double width;
  final Color borderColor;
  final bool isDisabled;
  final Function()? onTapFunction;
  final TextEditingController controller;

  const InputField({
    super.key,
    required this.placeholder,
    required this.prefixIcon,
    required this.isSecured,
    required this.controller,
    this.borderColor = Colors.blue,
    this.onTapFunction,
    this.isDisabled = false,
    this.width = 90,
    this.isOnChange = false,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final FocusNode _focusNode = FocusNode();
  Color hoverColor = const Color(0xFF828282);
  late Color currentBorderColor;

  @override
  void initState() {
    super.initState();
    currentBorderColor = widget.borderColor;

    // _focusNode.addListener(() {
    //   setState(() {
    //     hoverColor =
    //         _focusNode.hasFocus ? Colors.black : const Color(0xFF828282);
    //   });
    // });

    // if (!widget.isDisabled) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     FocusScope.of(context).requestFocus(_focusNode);
    //     SystemChannels.textInput.invokeMethod('TextInput.show');
    //   });
    // }
  }

  void _searchProducts(value) {
    if (widget.isOnChange) {
      context.read<SearchCubit>().fetchSearch(value);
    }
  }

  @override
  void didUpdateWidget(covariant InputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.borderColor != widget.borderColor) {
      setState(() {
        currentBorderColor = widget.borderColor;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final adjustedWidth = widget.width.w;

    return TextField(
      onChanged: _searchProducts,
      readOnly: widget.isDisabled,
      // autofocus: !widget.isDisabled,
      controller: widget.controller,
      obscureText: widget.isSecured,
      onTap: widget.onTapFunction,
      style: TextStyle(color: hoverColor, fontWeight: FontWeight.w400),
      focusNode: _focusNode,
      decoration: InputDecoration(
        constraints: BoxConstraints(maxWidth: adjustedWidth, maxHeight: 40),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: currentBorderColor),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: currentBorderColor),
        ),
        hintText: widget.placeholder,
        fillColor: const Color(0xFFeeebeb),
        filled: true,
        hintStyle: TextStyle(color: hoverColor),
        prefixIcon: widget.prefixIcon,
        prefixIconColor: hoverColor,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1.5, color: Color(0xFF7888F2)),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 70),
        contentPadding: const EdgeInsets.symmetric(vertical: 1),
      ),
      textAlignVertical: TextAlignVertical.center,
    );
  }
}

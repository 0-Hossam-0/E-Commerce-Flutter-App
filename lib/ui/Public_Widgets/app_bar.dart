import 'package:e_commerce/data/Search/logic/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final bool isDisabled;
  final bool isOnChange;
  final TextEditingController controller;
  final Function()? onTapFunction;
  const AppBarWidget(
      {super.key,
      this.isDisabled = false,
      this.onTapFunction,
      required this.controller,
      this.isOnChange = false});

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  Color borderColor = Colors.blue;
  final FocusNode _focusNode = FocusNode();
  late Color currentBorderColor;
  Color hoverColor = const Color(0xFF828282);
  @override
  void initState() {
    super.initState();
    currentBorderColor = borderColor;

    _focusNode.addListener(() {
      setState(() {
        hoverColor =
            _focusNode.hasFocus ? Colors.black : const Color(0xFF828282);
      });
    });

    if (!widget.isDisabled) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(_focusNode);
        SystemChannels.textInput.invokeMethod('TextInput.show');
      });
    }
  }

  void _searchProducts(value) {
    if (widget.isOnChange) {
      context.read<SearchCubit>().fetchSearch(value);
    }
  }

  Widget build(BuildContext context) {
    return AppBar(
      title: TextField(
        onChanged: _searchProducts,
        readOnly: widget.isDisabled,
        autofocus: !widget.isDisabled,
        onTap: widget.onTapFunction,
        controller: widget.controller,
        style: TextStyle(color: hoverColor, fontWeight: FontWeight.w400),
        focusNode: _focusNode,
        decoration: InputDecoration(
          constraints: BoxConstraints(maxWidth: 100.w, maxHeight: 40),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: currentBorderColor),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: currentBorderColor),
          ),
          hintText: 'Search... ',
          fillColor: const Color(0xFFeeebeb),
          filled: true,
          hintStyle: TextStyle(color: hoverColor),
          prefixIcon: const Icon(Icons.search),
          prefixIconColor: const Color(0xFF828282),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1.5, color: Color(0xFF7888F2)),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 70),
          contentPadding: const EdgeInsets.symmetric(vertical: 1),
        ),
        textAlignVertical: TextAlignVertical.center,
      ),
      backgroundColor: Colors.transparent,
      actions: [
        Container(
          margin: const EdgeInsets.only(top: 3),
        ),
      ],
    );
  }
}




// InputField(
//             placeholder: 'Search...',
//             prefixIcon: const Icon(Icons.search),
//             isSecured: false,
//             width: 100,
//             height: 5,
//             controller: _searchController,
//           ),


//  return AppBar(
//       title: GestureDetector(
//         onTap: () {},
//         child: Container(
//           width: 100.w,
//           decoration: BoxDecoration(
//               color: Color(0xFFeeebeb),
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: Colors.blue)),
//           height: 40,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 SizedBox(width: 13),
//                 Icon(
//                   Icons.search,
//                   color: Color(0xFF828282),
//                 ),
//                 SizedBox(width: 25),
//                 Text(
//                   'Search...',
//                   style: TextStyle(
//                     color: Color(0xFF828282),
//                     fontSize: 17,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       backgroundColor: Colors.transparent,
//       actions: [
//         Container(
//           margin: const EdgeInsets.only(top: 3),
//         ),
//       ],
//     );
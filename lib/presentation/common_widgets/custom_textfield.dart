// import 'package:flutter/material.dart';

// class CustomTextField extends StatelessWidget {
//   final String hintText;
//   final String? labelText;
//   final Color? borderColor;
//   final int? maxLines;
//   final bool readOnly;
//   final TextEditingController? controller;
//   final Function(String)? onSubmitted;
//   final Function(String)? onChanged;
//   final void Function()? onTap;
//   const CustomTextField({
//     Key? key,
//     required this.hintText,
//     this.controller,
//     this.onSubmitted,
//     this.onChanged,
//     this.labelText,
//     this.borderColor,
//     this.maxLines,
//     this.onTap,
//     this.readOnly = false,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: maxLines == null ? 40 : null,
//       child: TextField(
//         readOnly: readOnly,
//         onTap: onTap,
//         controller: controller,
//         maxLines: maxLines ?? 1,
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: Colors.white,
//           // labelText: labelText,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(4),
//             borderSide: BorderSide(
//               width: 0,
//               color: borderColor ?? Color(0xFF000000),
//               style: borderColor == null ? BorderStyle.none : BorderStyle.solid,
//             ),
//           ),
//           hintText: hintText,
//           hintStyle: TextStyle(
//             color: Color(0xff919191),
//             fontSize: 12,
//           ),
//         ),
//         onSubmitted: onSubmitted,
//         onChanged: onChanged,
//         // onEditingComplete: ,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final Color? borderColor;
  final int? maxLines;
  final bool readOnly;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final void Function()? onTap;
  final bool isObsecure;
  const CustomTextField({
    Key? key,
    this.isObsecure = false,
    this.hintText,
    this.controller,
    this.onSubmitted,
    this.onChanged,
    this.labelText,
    this.borderColor,
    this.maxLines,
    this.onTap,
    this.prefixIcon,
    this.readOnly = false,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;
  @override
  void initState() {
    super.initState();
    _obscureText = widget.isObsecure;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.maxLines == null ? 45 : null,
      child: TextField(
        readOnly: widget.readOnly,
        onTap: widget.onTap,
        controller: widget.controller,
        maxLines: widget.maxLines ?? 1,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon:widget.prefixIcon ?? 
                  widget.prefixIcon,
                 

          // labelText: labelText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                  width: 1, color: widget.borderColor ?? Colors.grey[400]!)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                  width: 1, color: widget.borderColor ?? Colors.grey[400]!)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                  width: 1, color: widget.borderColor ?? Colors.grey[400]!)),
          hintText: widget.hintText,
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: Colors.grey[800],
            fontSize: 13,
          ),
          hintStyle: TextStyle(
            color: Colors.grey[800],
            fontSize: 13,
          ),

          suffixIcon: widget.isObsecure
              ? IconButton(
                  icon: !_obscureText
                      ? Icon(
                          Icons.visibility,
                          size: 18,
                        )
                      : Icon(Icons.visibility_off, size: 18),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
        ),
        onSubmitted: widget.onSubmitted,
        onChanged: widget.onChanged,
        // onEditingComplete: ,
        obscureText: _obscureText,
      ),
    );
  }
}

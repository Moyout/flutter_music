import 'package:flutter_music/util/tools.dart';

class TextFiledWidget extends StatelessWidget {
  final TextEditingController textC;
  final bool isHide;
  final bool showCursor;
  final int? maxLength;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final String? helperText;
  final List<TextInputFormatter>? inputFormatter;
  final TextAlign textAlign;
  final Function? onSubmitted;
  final Function? onChanged;
  final Function? onTap;

  TextFiledWidget(
    this.textC, {
    this.maxLength = 11,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.helperText,
    this.isHide = false,
    this.showCursor = true,
    this.inputFormatter,
    this.textAlign = TextAlign.start,
    this.onSubmitted,
    this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 5.w),
      child: TextField(
        textAlign: textAlign,
        controller: textC,
        obscureText: isHide,
        showCursor: showCursor,
        maxLength: maxLength,
        inputFormatters: inputFormatter,
        style: TextStyle(letterSpacing: 2),
        onTap: () {
          if (onTap != null) onTap!();
        },
        onSubmitted: (v) {
          if (onSubmitted != null) onSubmitted!();
        },
        onChanged: (v) {
          if (onChanged != null) onChanged!();
        },
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon == null ? null : Icon(prefixIcon),
          counter: Text(""),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          helperText: helperText,
          helperStyle: Theme.of(context).brightness == Brightness.light
              ? TextStyle(color: Colors.blue)
              : TextStyle(color: Colors.white),
          // fillColor: Theme.of(context).dividerColor,
          filled: true,
          contentPadding:
              EdgeInsets.all(0).add(EdgeInsets.symmetric(horizontal: 15.w)),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(100.w)),
        ),
      ),
    );
  }
}

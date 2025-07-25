part of 'widget.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.obscureText = false,
    this.textInputType,
    this.validator,
    this.maxLine,
    this.onTap,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final bool obscureText;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final int? maxLine;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      maxLines: maxLine ?? 1,
      decoration: InputDecoration(labelText: label, hintText: hint),
      style: Theme.of(context).textTheme.bodySmall,
      keyboardType: textInputType ?? TextInputType.none,
      cursorColor: Theme.of(context).primaryColor,
      validator: validator,
      onTap: onTap,
      readOnly: onTap != null ? true : false,
    );
  }
}

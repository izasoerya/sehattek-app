import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TextInput extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String label;
  final bool optional;
  final TextInputType type;
  final String? Function(String?)? validator;

  const TextInput({
    super.key,
    required this.controller,
    this.hintText = '',
    this.label = '',
    this.optional = false,
    this.type = TextInputType.text,
    this.validator,
  });

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  final _formKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        key: _formKey,
        keyboardType: widget.type,
        controller: widget.controller,
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          focusColor: Colors.red,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 1.sw,
            vertical: 0.5.sh,
          ),
          hintText: widget.hintText,
          hintStyle: Theme.of(context).textTheme.bodyMedium,
          labelText: null,
          label: RichText(
            text: TextSpan(
              text: widget.label,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontWeight: FontWeight.w600),
              children: [
                if (!widget.optional)
                  TextSpan(
                    text: ' (*)',
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
          labelStyle: Theme.of(context).textTheme.bodySmall,
          filled: true,
          fillColor: Theme.of(context).colorScheme.secondary,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.5),
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.3), // Grey with 7.50% opacity
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.5),
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.3), // Grey with 7.50% opacity
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.5),
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.3), // Grey with 7.50% opacity
            ),
          ),
        ),
        validator: widget.validator,
        onChanged: (value) {
          _formKey.currentState?.validate();
        },
        maxLines: null,
        minLines: 1,
      ),
    );
  }
}

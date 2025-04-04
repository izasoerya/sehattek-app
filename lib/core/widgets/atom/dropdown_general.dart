import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DropdownGeneral extends StatefulWidget {
  final List<String> providerOptions;
  final void Function(String) selectedProvider;

  const DropdownGeneral({
    super.key,
    required this.providerOptions,
    required this.selectedProvider,
  });

  @override
  State<DropdownGeneral> createState() => _DropdownGeneralState();
}

class _DropdownGeneralState extends State<DropdownGeneral> {
  String? selectedProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Provider Handler',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 10.sp,
              ),
        ),
        const SizedBox(height: 5),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade200,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: DropdownButton(
              underline: SizedBox(),
              icon: const SizedBox(),
              isDense: true,
              borderRadius: BorderRadius.circular(10),
              hint: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    selectedProvider ?? 'Select Provider',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 10.5.sp,
                        ),
                  ),
                ],
              ),
              items: widget.providerOptions.map((provider) {
                print('Provider: $provider');
                return DropdownMenuItem<String>(
                  value: provider,
                  child: Text(
                    provider,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 10.5.sp,
                        ),
                  ),
                );
              }).toList(),
              onChanged: (name) {
                if (name != null) {
                  setState(() {
                    selectedProvider = name;
                    widget.selectedProvider(name);
                  });
                }
              }),
        ),
      ],
    );
  }
}

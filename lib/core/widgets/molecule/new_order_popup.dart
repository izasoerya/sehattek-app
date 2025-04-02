import 'package:flutter/material.dart';
import 'package:sehattek_app/core/utils/textfield_validator.dart';
import 'package:sehattek_app/core/widgets/atom/button_general.dart';
import 'package:sehattek_app/core/widgets/atom/button_oauth.dart';
import 'package:sehattek_app/core/widgets/atom/date_picker_general.dart';
import 'package:sehattek_app/core/widgets/atom/dropdown_general.dart';
import 'package:sehattek_app/core/widgets/atom/text_input.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_provider.dart';
import 'package:sizer/sizer.dart';

class NewOrderPopup extends StatefulWidget {
  final List<EntitiesProvider> listProvider;

  const NewOrderPopup({super.key, this.listProvider = const []});

  @override
  State<NewOrderPopup> createState() => _NewOrderPopupState();
}

class _NewOrderPopupState extends State<NewOrderPopup> {
  final TextEditingController _orderNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();

  @override
  void dispose() {
    _orderNameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _customerNameController.dispose();
    _deadlineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: 30.w,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              alignment: Alignment.centerLeft,
              child: Text(
                'Create Order',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextInput(
                    controller: _orderNameController,
                    label: 'Nama Layanan',
                    hintText: 'Masukkan nama layanan',
                    type: TextInputType.text,
                    validator: TextfieldValidator.validateName,
                  ),
                  SizedBox(height: 10),
                  TextInput(
                    controller: _descriptionController,
                    label: 'Deskripsi Layanan',
                    hintText: 'Masukkan deskripsi layanan',
                    type: TextInputType.text,
                    validator: TextfieldValidator.validateName,
                  ),
                  SizedBox(height: 15),
                  TextInput(
                    controller: _priceController,
                    label: 'Harga Layanan',
                    hintText: 'Masukkan harga layanan',
                    type: TextInputType.number,
                    validator: TextfieldValidator.validateName,
                  ),
                  SizedBox(height: 10),
                  TextInput(
                    controller: _customerNameController,
                    label: 'Nama Customer',
                    hintText: 'Masukkan nama customer',
                    type: TextInputType.text,
                    validator: TextfieldValidator.validateName,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            DatePickerGeneral(
              onDateSelected: (p0) {
                print('Selected date: $p0');
                setState(() {
                  _deadlineController.text = p0.toString();
                });
              },
            ),
            SizedBox(height: 5),
            DropdownGeneral(
                providerOptions: widget.listProvider
                    .map((provider) =>
                        '${provider.name.toString()} (${provider.email.toString()})')
                    .toList()),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonOauth(
                    label: ('Cancel'), onPressed: () => Navigator.pop(context)),
                SizedBox(width: 10),
                ButtonGeneral(
                  label: Text('Submit'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

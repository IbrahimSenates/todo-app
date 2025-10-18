import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputWidget extends StatefulWidget {
  const InputWidget({
    super.key,
    required this.text,
    required this.controllerInput,
    required this.picker,
  });
  final String text;
  final TextEditingController controllerInput;
  final String picker;

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

DateTime nowDate = DateTime.now();
DateTime firstDate = DateTime(nowDate.year, nowDate.month - 2);
DateTime lastDate = DateTime(nowDate.year, nowDate.month + 2);
TimeOfDay nowTime = TimeOfDay.now();

class _InputWidgetState extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(widget.text),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              readOnly: true,
              onTap: () async {
                if (widget.picker == 'Tarih') {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    firstDate: firstDate,
                    lastDate: lastDate,
                    initialDate: nowDate,
                  );
                  if (picked != null) {
                    String formattedDate = DateFormat(
                      'dd.MM.yyyy',
                    ).format(picked);
                    setState(() {
                      widget.controllerInput.text = formattedDate;
                    });
                  } else {
                    null;
                  }
                } else if (widget.picker == 'Saat') {
                  showTimePicker(context: context, initialTime: nowTime).then((
                    value,
                  ) {
                    if (value != null) {
                      final hour = value.hour.toString().padLeft(2, '0');
                      final minute = value.minute.toString().padLeft(2, '0');
                      widget.controllerInput.text = '$hour:$minute';
                    }
                  });
                }
              },
              controller: widget.controllerInput,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

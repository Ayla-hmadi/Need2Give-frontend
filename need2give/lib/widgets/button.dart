import 'package:flutter/services.dart';
import 'package:need2give/constants/global.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const Button({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Global.green,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}

class RedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const RedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Global.markerColor,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}

class TransparentButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const TransparentButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Global.backgroundColor,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Global.green)),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, color: Global.green),
      ),
    );
  }
}

class NumberInput extends StatelessWidget {
  final String text;
  const NumberInput({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
      ],
      decoration: InputDecoration(
        labelText: text,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return text;
        }
        final number = double.tryParse(value);
        if (number == null || number <= 0) {
          return 'Please enter a positive number';
        }
        return null;
      },
    );
  }
}

class CustomCheckbox extends StatefulWidget {
  final String label;
  const CustomCheckbox({
    super.key,
    required this.label,
  });

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool _checked = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.label,
          style: const TextStyle(fontSize: 14),
        ),
        Checkbox(
          activeColor: Global.darkGreen,
          checkColor: Global.white,
          value: _checked,
          onChanged: (bool? val) {
            setState(() {
              _checked = !_checked;
            });
          },
        ),
      ],
    );
  }
}

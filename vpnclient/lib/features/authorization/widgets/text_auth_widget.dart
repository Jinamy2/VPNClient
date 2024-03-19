import 'package:flutter/material.dart';
import 'package:vpnclient/common/utils/extensions_app.dart';

class TextAuth extends StatelessWidget {
  const TextAuth({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          text,
          style: context.textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
      );
}

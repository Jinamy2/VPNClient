import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BackButtonApp extends StatelessWidget {
  const BackButtonApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Row(
        children: [
          const SizedBox(
            width: 5,
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/arrow.svg',
                width: 8,
              ),
              onPressed: Navigator.of(context).pop,
            ),
          ),
        ],
      );
}

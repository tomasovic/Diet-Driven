/*
 * Copyright (c) 2019. Dennis Krasnov. All rights reserved.
 * Use of this source code is governed by the MIT license that can be found in the LICENSE file.
 */

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCircle extends StatelessWidget {
  final double radius;

  const ShimmerCircle({Key key, this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: Container(
        width: radius,
        height: radius,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
      baseColor: Colors.grey[200],
      highlightColor: Colors.grey[100],
    );
  }
}

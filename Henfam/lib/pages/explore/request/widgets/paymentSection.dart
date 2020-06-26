import 'package:Henfam/pages/explore/request/widgets/miniHeader.dart';
import 'package:Henfam/widgets/mediumTextSection.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class PaymentSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MediumTextSection('Payment'),
        MiniHeader('Payment Method'),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../../utilis/dimensions.dart';
import '../../base_widget/title_row.dart';

class ProductSpesication extends StatelessWidget {
  final String productSpesication;
  const ProductSpesication({
    Key? key,
    required this.productSpesication,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleRow(
          title: 'Spesification',
          isDetailsPage: true,
          ),
          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
          productSpesication.isNotEmpty
            ? Expanded(child: Text(productSpesication))
            : const Center(child: Text('No specification')),
          const SizedBox(height: Dimensions.paddingSizeDefault),
      ],
    );
  }
}

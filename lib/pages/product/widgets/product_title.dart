// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../utilis/color_resource.dart';
import '../../../utilis/custom_theme.dart';
import '../../../utilis/dimensions.dart';
import '../../../utilis/price_ext.dart';
import '../../Data/Models/Product_model_respon.dart';

class ProductTitleView extends StatelessWidget {
  final Product product;
  const ProductTitleView({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Row(
          children: [
            Expanded(
              child: Text(product.name!,
              style: titleRegular.copyWith(
                fontSize: Dimensions.fontSizeLarge
              ),
              maxLines: 2,
              )),
            const SizedBox(width: Dimensions.paddingSizeExtraSmall),
            Column(
              children: [
                Text(
                  '${product.price!}'.formatPrice(),
                  style: titilliumBold.copyWith(
                    color: ColorResources.getPrimary(context),
                    fontSize: Dimensions.fontSizeLarge,
                  ),
                ),
              ],
            ),
            ]),
          ],
      ),
    );
  }
}

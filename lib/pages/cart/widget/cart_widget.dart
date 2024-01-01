// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/checkout/checkout_bloc.dart';
import '../../../utilis/color_resource.dart';
import '../../../utilis/custom_theme.dart';
import '../../../utilis/dimensions.dart';
import '../../../utilis/images.dart';
import '../../../utilis/price_ext.dart';
// import '../../product/product_detail.dart';

class CartWidget extends StatelessWidget {
  final ProductQuatity productQuatity;
  const CartWidget({
    Key? key,
    required this.productQuatity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<CheckoutBloc>().add(CheckoutEvent.removeCart(productQuatity.product, productQuatity.quatity));
      },
      child: Container(
        margin: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        decoration: BoxDecoration(
          color: Theme.of(context).highlightColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.20),width: 1)
              ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
              child: FadeInImage.assetNetwork(
                placeholder: Images.placeholder,
                height: 60,
                width: 60,
                image: productQuatity.product.imageProduct!,
                imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                  Images.placeholder,
                  fit: BoxFit.cover,
                  height: 60,
                  width: 60,
                ),
                ),
            ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeExtraSmall
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(productQuatity.product.name!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: titilliumBold.copyWith(
                            fontSize: Dimensions.fontSizeDefault,
                            color: ColorResources.getReviewRattingColor(context),
                          )),
                          ),
                          const SizedBox(
                            width: Dimensions.paddingSizeSmall,
                          ),
                          InkWell(
                            onTap: () {
                              
                            },
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: Image.asset(
                                Images.delete,
                                scale: .5,
                              )
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeSmall,
                    ),
                    Row(
                      children: [
                        Text('${productQuatity.product.price}'.formatPrice(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: titilliumRegular.copyWith(
                          color: ColorResources.getPrimary(context),
                          fontSize: Dimensions.fontSizeExtraLarge
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text('x ${productQuatity.quatity}'),
                      ],
                    )
                  ],
                ),))
          ],
        ),
      ),
    );
  }
}

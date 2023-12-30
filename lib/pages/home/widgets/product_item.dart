// import 'package:flutter/foundation.dart';
import 'package:app_fic/pages/product/product_detail.dart';
import 'package:app_fic/utilis/images.dart';
import 'package:app_fic/utilis/price_ext.dart';
import 'package:flutter/material.dart';

import '../../../utilis/color_resource.dart';
import '../../../utilis/custom_theme.dart';
import '../../../utilis/dimensions.dart';
import '../../Data/Models/Product_model_respon.dart';
import '../../base_widget/rating_bar.dart';

class ProductItemWidget extends StatelessWidget {
  final Product product;
  const ProductItemWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetail(product: product);
        }));
      },
      child: Container(
        height: Dimensions.cardHeight,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).highlightColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5)
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, 
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: ColorResources.getIconBg(context),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)
                    ),
                    child: FadeInImage.assetNetwork(
                      placeholder: Images.placeholder,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.width / 2.45, 
                      image: product.imageProduct!,
                      imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                        Images.placeholder,
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.width / 2.45,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: Dimensions.paddingSizeSmall,
                    bottom: 5,
                    left: 5,
                    right: 5
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(product.name ?? '-',
                        textAlign: TextAlign.center,
                        style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          fontWeight: FontWeight.w400
                          ),
                        maxLines: 2,
                        overflow: TextOverflow.clip
                        ),
                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                      Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                        RatingBar(
                          rating: double.parse('10.0'),
                          size: 18,
                          ),
                          Text('(20)',
                          style: robotoRegular.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                          )),
                      ]),
                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                      const SizedBox.shrink(),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        '${product.price}'.formatPrice(),
                        style: titilliumBold.copyWith(
                          color: ColorResources.getPrimary(context)
                        ),
                      )
                      ],
                    ),
                  ), 
                )
              ]),

              const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

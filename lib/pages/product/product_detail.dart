// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../utilis/custom_theme.dart';
import '../../utilis/dimensions.dart';
import '../Data/Models/Product_model_respon.dart';
import 'widgets/bottom_cart.dart';
import 'widgets/product_image.dart';
import 'widgets/product_spesification.dart';
import 'widgets/product_title.dart';

class ProductDetail extends StatefulWidget {
  
  final Product product;
  const ProductDetail({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Padding(padding: const EdgeInsets.all(10.0),
              child: Icon(
                Icons.arrow_back_ios,
                color: Theme.of(context).cardColor,
                size: 20
              ),
            ),
          ),
           const SizedBox(width: Dimensions.paddingSizeSmall),
           Text('Product Detail', 
           style: robotoRegular.copyWith(
            fontSize: 20,
            color: Theme.of(context).cardColor
           )),
          ]),
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: RefreshIndicator(
          onRefresh: () async {},
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                ProductImage(
                  image: widget.product.imageProduct!,
                ),
                Container(
                  transform: Matrix4.translationValues(0.0, -25.0, 0.0),
                  padding: const EdgeInsets.only(
                    top: Dimensions.fontSizeDefault
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(
                        Dimensions.paddingSizeExtraLarge
                      ),
                      topRight: Radius.circular(
                        Dimensions.fontSizeExtraLarge
                      )
                    ),
                  ),
                  child: Column(
                    children: [
                      ProductTitleView(product: widget.product),
                    Container(
                      height: 250,
                      margin: const EdgeInsets.only(
                        top: Dimensions.paddingSizeSmall
                      ),
                      padding: const EdgeInsets.all(
                        Dimensions.paddingSizeSmall
                      ),
                      child: ProductSpesication(
                        productSpesication: widget.product.descripton!),
                    ),
                    const SizedBox(),
                    ],
                  ),
                ),
              ],
            )),
        ),
        bottomNavigationBar: BottomCart(product: widget.product),
      ),
    );
  }
}
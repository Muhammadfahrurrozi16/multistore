import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';

import '../../../bloc/checkout/checkout_bloc.dart';
import '../../../utilis/color_resource.dart';
import '../../../utilis/custom_theme.dart';
import '../../../utilis/dimensions.dart';
import '../../../utilis/images.dart';
import '../../../utilis/price_ext.dart';
import '../../Data/Models/Product_model_respon.dart';
import '../../base_widget/button/custom_button.dart';

class CartBottomSheet extends StatefulWidget {
  final Function? callback;
  final Product product;
  const CartBottomSheet({
    Key? key,
    this.callback,
    required this.product,
  }) : super(key: key);

  @override
  CartBottomSheetState createState() => CartBottomSheetState();
}

class CartBottomSheetState extends State<CartBottomSheet> {
  int quatity = 1;
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          decoration: BoxDecoration(
            color: Theme.of(context).highlightColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20)
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).highlightColor,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).hintColor,
                          spreadRadius: 1,
                          blurRadius: 5,
                        )
                      ]
                    ),
                    child: const Icon(
                      Icons.clear,
                      size: Dimensions.iconSizeSmall),
                  ),
                )
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: ColorResources.getHomeBg(context),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: .5,
                            color: Theme.of(context).primaryColor.withOpacity(.20)
                          )
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: FadeInImage.assetNetwork(
                            placeholder: Images.placeholder,
                            image: widget.product.imageProduct!,
                            imageErrorBuilder: (context, error, stackTrace) => Image.asset(Images.placeholder),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.product.name!,
                            style: titilliumRegular.copyWith(
                              fontSize: Dimensions.fontSizeLarge
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis
                          ),
                        const SizedBox(
                          height: Dimensions.paddingSizeSmall
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.orange),
                            Text(double.parse('5').toStringAsFixed(1),
                            style: titilliumSemiBold.copyWith(
                              fontSize: Dimensions.fontSizeLarge
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis
                            ),
                          ],
                        ),
                          ]
                        ),
                      )
                    ]
                  ),
                  Row(
                    children: [
                      const SizedBox(width: Dimensions.paddingSizeDefault),
                      const SizedBox(width: Dimensions.paddingSizeDefault),
                      Text(
                        '${widget.product.price}'.formatPrice(),
                        style: titilliumRegular.copyWith(
                          color: ColorResources.getPrimary(context),
                          fontSize: Dimensions.fontSizeExtraLarge
                        ),
                      ),
                    ],
                  ),
                  ],
              ),
              const SizedBox(height: Dimensions.paddingSizeSmall),
              const SizedBox(height: Dimensions.paddingSizeSmall,
              ),
              Row(
                children: [
                  const Text('Quatity', style: robotoBold),
                  const SizedBox(width: 8,
                  ),
                  ElevatedButton(
                    onPressed: (){
                      setState(() {
                        quatity -= 1;
                      });
                    }, child: const Text('-'),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text('$quatity',style: titilliumSemiBold),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          quatity += 1;
                        });
                      }, child: const Text('+'),
                      ),
                ]),
                const SizedBox(height: Dimensions.paddingSizeSmall),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Total price', style: robotoBold),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                  Text(
                    '${widget.product.price! * quatity}'.formatPrice(),
                    style: titilliumBold.copyWith(
                      color: ColorResources.getPrimary(context),
                      fontSize: Dimensions.fontSizeLarge
                    ),
                  )
                  ]),
                const SizedBox(height: Dimensions.paddingSizeSmall),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        buttonText: 'Add to Cart',
                        onTap: (){
                          context.read<CheckoutBloc>().add(
                            CheckoutEvent.addCart(widget.product, quatity),
                          );
                          Navigator.pop(context);
                        }),
                      ),
                      const SizedBox(width: Dimensions.paddingSizeDefault),
                      Expanded(child: CustomButton(
                        isBuy: true,
                        buttonText: 'Buy Now',
                        onTap: () {}),
                        ),
                      ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
import 'package:app_fic/pages/cart/cart.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/checkout/checkout_bloc.dart';
import '../../../utilis/color_resource.dart';
import '../../../utilis/custom_theme.dart';
import '../../../utilis/dimensions.dart';
import '../../../utilis/images.dart';
import '../../Data/Models/Product_model_respon.dart';
import '../../base_widget/show_custom_snackbar.dart';
import 'cart_bottom_sheet.dart';

class BottomCart extends StatefulWidget {
  final Product product;
  const BottomCart({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<BottomCart> createState() => _BottomCartState();
}

class _BottomCartState extends State<BottomCart> {
  bool vacationIsOn = false;
  bool temporaryClose = false;
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10)
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).hintColor,
            blurRadius: .5,
            spreadRadius: .1
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Cartpage() ));
                    },
                    child: Image.asset(Images.cartArrowDownImage,
                    color: ColorResources.getPrimary(context))
                  ),
                  Positioned(
                    top: 0,
                    right: 15,
                    child: Container(
                      height: 17,
                      width: 17,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorResources.getPrimary(context),
                      ),
                      child: BlocBuilder<CheckoutBloc, CheckoutState>(
                        builder: (context, state) {
                          return state.map(
                            loading: (value) {
                              return CircularProgressIndicator();
                            },
                            loaded: (value){
                              int totalQty = 0;
                              value.products.forEach(
                                (element) {
                                  totalQty += element.quatity;
                              },
                              );
                              return Text(
                                '$totalQty',
                                style: titilliumSemiBold.copyWith(
                                  fontSize: Dimensions.fontSizeExtraSmall,
                                  color: Theme.of(context).highlightColor
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ]),
              )),
            Expanded(
              flex: 11,
              child: InkWell(
                onTap: () {
                  if (vacationIsOn || temporaryClose) {
                  } else {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Theme.of(context).primaryColor.withOpacity(0),
                      builder: (con) => CartBottomSheet(
                        product: widget.product,
                        callback: () {
                          showCustomSnackbar('add to cart', context, isError: false);
                        },
                      ));
                  }
                },
                child: Container(
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorResources.getPrimary(context),
                  ),
                  child: Text(
                    'add to Cart',
                    style: titilliumSemiBold.copyWith(
                      fontSize: Dimensions.fontSizeLarge,
                      color: Theme.of(context).highlightColor
                    ),
                  ),
                ),
              )),
            ],
      ),
    );
  }
}
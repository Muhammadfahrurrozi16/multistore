// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/checkout/checkout_bloc.dart';
import '../../bloc/order/order_bloc.dart';
import '../../utilis/color_resource.dart';
import '../../utilis/custom_theme.dart';
import '../../utilis/dimensions.dart';
import '../../utilis/images.dart';
import '../../utilis/price_ext.dart';
import '../Data/Models/request/order_request_model.dart';
import '../base_widget/amount_widget.dart';
import '../base_widget/payment/payment_page.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final TextEditingController _shoppingAddress = TextEditingController();
  int subPrice = 0;
  int totalPrice = 0;
  List<Item>items = [];
  int shippingCost = 22000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {
          return state.maybeWhen(orElse: (){
            return const CircularProgressIndicator();
          },loaded: (products) {
            items = products.map((e) => Item(id: e.product.id!,
             quantity: e.quatity)).toList();
            products.forEach((element) {
              subPrice += element.quatity * element.product.price!;
            },
          );
          totalPrice = subPrice + shippingCost;
          return ListView(physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeDefault
              ),
              child: Text(
                'shipping Address',
                style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
              ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeDefault
                ),
                child: Text(
                  'Order Detail',
                  style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final productQuatity = products[index];
                  return Padding(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: .5,
                            color: Theme.of(context).primaryColor.withOpacity(.25)
                          ),
                          borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraExtraSmall),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraExtraSmall),
                          child: FadeInImage.assetNetwork(
                            placeholder: Images.placeholder,
                            fit: BoxFit.cover,
                            width: 50,
                            height: 50,
                            image: productQuatity.product.imageProduct!,
                            imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                              Images.placeholder,
                              fit: BoxFit.cover,
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: Dimensions.marginSizeDefault),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(productQuatity.product.name!,
                                    style: titilliumRegular.copyWith(
                                      fontSize: Dimensions.fontSizeDefault,
                                      color: ColorResources.getPrimary(context)
                                    ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(
                                  width: Dimensions.paddingSizeSmall,
                                ),
                                Text(
                                  '${productQuatity.product.price! * productQuatity.quatity}'.formatPrice(),
                                  style: titilliumSemiBold.copyWith(
                                    fontSize: Dimensions.fontSizeLarge
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: Dimensions.marginSizeExtraSmall),
                            Row(children: [
                              Text('Qty - ${productQuatity.quatity}',
                              style: titilliumRegular.copyWith()),
                            ]),
                          ]),
                        ),
                    ]
                  ), 
                  );
                }),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(.055),
              ),
              child: Center(
                child: Text(
                  'Order Summar',
                  style: titilliumSemiBold.copyWith(
                    fontSize: Dimensions.fontSizeLarge
                  ),
                )),
            ),
            Container(
              margin: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              color: Theme.of(context).highlightColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AmountWidget(
                    title: 'Sub Total :',
                    amount: '$subPrice'.formatPrice()),
                  AmountWidget(
                    title: 'Shipping cost :',
                    amount: '$shippingCost'.formatPrice()),
                  Divider(height: 5,color: Theme.of(context).hintColor),
                  AmountWidget(
                    title: 'Total :',
                    amount: '$totalPrice'.formatPrice()),
                ]),
            ),
          ]);
          });
        }),
      bottomNavigationBar: BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: (){},
            loaded: (data) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return PaymentPage(url: data.data.paymentUrl,
                );
              }));
            },
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            orElse: (){
              return InkWell(
                onTap: () {
                  final requestModel = OrderRequestModel(
                    items: items,
                    totalPrice: totalPrice, 
                    deliveryAddress: _shoppingAddress.text,
                    sellerId: 4,
                    );
                  context.read<OrderBloc>().add(OrderEvent.order(requestModel));
                },
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeLarge,
                    vertical: Dimensions.paddingSizeDefault
                  ),
                  decoration: BoxDecoration(
                    color: ColorResources.getPrimary(context),
                  ),
                  child: Center(
                    child: Builder(
                      builder: (context) => Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width/ 2.9
                        ),
                        child: Text('Proceed',
                        style: titilliumSemiBold.copyWith(
                          fontSize: Dimensions.fontSizeExtraLarge,
                          color: Theme.of(context).cardColor,
                        )),
                        ),
                   )),
                ),
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        },
      ),
    );
  }
}

class PaymentButton extends StatelessWidget {
  final String image;
  final Function? onTap;
  const PaymentButton({
    Key? key,
    required this.image,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Container(
        height: 45,
        margin: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeExtraSmall
        ),
        padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: ColorResources.getGrey(context)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset(image),
      ),
    );
  }
}

class PaymentMethod {
  String name;
  String image;
  PaymentMethod({
    required this.name,
    required this.image,
  });
}

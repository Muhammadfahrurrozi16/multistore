part of 'checkout_bloc.dart';

@freezed
class CheckoutState with _$CheckoutState {
  // const factory CheckoutState.initial() = _Initial;
  const factory CheckoutState.loaded(List<ProductQuatity> products) = _Loaded;
}

class ProductQuatity {
  final Product product;
  final int quatity;
  ProductQuatity({
    required this.product,
    required this.quatity,
  });
}

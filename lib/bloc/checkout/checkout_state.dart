part of 'checkout_bloc.dart';

@freezed
class CheckoutState with _$CheckoutState {
  // const factory CheckoutState.initial() = _Initial;
  const factory CheckoutState.loaded(List<ProductQuatity> products) = _Loaded;
  const factory CheckoutState.loading() = _Loading;
}

class ProductQuatity {
  final Product product;
  final int quatity;
  ProductQuatity({
    required this.product,
    required this.quatity,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ProductQuatity &&
      other.product == product &&
      other.quatity == quatity;
  }

  @override
  int get hashCode => product.hashCode ^ quatity.hashCode;
}

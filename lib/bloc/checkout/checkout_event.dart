part of 'checkout_bloc.dart';

@freezed
class CheckoutEvent with _$CheckoutEvent {
  const factory CheckoutEvent.started() = _Started;
  const factory CheckoutEvent.addCart(Product product,int quatity) = _AddCart;
  const factory CheckoutEvent.removeCart(Product product,int quatity) = _RemoveCart;
}
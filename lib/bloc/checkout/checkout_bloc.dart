import 'package:app_fic/pages/Data/Models/Product_model_respon.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';
part 'checkout_bloc.freezed.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(const _Loaded([])) {
    on<_AddCart>((event, emit) {
      final productQuatity = ProductQuatity(
        product: event.product,
        quatity: event.quatity,
      );
      final currentState = state as _Loaded;
      emit(_Loaded([
        ...currentState.products,
        productQuatity,
      ]));
    });
  }
}

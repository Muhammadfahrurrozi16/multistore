import 'package:app_fic/pages/Data/Models/Product_model_respon.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';
part 'checkout_bloc.freezed.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(const _Loaded([])) {
    on<_AddCart>((event, emit) {
      final CurrentState = state as _Loaded;
      final productQuatity = ProductQuatity(
        product: event.product,
        quatity: event.quatity,
      );

      if (CurrentState.products.where((element) => element.product == event.product).isNotEmpty
      ) {
        for (var productQuatity in CurrentState.products) {
          if (productQuatity.product == event.product) {
            productQuatity.quatity = productQuatity.quatity + event.quatity;
          }
        }
        final newState = CurrentState.products;
        emit(const _Loading());
        emit(_Loaded(newState));
      } else {
         emit(_Loaded([
          ...CurrentState.products,
          productQuatity,
         ]));
      }
      // final currentState = state as _Loaded;
      //
    });
    on<_RemoveCart>((event, emit) {
      var CurrentState = state as _Loaded;

      if (CurrentState.products.where((element) => element.product == event.product).isNotEmpty
      ) {
        var products = [...CurrentState.products];
        products.removeWhere((element) => element.product == event.product);
        final newState =products;
        emit(const _Loading());
        emit(_Loaded(newState));
      } else {
         emit(_Loaded([
          ...CurrentState.products,
         ]));
      }
      // final currentState = state as _Loaded;
      //
    });
    on<_Clear>((event, emit) {
     emit(const _Loaded([])); 
    });

  }
}

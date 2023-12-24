import 'package:app_fic/pages/Data/DataResources/product_remote.datasources.dart';
import 'package:app_fic/pages/Data/Models/Product_model_respon.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_event.dart';
part 'product_state.dart';
part 'product_bloc.freezed.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(const _Initial()) {
    on<_GetAll>((event, emit) async {
      emit(const _Loading());
      final result = await ProductRemoteDatarsources().getProduct();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
        );
    });
  }
}

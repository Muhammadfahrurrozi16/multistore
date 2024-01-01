import 'package:app_fic/pages/Data/DataResources/order_remote_datasources.dart';
import 'package:app_fic/pages/Data/Models/order_model_respon.dart';
import 'package:app_fic/pages/Data/Models/request/order_request_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_event.dart';
part 'order_state.dart';
part 'order_bloc.freezed.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(const _Initial()) {
    on<_Order>((event, emit) async {
     emit(const _Loading());
     final response = await OrderRemoteDatasources().order(event.model);
     response.fold(
      (l) => emit(_Error(l)),
      (r) => emit(_Loaded(r)),
      );
    });
  }
}

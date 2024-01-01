import 'package:app_fic/pages/Data/DataResources/auth_remote_datasources.dart';
import 'package:app_fic/pages/Data/Models/Auth_model_respon.dart';
import 'package:app_fic/pages/Data/Models/request/login_request_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const _Initial()) {
    on<_Login>((event, emit) async{
      emit(const _Loading());
      final result = await AuthRemoteDatasource().login(event.model);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}

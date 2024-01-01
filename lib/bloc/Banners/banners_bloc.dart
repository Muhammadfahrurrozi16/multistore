import 'package:app_fic/pages/Data/DataResources/banner_remote_datasources.dart';
import 'package:app_fic/pages/Data/Models/banner_model_respon.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'banners_event.dart';
part 'banners_state.dart';
part 'banners_bloc.freezed.dart';

class BannersBloc extends Bloc<BannersEvent, BannersState> {
  BannersBloc() : super(const _Initial()) {
    on<_GetAll>((event, emit) async {
      emit(const _Loading());
      final response = await BannerRemoteDataSources().getBanner();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r))
        );
    });
  }
}

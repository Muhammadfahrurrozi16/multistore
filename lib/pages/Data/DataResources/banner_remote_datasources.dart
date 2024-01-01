import '../../../common/Global_Variabel.dart';
import 'package:dartz/dartz.dart';
import '../Models/banner_model_respon.dart';
import 'package:http/http.dart' as http ;

class BannerRemoteDataSources {
  Future<Either<String, BannerResponModel>> getBanner() async {
    final headers = {
      'Accept' : 'application/json',
      'Content-Type' : 'application/json',
    };
    final response = await http.get(
      Uri.parse('${GlobalVariables.baseUrl}/api/Banners'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return Right(BannerResponModel.fromJson(response.body));
    } else {
      return const Left('Server Error');
    }
  }
}
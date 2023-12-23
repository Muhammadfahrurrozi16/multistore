import '../Models/Auth_model_respon.dart';
import '../Models/request/register_request_model.dart';
import '../../../common/Global_Variabel.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDatasource {
  Future<Either<String, AuthResponModel>> register(
    RegisterRequestModel model) async {
      final headears = {
        'Accept' : 'application/json',
        'Content_Type' : 'application/json'
      };
      final response = await http.post(
          Uri.parse('${GlobalVariables.baseUrl}/api/register'),
          headers: headears,
          body: model.toJson()
      );
      if (response.statusCode == 200) {
        return Right(AuthResponModel.fromJson(response.body));
      } else {
        return const Left('Server error');
      }
    }
}
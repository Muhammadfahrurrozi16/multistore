import 'package:dartz/dartz.dart';
import '../Models/order_model_respon.dart';
import '../Models/request/order_request_model.dart';
import 'package:http/http.dart' as http;
import '../../../common/Global_Variabel.dart';
import 'auth_local_datasources.dart';

class OrderRemoteDatasources {
  Future<Either<String, OrderResponseModel>> order(
    OrderRequestModel orderRequestModel) async {
      final token = await AuthLocalDatasource().getToken();
      final headers = {
        'Accept' : 'application/json',
        'Content-Type' : 'application/json',
        'Authorization' : 'Bearer $token',
      };
      final response = await http.post(
        Uri.parse('${GlobalVariables.baseUrl}/api/orders'),
        headers: headers,
        body: orderRequestModel.toJson()
      );
      if (response.statusCode == 200) {
        return right(OrderResponseModel.fromJson(response.body));
      } else {
        return const Left('Server Error');
      }
    }
}
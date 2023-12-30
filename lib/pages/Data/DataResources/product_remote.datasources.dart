import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../../../common/Global_Variabel.dart';
import '../../Data/Models/Product_model_respon.dart';

class ProductRemoteDatarsources {
  Future<Either<String, ProductResponModel>> getProduct() async {
    final headers = {
      'Accept' : 'application/json',
      'Content-Type' : 'application/json',
    };
    final response = await http.get(
      Uri.parse('${GlobalVariables.baseUrl}/api/Products'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return Right(ProductResponModel.fromJson(response.body));
    } else {
      return const Left('Server Error');
    }
  }
  Future<Either<String, ProductResponModel>> getProductsByCategory(int categoryId) async {
    final headers = {
      'Accept' : 'application/json',
      'Content-Type' : 'application/json',
    };
    final response = await http.get(
      Uri.parse('${GlobalVariables.baseUrl}/api/Products?category_id=$categoryId'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return Right(ProductResponModel.fromJson(response.body));
    } else {
      return const Left('Server Error');
    }
  }
}
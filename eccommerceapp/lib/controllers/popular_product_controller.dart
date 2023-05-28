import 'package:eccommerceapp/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];

  List<dynamic> get popularProductList => _popularProductList;
  
  Future<void>getPopularProductList() async{
    Response response = await popularProductRepo.getPopularPoductList();
    if(response.statusCode == 200){
      _popularProductList = [];
      // _popularProductList.addAll(iterable);
      update();
    }else{

    }
  }

}
import 'package:dots_indicator/dots_indicator.dart';
import 'package:eccommerceapp/colors/colors.dart';
import 'package:eccommerceapp/widgets/big_text.dart';
import 'package:eccommerceapp/widgets/small_text.dart';
import 'package:eccommerceapp/widgets/icon_text_widget.dart';
import 'package:eccommerceapp/utills/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:eccommerceapp/widgets/app_column.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.90);
  var _currentPageValue = 0.0;
  final double _scaleFactor = 0.8;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    PageController().dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //slider section
        Container(
          //color: Colors.redAccent,
          height: Dimensions.pageView,
          child: PageView.builder(
            controller: pageController,
            itemCount: 5,
            itemBuilder: (context, position){
              return _buildPageItem(position);
            },
          ),
        ),
        // dots section
        DotsIndicator(
          dotsCount: 5,
          position: _currentPageValue,
          decorator: DotsDecorator(
            activeColor: AppColors.mainColor, 
            size: Size.square(Dimensions.dimension9),
            activeSize: Size(Dimensions.width18, Dimensions.height9),
            activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radius5)),
          ), 
        ),
        SizedBox(height: Dimensions.height20,),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Popular", color: Colors.black),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom:3),
                child: BigText(text: ".", color: Colors.black26)
              ),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: SmallText(text: "Food pairing"),
              ), 
            ],
          ),
        ),
        // list food and images
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context,index){
            return Container(
              margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, bottom: Dimensions.height10),
              child: Row(
                children: [
                  //Image section
                  Container(
                    width: Dimensions.listViewIm,
                    height: Dimensions.listViewIm,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.white38,
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          "assests/images/food1.webp",
                        ),
                      ),
                    ),
                  ),
                  
                  //Text container
                  Expanded(
                    child: Container(
                      height: Dimensions.listViewText,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(Dimensions.radius20),
                          bottomRight: Radius.circular(Dimensions.radius20),
                        ),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: Dimensions.width5,right: Dimensions.width10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BigText(text: "Nutritious Pizza meal in Cameroon", color: Colors.black,),
                            SizedBox(height: Dimensions.height10,),
                            SmallText(text: "With cameroonian characteristics"),
                            SizedBox(height: Dimensions.height10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                IconAndTextWidget(icon: Icons.circle_sharp, text: 'Normal', iconColor: AppColors.iconColor1),
                                IconAndTextWidget(icon: Icons.location_on, text: '4.1km', iconColor: AppColors.mainColor),
                                IconAndTextWidget(icon: Icons.access_time_filled_rounded, text: '12min', iconColor: AppColors.iconColor2),
                                
                              ],
                            ),
                            
                          ],
                        ),
                      ), 
                    ),
                  ),
                ],
              ),
            );
          }     
        ),
              
      ],
    );
  }

  Widget _buildPageItem(int index){
    Matrix4 matrix =   Matrix4.identity();
    if (index == _currentPageValue.floor()){
      var currScale = 1-(_currentPageValue - index)*(1-_scaleFactor);
      var currTrans = Dimensions.pageViewContainer*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else if (index == _currentPageValue.floor() + 1){
      var currScale = _scaleFactor + (_currentPageValue - index + 1)* (1 - _scaleFactor);
      var currTrans = Dimensions.pageViewContainer*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else if (index == _currentPageValue.floor() - 1){
      var currScale = 1-(_currentPageValue - index)*(1-_scaleFactor);
      var currTrans = Dimensions.pageViewContainer*(1-currScale)/2; 
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      var currTrans = Dimensions.pageViewContainer*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
      
    } 

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: Dimensions.pageViewContainer,
            margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              color: index.isEven?const Color(0xFF69c5df):const Color(0xFF9294cc),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assests/images/food2.jpg',
                )
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, bottom: Dimensions.height20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color:Color(0xFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0, 5)
                  ),
                  BoxShadow(
                    color: Colors.white, 
                    offset: Offset(-5, 0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5, 0),
                  ),
                ]
              ),
    
              child: Container(
                padding: EdgeInsets.only(top: Dimensions.height15 , left: Dimensions.width15, right:Dimensions.width15),
                child: const AppColumn(text: "Pizza a LIO",),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
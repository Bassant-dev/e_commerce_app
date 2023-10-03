import 'package:e_commerce_app/screens/Register/view/Register_screen_body.dart';
import 'package:e_commerce_app/screens/books_screen/view_model/cubit/cubit.dart';
import 'package:e_commerce_app/screens/books_screen/view_model/cubit/states.dart';
import 'package:e_commerce_app/screens/fav_screen/model/show_fav_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../core/cache_helper.dart';

import '../../../../core/components.dart';
import '../../../books_screen/model/books_details_model.dart';
import '../../../cart_screen/view_model/cubit/cubit.dart';
import '../../../home_screen/view/home_screen.dart';
import '../../view_model/cubit/cubit.dart';
import '../../view_model/cubit/states.dart';

class FavScreenBody extends StatelessWidget {
  FavScreenBody({Key? key}) : super(key: key);

  DataModel Model = DataModel();

  @override
  Widget build(BuildContext context) {
    print(CacheHelper.getData(key: "token"));
    return BlocConsumer<FavCubit, FavStates>(
      listener: (context, state) async {

      },
      builder: (context, state) {
        final favModel = FavCubit.get(context).showFavModel?.data?.data;

        return Scaffold(

          body: state is! ShowFavLoadingState
              ? FavCubit.get(context).showFavModel?.data!.data!.length == 0
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/img/3271760.jpg',
                  width: 150,
                  height: 150,
                ),
                SizedBox(height: 16),
                Text(
                  'No favorites added',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          )
              : ListView.builder(
            itemCount:
            FavCubit.get(context).showFavModel?.data?.data?.length ?? 0,
            itemBuilder: (context, index) {
              final cart =
              FavCubit.get(context).showFavModel?.data?.data?[index];
              return Container(
                padding: EdgeInsets.all(8.0),
                child: Card(
                  elevation: 4.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Image.network(
                              cart?.image ??
                                  'https://img.freepik.com/free-photo/front-view-smiley-woman-with-fireworks_52683-98180.jpg',
                              fit: BoxFit.cover,
                              height: 120,
                            ),
                            if (cart?.discount != null)
                              Container(
                                padding: EdgeInsets.all(4.0),
                                color: Colors.red,
                                child: Text(
                                  '${cart?.discount}% OFF',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                cart?.name ?? 'Product Name not available',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '\$${cart?.price ?? 'Price not available'}',
                                    style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '\$${cart?.price ?? 'Price not available'}',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 26.sp,
                        ),
                        onPressed: () {
                          if (cart != null && cart.id != null) {
                            FavCubit.get(context)
                                .DeleteFav(product_id: cart.id.toString());
                            FavCubit.get(context).ShowFav();
                          }
                        },
                      )
                    ],
                  ),
                ),
              );
            },
          )
              : Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          ),

        );
      },
    );
  }
}

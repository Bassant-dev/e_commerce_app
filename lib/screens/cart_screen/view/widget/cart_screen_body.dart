import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../books_screen/view_model/cubit/cubit.dart';
import '../../view_model/cubit/cubit.dart';
import '../../view_model/cubit/states.dart';
import 'checkout_screen.dart';

class CartScreenBody extends StatelessWidget {
  CartScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartStates>(
      listener: (context, state) async {

      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: CartCubit.get(context)
                      .showCartModel?.data?.cartItems?.length ?? 0,
                  itemBuilder: (context, index) {
                    final cart = CartCubit.get(context)
                        .showCartModel?.data?.cartItems?[index];

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
                                    cart?.itemProductImage ??
                                        'https://img.freepik.com/free-photo/front-view-smiley-woman-with-fireworks_52683-98180.jpg',
                                    fit: BoxFit.cover,
                                    height: 170,
                                  ),
                                  if (cart?.itemProductDiscount != null)
                                    Container(
                                      padding: EdgeInsets.all(4.0),
                                      color: Colors.red,
                                      child: Text(
                                        '${cart?.itemProductDiscount}% OFF',
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
                                      cart?.itemProductName ??
                                          'Product Name not available',
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
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '\$${cart?.itemProductPrice ?? 'Price not available'}',
                                          style: TextStyle(
                                            decoration:
                                            TextDecoration.lineThrough,
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
                                      '\$${cart?.itemProductPriceAfterDiscount ?? 'Price not available'}',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  BlocBuilder<CartCubit, CartStates>(
                                    builder: (context, state) {
                                      return Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.remove),
                                            onPressed: () {
                                              CartCubit.get(context).update_Quantity(cart?.itemQuantity);
                                              CartCubit.get(context).decrementProductQuantity();
                                              CartCubit.get(context).UpadateCart( cart!.itemId);
                                              print( CartCubit.get(context).quantity);
                                              CartCubit.get(context).ShowCart();
                                            },
                                          ),
                                          Text(
                                            '${cart?.itemQuantity}',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.add),
                                            onPressed: () {
                                              CartCubit.get(context).update_Quantity(cart?.itemQuantity);
                                              CartCubit.get(context).incrementProductQuantity();
                                              CartCubit.get(context).UpadateCart( cart!.itemId);
                                              print( CartCubit.get(context).quantity);
                                              CartCubit.get(context).ShowCart();

                                            },
                                          ),


                                        ],
                                      );
                                    },
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
                                print('${cart?.itemId}');
CartCubit.get(context).removeCart(cart_item_id: cart!.itemId ?? 0);
CartCubit.get(context).ShowCart();
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Total Button
              CartCubit.get(context).showCartModel != null
                  ? ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CheckOutScreenBody()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: HexColor('#174068'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: Size(312.w, 48.h),
                ),
                child: Text(
                  'Total Price : ${CartCubit.get(context).showCartModel?.data?.total} ',
                  style: GoogleFonts.roboto(
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
              ):  Center(child: CircularProgressIndicator()),
            ],
          ),
        );
      },
    );
  }
}

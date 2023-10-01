import 'package:e_commerce_app/screens/Register/view/Register_screen_body.dart';
import 'package:e_commerce_app/screens/books_screen/view/widget/books_details.dart';
import 'package:e_commerce_app/screens/home_screen/view_model/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../core/cache_helper.dart';

import '../../../../core/components.dart';
import '../../../home_screen/view/home_screen.dart';
import '../../view_model/cubit/cubit.dart';
import '../../view_model/cubit/states.dart';

class BooksScreenBody extends StatelessWidget {
  BooksScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(CacheHelper.getData(key: "token"));
    return BlocConsumer<BooksCubit, BooksStates>(
      listener: (context, state) async {
if(state is GetBooksLoadingState){
  Center(child: CircularProgressIndicator());
}
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: HexColor("#174068"),
            title: Text('Books', style: TextStyle(color: Colors.white)),
            actions: [IconButton(onPressed: (){}, icon: Icon(Icons.search,color: Colors.white,))],
          ),
          body: ListView.builder(
            itemCount: BooksCubit.get(context)
                .getBooksModel?.data?.products?.length ??
                0,
            itemBuilder: (context, index) {
              final book = BooksCubit.get(context)
                  .getBooksModel?.data?.products?[index];

              return Container(
                padding: EdgeInsets.all(8.0),
                child: Card(
                  elevation: 4.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 2, // Adjust the flex factor as needed
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Image.network(
                              book?.image ??
                                  'https://img.freepik.com/free-photo/front-view-smiley-woman-with-fireworks_52683-98180.jpg',
                              fit: BoxFit.cover,
                              height: 210, // Set an image height
                            ),
                            if (book?.discount != null)
                              Container(
                                padding: EdgeInsets.all(4.0),
                                color: Colors.red,
                                child: Text(
                                  '${book?.discount}% OFF',
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
                        flex: 3, // Adjust the flex factor as needed
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                book?.name ??
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                book?.category ?? " ",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: HexColor("#666666"),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '\$${book?.price ?? 'Price not available'}',
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
                                '\$${book?.priceAfterDiscount ?? 'Price not available'}',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: double.infinity,
                                child: ElevatedButton(

                                  onPressed: () {
                                    print(book?.id);
                                    BooksCubit.get(context)
                                        .GetBooksDetails(book?.id ?? 1);
                                    BooksCubit.get(context).GetBooks();
                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          BookDetails(id: book?.id ?? 1),
                                    ));
                                  },
                                  child: Text('Books Details'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.favorite_border),
                        onPressed: () {
                          // Handle favorite button press here
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.shopping_cart),
                        onPressed: () {
                          // Handle add to cart button press here
                        },
                      ),

                    ],
                  ),
                ),
              );
            },
          )

        );
      },
    );
  }
}

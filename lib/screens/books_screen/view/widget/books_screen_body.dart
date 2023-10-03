import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce_app/screens/Register/view/Register_screen_body.dart';
import 'package:e_commerce_app/screens/books_screen/view/widget/books_details.dart';
import 'package:e_commerce_app/screens/books_screen/view_model/cubit/states.dart';
import 'package:e_commerce_app/screens/fav_screen/view_model/cubit/cubit.dart';
import 'package:e_commerce_app/screens/home_screen/view_model/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../core/cache_helper.dart';

import '../../../../core/components.dart';
import '../../../home_screen/view/home_screen.dart';
import '../../model/books_details_model.dart';
import '../../model/get_books_model.dart';
import '../../view_model/cubit/cubit.dart';

class BooksScreenBody extends StatelessWidget {
  const BooksScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(CacheHelper.getData(key: "token"));
    return BlocProvider(
      create: (context) => BooksCubit()..GetBooks(),
      child: BlocConsumer<BooksCubit, BooksStates>(
        listener: (context, state) async {
          if (state is AddToFavSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Add Successfully"),
                duration: Duration(seconds: 2),
              ),
            );
            print("mostafa");
            FavCubit.get(context).ShowFav();
            BooksCubit.get(context).GetBooks();
            print("mostafa");
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: ConditionalBuilder(
              condition: state is! GetBooksLoadingState,
              fallback: (context) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
              builder: (context) {
                return ListView.builder(
                  itemCount:
                  BooksCubit.get(context).getBooksModel?.data?.products?.length ?? 0,
                  itemBuilder: (context, index) {
                    final book = BooksCubit.get(context).getBooksModel?.data?.products?[index];

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
                                    book?.image ??
                                        'https://img.freepik.com/free-photo/front-view-smiley-woman-with-fireworks_52683-98180.jpg',
                                    fit: BoxFit.cover,
                                    height: 210,
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
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      book?.name ?? 'Product Name not available',
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
                                          print(book?.name);


                                          BooksCubit.get(context).GetBooksDetails(book?.id ?? 0);
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => BookDetails(id: book?.id ?? 0),
                                            ),
                                          );
                                        },
                                        child: Text('Books Details'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.favorite,
                                color: FavCubit.get(context).favIds.contains(book!.id) ? Colors.red : Colors.grey,
                              ),
                              onPressed: () {
                                BooksCubit.get(context).addToFav(product_id: '${book.id ?? 1}');
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

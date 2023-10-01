import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../model/books_details_model.dart';
import '../../view_model/cubit/cubit.dart';
import '../../view_model/cubit/states.dart';

class BookDetails extends StatelessWidget {
  BookDetails({Key? key, required this.id}) : super(key: key);
  int id;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BooksCubit, BooksStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        final cubit = BooksCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: HexColor("#174068"),
            title: Text('Book Details', style: TextStyle(color: Colors.white)),
          ),
          body: BooksCubit.get(context).booksDetailsModel != null ?
               SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image with Favorite Icon
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 400,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              '${cubit.booksDetailsModel?.data?.image}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        // Implement your favorite button logic here
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  '${cubit.booksDetailsModel?.data?.name}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Category : ${cubit.booksDetailsModel?.data?.category}',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  '${cubit.booksDetailsModel?.data?.description}',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '\$${cubit.booksDetailsModel?.data?.price ?? 'Price not available'}',
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      fontSize: 14.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '\$${cubit.booksDetailsModel?.data?.priceAfterDiscount ?? 'Price not available'}',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 24.0),
                // Add to Cart Button
                Container(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary:
                      HexColor("#174068"), // Set the background color here
                    ),
                    onPressed: () {
                      // Add your onPressed logic here
                    },
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ): Center(child: CircularProgressIndicator()));


      },
    );
  }
}
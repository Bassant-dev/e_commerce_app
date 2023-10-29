import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shimmer/shimmer.dart';

import '../../../cart_screen/view_model/cubit/cubit.dart';
import '../../../cart_screen/view_model/cubit/states.dart';
import '../../model/books_details_model.dart';
import '../../view_model/cubit/cubit.dart';
import '../../view_model/cubit/states.dart';

class BookDetails extends StatelessWidget {
  BookDetails({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BooksCubit, BooksStates>(
      listener: (context, state) {
        if (state is AddToCartSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Added to Cart successfully"),
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = BooksCubit.get(context);
        final booksDetailsModel = cubit.booksDetailsModel;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: HexColor("#174068"),
            title: Text('Book Details', style: TextStyle(color: Colors.white)),
          ),
          body: booksDetailsModel != null
              ? SingleChildScrollView(
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
                          image: NetworkImage('${booksDetailsModel.data?.image}'),
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
                  '${booksDetailsModel.data?.name}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Category : ${booksDetailsModel.data?.category}',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  '${booksDetailsModel.data?.description}',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 16.0),
                Text(
                  '\$${booksDetailsModel.data?.price ?? 'Price not available'}',
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    fontSize: 20.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${booksDetailsModel.data?.priceAfterDiscount ?? 'Price not available'}',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 24.0),
                // Add to Cart Button
                Container(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: HexColor("#174068"),
                    ),
                    onPressed: () {
                      BooksCubit.get(context).addToCart(product_id: '${booksDetailsModel.data?.id ?? ''}');
                      CartCubit.get(context).ShowCart();
                    },
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          )
              : _buildShimmerEffect(), // Show shimmer if data is loading
        );
      },
    );
  }

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      enabled: true, // Set to false when loading is finished
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildShimmerPlaceholder(double.infinity,400), // Placeholder for the image
            SizedBox(height: 16.0),
            _buildShimmerPlaceholder(150, 20), // Placeholder for title
            SizedBox(height: 8.0),
            _buildShimmerPlaceholder(100, 20), // Placeholder for category
            SizedBox(height: 16.0),
            _buildShimmerPlaceholder(double.infinity, 100), // Placeholder for description
            SizedBox(height: 16.0),
            _buildShimmerPlaceholder(100, 20), // Placeholder for price
            _buildShimmerPlaceholder(100, 20), // Placeholder for discounted price
            SizedBox(height: 24.0),
            _buildShimmerButton(double.infinity, 60), // Placeholder for the button
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerPlaceholder(double width, double height) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey, // Placeholder color or shimmer effect
    );
  }

  Widget _buildShimmerButton(double width, double height) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey, // Placeholder color for button
    );
  }
}

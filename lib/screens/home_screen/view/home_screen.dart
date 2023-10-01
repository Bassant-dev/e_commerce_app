import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/screens/fav_screen/view/widget/fav_screen_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../books_screen/view/books_screen.dart';
import '../../cart_screen/view/cart_screen.dart';
import '../../fav_screen/view/fav_screen.dart';
import '../../profile_screen/view/profile_screen.dart';
import '../view_model/cubit/cubit.dart';
import '../view_model/cubit/states.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);
  List<String> imagesSlider = [
    'assets/img/sale1.jpeg',
    'assets/img/sale2.jpeg',
    'assets/img/sale3.jpeg',
  ];
  List<Widget> _buildScreens(BuildContext context) {

    return [
      HomeScreenContent(),
      BooksScreen(),
      FavScreen(),
      CartScreen(),
      ProfileScreen()

    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems(BuildContext context) {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: "Home",
        activeColorPrimary: HexColor('#174068'),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.library_books),
        title: "Books",
        activeColorPrimary: HexColor('#174068'),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.favorite_border),
        title: "Favourite",
        activeColorPrimary: HexColor('#174068'),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.shopping_cart),
        title: "Cart",
        activeColorPrimary: HexColor('#174068'),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: "Profile",
        activeColorPrimary: HexColor('#174068'),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(context),
      items: _navBarsItems(context),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Change as needed
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0), // Adjust as needed
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6, // Change as needed
    );
  }
}

class HomeScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Your existing HomeScreen content goes here
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) async {
        // Your listener code here
      },
      builder: (context, state) {
        final sliders = HomeCubit.get(context).sliderModel?.data?.sliders;
        final categories = HomeCubit.get(context).categoryModel?.data?.categories; // Replace this with your actual categories data

        return Scaffold(
          appBar: AppBar(
            backgroundColor: HexColor("#174068"),
            title: Text('Home', style: TextStyle(color: Colors.white)),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 2.0,
                      viewportFraction: .9,
                      height: 150.0,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 2),
                      enlargeCenterPage: true,
                    ),
                    items: sliders?.map((slider) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                            ),
                            child: Image.network(
                              slider.image ?? '',
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      );
                    }).toList() ?? [],
                  ),
                ),
                SizedBox(height: 18),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: const Text(
                        'Best Seller',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 260.0, // Adjust the height as needed
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: HomeCubit.get(context).bestSellerModel?.data?.products?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      final bestSeller = HomeCubit.get(context).bestSellerModel?.data?.products?[index];
                      return GestureDetector(
                        onTap: () {
                          print('Selected best seller: ${bestSeller?.name}');
                        },
                        child: Container(
                          width: 150,
                          child: Column(
                            children: [
                              Expanded(
                                child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        image: DecorationImage(
                                          image: NetworkImage(bestSeller?.image ?? ''),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 5,
                                      right: 5,
                                      child: Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.red, // You can change the color
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          '${bestSeller?.discount}% OFF', // Replace 'discount' with your actual discount field
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                bestSeller?.name ?? 'Product Name not available',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                bestSeller?.category ?? 'Category not available',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '\$${bestSeller?.price ?? 'Price not available'}',
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                '\$${bestSeller?.priceAfterDiscount ?? 'Price not available'}',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 18),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: const Text(
                        'Categories',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 18),
                Container(
                  height: 130.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      final category = categories![index];
                      return GestureDetector(
                        onTap: () {
                          print('Selected category: ${category.name}');
                        },
                        child: Container(
                          width: 150,
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: Image.asset('assets/img/4735.jpg').image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            color: Colors.black.withOpacity(.4),
                            child: Center(
                              child: Text(
                                category.name ?? 'Category Name not available',
                                style: TextStyle(
                                  fontSize: 18.0.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 18),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: const Text(
                        'New Arrival',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 260.0, // Adjust the height as needed
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: HomeCubit.get(context).newArrivalModel?.data?.products?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      final newArrival = HomeCubit.get(context).newArrivalModel?.data?.products?[index];
                      return GestureDetector(
                        onTap: () {
                          print('Selected New Arrival: ${newArrival?.name}');
                        },
                        child: Container(
                          width: 150,
                          child: Column(
                            children: [
                              Expanded(
                                child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        image: DecorationImage(
                                          image: NetworkImage(newArrival?.image ?? ''),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 5,
                                      right: 5,
                                      child: Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.red, // You can change the color
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          '${newArrival?.discount}% OFF', // Replace 'discount' with your actual discount field
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                newArrival?.name ?? 'Product Name not available',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                newArrival?.category ?? 'Category not available',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '\$${newArrival?.price ?? 'Price not available'}',
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                '\$${newArrival?.priceAfterDiscount ?? 'Price not available'}',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 18),
              ],
            ),
          ),
        );
      },
    );
  }
}

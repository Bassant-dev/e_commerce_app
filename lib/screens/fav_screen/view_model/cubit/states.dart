import '../../../books_screen/model/books_details_model.dart';

abstract class FavStates {}
class FavInitialState extends FavStates{}
class FavoritesSuccessfully extends FavStates{}
class RemovedSuccessfully extends FavStates{}
class FavoritesState extends FavStates {
  final List<DataModel> favoriteProductIds;

  FavoritesState(this.favoriteProductIds);
}
class AddToFavLoadingState extends FavStates{}
class AddToFavSuccessState extends FavStates{}
class AddToFavFailState extends FavStates{}
class ShowFavLoadingState extends FavStates{}
class ShowFavSuccessState extends FavStates{}
class ShowFavFailState extends FavStates{}
class RemoveFavLoadingState extends FavStates{}
class RemoveFavSuccessState extends FavStates{}
class RemoveFavFailState extends FavStates{}
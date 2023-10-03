abstract class BooksStates {}
class BooksInitialState extends BooksStates{}
class GetBooksLoadingState extends BooksStates{}
class GetBooksSuccessState extends BooksStates{}
class GetBooksFailState extends BooksStates{}
class GetBooksDetailsLoadingState extends BooksStates{}
class GetBooksDetailsSuccessState extends BooksStates{}
class GetBooksDetailsFailState extends BooksStates{}

class AddToFavLoadingState extends BooksStates{}
class AddToFavSuccessState extends BooksStates{}
class AddToFavFailState extends BooksStates{}
class AddToCartLoadingState extends  BooksStates{}
class AddToCartSuccessState extends  BooksStates{}
class AddToCartFailState extends BooksStates{}
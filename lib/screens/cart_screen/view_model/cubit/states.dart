abstract class CartStates {}
class CartInitialState extends CartStates{}

class CartQuantityUpdateErrorState extends CartStates{}
class CartQuantityUpdatedState extends CartStates {
  final Map<String, int> productQuantities;

  CartQuantityUpdatedState(this.productQuantities);

  @override
  List<Object> get props => [productQuantities];
}

class ShowCartLoadingState extends CartStates{}
class ShowCartSuccessState extends CartStates{}
class ShowCartFailState extends CartStates{}

class RemoveCartLoadingState extends CartStates{}
class RemoveCartSuccessState extends CartStates{}
class RemoveCartFailState extends CartStates{}
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:groce1/utils/common.dart';
import '../Resp/cart_Resp.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartRespo prodResp = CartRespo();

  CartBloc() : super(CartInitialState()) {
    on<FetchCartEvent>(_cartMethod);

    // ====================ADD==========================
    on<CartItemAddEvent>(_cartAddMethod);

    // ! Update cart and Wishlist
    on<CartItemPutEvent>(_cartUpdateMethod);

    // ! Delete Cart and Wishlist
    on<CartItemDelEvent>(_cartDeleteMethod);
  }

  //  ! Cart Data Get

  void _cartMethod(FetchCartEvent event, Emitter emit) async {
    // print(event);
    emit(CartLoadingState());
    try {
      dynamic user = await prodResp.cartResp();
      // print('user data $user');
      if (user['success'] == 1) {
        emit(CartSuccessState(data: user));
      }
      // emit(CartInitialState());
    } catch (e) {
      emit(CartFailedState());
    }
  }

  //  ============ CART AND WISHLIST PRODUCT ADD ======================
  _cartAddMethod(CartItemAddEvent event, Emitter emit) async {
    // print(event);
    emit(CartLoadingState());
    try {
      var user = await prodResp.cartAddResp(
        product: event.prodNumber,
      );
      //  dynamic user = await prodResp.cartResp();

      if (user['success'] == 1) {
        emit(CartSuccessState(data: user));
        // }
        //else {
        // snackBar(event.context, user['msg'] ?? '');
        // emit(CartInitialState());
      } else {
        snackBar(event.context, user['msg'] ?? '');
        emit(CartInitialState());
      }
    } catch (e) {
      emit(CartFailedState());
    }
  }

  // !  ==============  END ADD METHOD ===============================

  // ! Update cart and WishlIst Item
  void _cartUpdateMethod(CartItemPutEvent event, Emitter emit) async {
    // print(event);
    emit(CartLoadingState());
    try {
      var user = await prodResp.cartUpdateResp(
        id: event.id,
        quantity: event.quantity,
      );
      // print('user data $user');
      if (user['success'] == 1) {
        emit(CartSuccessState(data: user));
      }
      // emit(CartWishInitialState());
    } catch (e) {
      emit(CartFailedState());
    }
  }

  // ! Delete for CART AND WISHLIST
  void _cartDeleteMethod(CartItemDelEvent event, Emitter emit) async {
    // print(event);
    emit(CartLoadingState());
    try {
      var user = await prodResp.cartDeleteResp(id: event.id);
      // print('user data $user');
      if (user['success'] == 1) {
        // snackBar(event.context, user['msg']);
        emit(CartSuccessState(data: user));
      } else {
        emit(CartInitialState());
      }
    } catch (e) {
      emit(CartFailedState());
    }
  }
}

// ! Event for Cart and WishList
abstract class CartEvent extends Equatable {
  CartEvent();

  @override
  List<Object> get props => [];
}

// ! FIRST EVENT FOR FETCHING / INITIALIZE THE EVENT
class FetchCartEvent extends CartEvent {
  final dynamic homeData;
  FetchCartEvent({this.homeData});
  @override
  List<Object> get props => [];
}

// 1 cart Item Add and Wishlist add
class CartItemAddEvent extends CartEvent {
  final String? prodNumber;
  final dynamic context;

  CartItemAddEvent({required this.prodNumber, this.context});
  @override
  List<Object> get props => [];
}

//  Cart Item Event
class CartItemPutEvent extends CartEvent {
  final String? id;
  final int? quantity;
  final dynamic context;
  CartItemPutEvent({required this.id, required this.quantity, this.context});
  @override
  List<Object> get props => [];
}

class CartItemDelEvent extends CartEvent {
  final String? id;
  final dynamic context;
  CartItemDelEvent({required this.id, this.context});
  @override
  List<Object> get props => [];
}

// / ! State in Cart
abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitialState extends CartState {}

class CartLoadingState extends CartState {}

class CartSuccessState extends CartState {
  final dynamic data;
  CartSuccessState({this.data});
}

class CartDelSuccessState extends CartState {
  final dynamic data;
  CartDelSuccessState({this.data});
}

class CartFailedState extends CartState {
  final String? message;
  CartFailedState({this.message});
}

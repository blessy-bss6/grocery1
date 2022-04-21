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
      // print('user data $user');
      if (user['success'] == 1) {
        emit(CartSuccessState());
        // }
        //else {
        snackBar(event.context, user['msg'] ?? '');
        // emit(CartInitialState());
      }
      snackBar(event.context, user['msg'] ?? '');
      emit(CartInitialState());
    } catch (e) {
      emit(CartFailedState());
    }
  }

  // !  ==============  END ADD METHOD ===============================

  // ! Update cart and WishlIst Item
  void _cartUpdateMethod(CartItemPutEvent event, Emitter emit) async {
    print(event);
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

class CartFailedState extends CartState {
  final String? message;
  CartFailedState({this.message});
}

// class CartWishListBloc extends Bloc<CartWishListEvent, CartWishListState> {
//   CartWishListRespo prodResp = CartWishListRespo();

//   CartWishListBloc() : super(CartWishInitialState()) {
//     on<FetchCartEvent>(_cartMethod);
//     on<FetchWishListEvent>(_wishlistMethod);

//     // ====================ADD==========================
//     on<CartItemAddEvent>(_cartAddMethod);
//     on<WishListItemAddEvent>(_wishlistAddMethod);

//     // ! Update cart and Wishlist
//     on<CartItemPutEvent>(_cartUpdateMethod);
//     on<WishlistItemPutEvent>(_wishlistUpdateMethod);

//     // ! Delete Cart and Wishlist
//     on<CartItemDelEvent>(_cartDeleteMethod);
//     on<WishlistItemDelEvent>(_wishlistDeleteMethod);
//   }

//   //  ! Cart Data Get

//   void _cartMethod(FetchCartEvent event, Emitter emit) async {
//     // print(event);
//     emit(CartWishLoadingState());
//     try {
//       dynamic user = await prodResp.cartResp();
//       // print('user data $user');
//       if (user['success'] == 1) {
//         emit(CartWishSuccessState(data: user));
//       }
//       // emit(CartWishInitialState());
//     } catch (e) {
//       emit(CartWishFailedState());
//     }
//   }

//   void _wishlistMethod(FetchWishListEvent event, Emitter emit) async {
//     // print(event);
//     emit(CartWishLoadingState());
//     try {
//       var user = await prodResp.wishlistResp();
//       // print('user data $user');
//       if (user['success'] == 1) {
//         emit(CartWishSuccessState());
//       }
//       emit(CartWishInitialState());
//     } catch (e) {
//       emit(CartWishFailedState());
//     }
//   }

//   //  ============ CART AND WISHLIST PRODUCT ADD ======================
//   _cartAddMethod(CartItemAddEvent event, Emitter emit) async {
//     // print(event);
//     emit(CartWishLoadingState());
//     try {
//       var user = await prodResp.cartAddResp(
//         product: event.prodNumber,
//       );
//       // print('user data $user');
//       if (user['success'] == 1) {
//         emit(CartWishSuccessState());
//       } else {
//         snackBar(event.context, user['msg']);
//         emit(CartWishInitialState());
//       }
//       // emit(CartWishInitialState());
//     } catch (e) {
//       emit(CartWishFailedState());
//     }
//   }

//   _wishlistAddMethod(WishListItemAddEvent event, Emitter emit) async {
//     // print(event);
//     emit(CartWishLoadingState());
//     try {
//       var user = await prodResp.wishlistAddResp();
//       // print('user data $user');
//       if (user['success'] == 1) {
//         emit(CartWishSuccessState());
//       }
//       emit(CartWishInitialState());
//     } catch (e) {
//       emit(CartWishFailedState());
//     }
//   }

//   // !  ==============  END ADD METHOD ===============================

//   // ! Update cart and WishlIst Item
//   void _cartUpdateMethod(CartItemPutEvent event, Emitter emit) async {
//     print(event);
//     emit(CartWishLoadingState());
//     try {
//       var user = await prodResp.cartUpdateResp(
//         id: event.id,
//         quantity: event.quantity,
//       );
//       print('user data $user');
//       if (user['success'] == 1) {
//         emit(CartWishSuccessState(data: user));
//       }
//       // emit(CartWishInitialState());
//     } catch (e) {
//       emit(CartWishFailedState());
//     }
//   }

//   void _wishlistUpdateMethod(WishlistItemPutEvent event, Emitter emit) async {
//     // print(event);
//     emit(CartWishLoadingState());
//     try {
//       var user = await prodResp.wishlistUpdateResp();
//       // print('user data $user');
//       if (user['success'] == 1) {
//         emit(CartWishSuccessState());
//       }
//       emit(CartWishInitialState());
//     } catch (e) {
//       emit(CartWishFailedState());
//     }
//   }

//   // ! Delete for CART AND WISHLIST
//   void _cartDeleteMethod(CartItemDelEvent event, Emitter emit) async {
//     // print(event);
//     emit(CartWishLoadingState());
//     try {
//       var user = await prodResp.cartDeleteResp();
//       // print('user data $user');
//       if (user['success'] == 1) {
//         emit(CartWishSuccessState());
//       }
//       // emit(CartWishInitialState());
//     } catch (e) {
//       emit(CartWishFailedState());
//     }
//   }

//   void _wishlistDeleteMethod(WishlistItemDelEvent event, Emitter emit) async {
//     // print(event);
//     emit(CartWishLoadingState());
//     try {
//       var user = await prodResp.wishlistDeleteResp();
//       // print('user data $user');
//       if (user['success'] == 1) {
//         emit(CartWishSuccessState());
//       }
//     } catch (e) {
//       emit(CartWishFailedState());
//     }
//   }
// }

// // ! Event for Cart and WishList
// abstract class CartWishListEvent extends Equatable {
//   CartWishListEvent();

//   @override
//   List<Object> get props => [];
// }

// // ! FIRST EVENT FOR FETCHING / INITIALIZE THE EVENT
// class FetchCartEvent extends CartWishListEvent {
//   final dynamic homeData;
//   FetchCartEvent({this.homeData});
//   @override
//   List<Object> get props => [];
// }

// class FetchWishListEvent extends CartWishListEvent {
//   final dynamic prodData;
//   FetchWishListEvent({this.prodData});
//   @override
//   List<Object> get props => [];
// }

// // 1 cart Item Add and Wishlist add
// class CartItemAddEvent extends CartWishListEvent {
//   final String? prodNumber;
//   final dynamic context;

//   CartItemAddEvent({required this.prodNumber, this.context});
//   @override
//   List<Object> get props => [];
// }

// class WishListItemAddEvent extends CartWishListEvent {
//   final String? prodNumber;
//   final dynamic context;
//   WishListItemAddEvent({required this.prodNumber, this.context});
//   @override
//   List<Object> get props => [];
// }

// //  Cart Item And Wishlist List Event
// class CartItemPutEvent extends CartWishListEvent {
//   final String? id;
//   final int? quantity;
//   final dynamic context;
//   CartItemPutEvent({required this.id, required this.quantity, this.context});
//   @override
//   List<Object> get props => [];
// }

// class WishlistItemPutEvent extends CartWishListEvent {
//   final String? id;
//   final int? quantity;
//   final dynamic context;
//   WishlistItemPutEvent(
//       {required this.id, required this.quantity, this.context});
//   @override
//   List<Object> get props => [];
// }

// class CartItemDelEvent extends CartWishListEvent {
//   final String? id;
//   CartItemDelEvent({required this.id});
//   @override
//   List<Object> get props => [];
// }

// class WishlistItemDelEvent extends CartWishListEvent {
//   final String? id;
//   WishlistItemDelEvent({this.id});
//   @override
//   List<Object> get props => [];
// }

// // / ! State in Prod Home
// abstract class CartWishListState extends Equatable {
//   const CartWishListState();

//   @override
//   List<Object> get props => [];
// }

// class CartWishInitialState extends CartWishListState {}

// class CartWishLoadingState extends CartWishListState {}

// class CartWishSuccessState extends CartWishListState {
//   final dynamic data;
//   CartWishSuccessState({this.data});
// }

// class CartWishFailedState extends CartWishListState {
//   final String? message;
//   CartWishFailedState({this.message});
// }

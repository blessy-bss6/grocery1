import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:groce1/Screen/dashBoard.dart';
import 'package:groce1/utils/common.dart';

import '../Resp/wishList_Resp.dart';

class WishListBloc extends Bloc<WishListEvent, WishListState> {
  WishListRespo prodResp = WishListRespo();

  WishListBloc() : super(WishListInitialState()) {
    on<FetchWishListEvent>(_wishListMethod);

    // ====================ADD==========================
    on<WishListItemAddEvent>(_wishListAddMethod);

    // ! Update WishList and Wishlist
    // on<WishListItemPutEvent>(_wishListUpdateMethod);

    // ! Delete WishList and Wishlist
    on<WishListItemDelEvent>(_wishListDeleteMethod);
  }

  //  ! WishList Data Get

  void _wishListMethod(FetchWishListEvent event, Emitter emit) async {
    // print(event);
    emit(WishListLoadingState());
    try {
      dynamic user = await prodResp.wishListResp();
      // print('user data $user');
      if (user['success'] == 1) {
        emit(WishListSuccessState(
            data: user['data'], pricedata: user['priceData']));
      }
      // emit(WishListInitialState());
    } catch (e) {
      emit(WishListFailedState());
    }
  }

  //  ============ WishList AND WISHLIST PRODUCT ADD ======================
  _wishListAddMethod(WishListItemAddEvent event, Emitter emit) async {
    // print(event);
    emit(WishListLoadingState());
    try {
      var user = await prodResp.wishListAddResp(
        product: event.prodNumber,
      );
      // print('user data $user');
      if (user['success'] == 1) {
        emit(WishListSuccessState());
        snackBar(event.context, user['msg'] ?? '');
      } else {
        snackBar(event.context, user['msg'] ?? '');
        emit(WishListInitialState());
      }
    } catch (e) {
      emit(WishListFailedState());
    }
  }

  // !  ==============  END ADD METHOD ===============================

  // ! Update WishList and WishlIst Item
  // void _wishListUpdateMethod(WishListItemPutEvent event, Emitter emit) async {
  //   print(event);
  //   emit(WishListLoadingState());
  //   try {
  //     var user = await prodResp.WishListUpdateResp(
  //       id: event.id,
  //       quantity: event.quantity,
  //     );
  //     // print('user data $user');
  //     if (user['success'] == 1) {
  //       emit(WishListSuccessState(data: user));
  //     }
  //     // emit(WishListWishInitialState());
  //   } catch (e) {
  //     emit(WishListFailedState());
  //   }
  // }

  // ! Delete for WishList AND WISHLIST
  _wishListDeleteMethod(WishListItemDelEvent event, Emitter emit) async {
    // print(event);
    emit(WishListLoadingState());
    try {
      var user = await prodResp.wishListDeleteResp(id: event.id,context: event.context);
      // print('user data $user');
      if (user['success'] == 1) {
        
        emit(WishListSuccessState(data: user['data']));
          // snackBar(event.context, user['msg'] ?? '');
      } 
      else {
        // snackBar(event.context, user['msg'] ??'');
        emit(WishListInitialState());
      }
    } catch (e) {
      print(e.toString());
      emit(WishListFailedState());
    }
  }
}

// ! Event for WishList and WishList
abstract class WishListEvent extends Equatable {
  WishListEvent();

  @override
  List<Object> get props => [];
}

// ! FIRST EVENT FOR FETCHING / INITIALIZE THE EVENT
class FetchWishListEvent extends WishListEvent {
  final dynamic homeData;
  FetchWishListEvent({this.homeData});
  @override
  List<Object> get props => [];
}

// 1 WishList Item Add and Wishlist add
class WishListItemAddEvent extends WishListEvent {
  final String? prodNumber;
  final dynamic context;

  WishListItemAddEvent({required this.prodNumber, this.context});
  @override
  List<Object> get props => [];
}

//  WishList Item Event
class WishListItemPutEvent extends WishListEvent {
  final String? id;
  final int? quantity;
  final dynamic context;
  WishListItemPutEvent(
      {required this.id, required this.quantity, this.context});
  @override
  List<Object> get props => [];
}

class WishListItemDelEvent extends WishListEvent {
  final String? id;
  final dynamic context;
  WishListItemDelEvent({required this.id, this.context});
  @override
  List<Object> get props => [];
}

// / ! State in WishList
abstract class WishListState extends Equatable {
  const WishListState();

  @override
  List<Object> get props => [];
}

class WishListInitialState extends WishListState {}

class WishListLoadingState extends WishListState {}

class WishListDeleteState extends WishListState {}

class WishListSuccessState extends WishListState {
  final dynamic data;
  final dynamic pricedata;
  WishListSuccessState({this.data, this.pricedata});
}

class WishListFailedState extends WishListState {
  final String? message;
  WishListFailedState({this.message});
}

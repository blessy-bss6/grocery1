import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../Resp/wishList_Resp.dart';

class WishListBloc extends Bloc<WishListEvent, WishListState> {
  WishListRespo prodResp = WishListRespo();

  WishListBloc() : super(WishListInitialState()) {
    on<FetchWishListEvent>(_wishlistMethod);

    on<WishListItemAddEvent>(_wishlistAddMethod);

    on<WishlistItemPutEvent>(_wishlistUpdateMethod);

    on<WishlistItemDelEvent>(_wishlistDeleteMethod);
  }

  void _wishlistMethod(FetchWishListEvent event, Emitter emit) async {
    // print(event);
    emit(WishListLoadingState());
    try {
      var user = await prodResp.wishlistResp();
      // print('user data $user');
      if (user['success'] == 1) {
        emit(WishListSuccessState());
      }
      emit(WishListInitialState());
    } catch (e) {
      emit(WishListFailedState());
    }
  }

  _wishlistAddMethod(WishListItemAddEvent event, Emitter emit) async {
    // print(event);
    emit(WishListLoadingState());
    try {
      var user = await prodResp.wishlistAddResp();
      // print('user data $user');
      if (user['success'] == 1) {
        emit(WishListSuccessState());
      }
      emit(WishListInitialState());
    } catch (e) {
      emit(WishListFailedState());
    }
  }

  // !  ==============  END ADD METHOD ===============================

  void _wishlistUpdateMethod(WishlistItemPutEvent event, Emitter emit) async {
    // print(event);
    emit(WishListLoadingState());
    try {
      var user = await prodResp.wishlistUpdateResp();
      // print('user data $user');
      if (user['success'] == 1) {
        emit(WishListSuccessState());
      }
      emit(WishListInitialState());
    } catch (e) {
      emit(WishListFailedState());
    }
  }

  void _wishlistDeleteMethod(WishlistItemDelEvent event, Emitter emit) async {
    // print(event);
    emit(WishListLoadingState());
    try {
      var user = await prodResp.wishlistDeleteResp();
      // print('user data $user');
      if (user['success'] == 1) {
        emit(WishListSuccessState());
      }
    } catch (e) {
      emit(WishListFailedState());
    }
  }
}

// ! Event for Cart and WishList
abstract class WishListEvent extends Equatable {
  WishListEvent();

  @override
  List<Object> get props => [];
}

class FetchWishListEvent extends WishListEvent {
  FetchWishListEvent();
  @override
  List<Object> get props => [];
}

class WishListItemAddEvent extends WishListEvent {
  final String? prodNumber;
  final dynamic context;
  WishListItemAddEvent({required this.prodNumber, this.context});
  @override
  List<Object> get props => [];
}

class WishlistItemPutEvent extends WishListEvent {
  final String? id;
  final int? quantity;
  final dynamic context;
  WishlistItemPutEvent(
      {required this.id, required this.quantity, this.context});
  @override
  List<Object> get props => [];
}

class WishlistItemDelEvent extends WishListEvent {
  final String? id;
  final dynamic context;
  WishlistItemDelEvent({this.id, this.context});
  @override
  List<Object> get props => [];
}

// / ! State in Prod Home
abstract class WishListState extends Equatable {
  const WishListState();

  @override
  List<Object> get props => [];
}

class WishListInitialState extends WishListState {}

class WishListLoadingState extends WishListState {}

class WishListSuccessState extends WishListState {
  final dynamic data;
  WishListSuccessState({this.data});
}

class WishListFailedState extends WishListState {
  final String? message;
  WishListFailedState({this.message});
}

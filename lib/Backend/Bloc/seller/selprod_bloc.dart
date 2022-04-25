import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:groce1/Screen/dashBoard.dart';
import 'package:groce1/sellerPart/selProdListScr.dart';
import 'package:groce1/utils/common.dart';

import '../../Resp/seller/selprod_Resp.dart';

class SelProductBloc extends Bloc<SelProductEvent, SelProductState> {
  SelProdRespo prodResp = SelProdRespo();

  SelProductBloc() : super(SelProdInitialState()) {
    on<FetchSelProductEvent>(_selProdMethod);

    // ====================ADD==========================
    on<SelProdAddEvent>(_selProdAddMethod);

    // ! Update selProd and Wishlist
    on<SelProdPutEvent>(_selProdUpdateMethod);

    // ! Delete selProd and Wishlist
    on<SelProdDelEvent>(_selProdDeleteMethod);
  }

  //  ! selProd Data Get

  void _selProdMethod(FetchSelProductEvent event, Emitter emit) async {
    print(event);
    emit(SelProdLoadingState());
    try {
      dynamic user = await prodResp.selProdResp();
      // print('user data $user');
      if (user['success'] == 1) {
        emit(SelProdSuccessState(data: user['data']));
      }
      // emit(SelProdInitialState());
    } catch (e) {
      emit(SelProdFailedState());
    }
  }

  //  ============ selProd AND WISHLIST PRODUCT ADD ======================
  _selProdAddMethod(SelProdAddEvent event, Emitter emit) async {
    // print(event);
    emit(SelProdLoadingState());
    try {
      var user = await prodResp.selProdAddResp(
        product: event.prodItemModel,
      );

      if (user['success'] == 1) {
        emit(SelProdSuccessState());
        navigationPush(
            event.context,
            SellerNavigationBar(
              currentTab: 2,
            ));
        snackBar(event.context, user['msg'] ?? '');
      }
      emit(SelProdInitialState());
      snackBar(event.context, user['msg'] ?? '');
      emit(SelProdInitialState());
    } catch (e) {
      emit(SelProdFailedState());
    }
  }

  // !  ==============  END ADD METHOD ===============================

  // ! Update selProd and WishlIst Item
  void _selProdUpdateMethod(SelProdPutEvent event, Emitter emit) async {
    print(event);
    emit(SelProdLoadingState());
    try {
      var user = await prodResp.selProdUpdateResp(
        product: event.prodEditModel,
      );
      // print('user data $user');
      if (user['success'] == 1) {
        emit(SelProdSuccessState(data: user));
      }
      // emit(selProdWishInitialState());
    } catch (e) {
      emit(SelProdFailedState());
    }
  }

  // ! Delete for selProd AND WISHLIST
  void _selProdDeleteMethod(SelProdDelEvent event, Emitter emit) async {
    // print(event);
    emit(SelProdLoadingState());
    try {
      var user = await prodResp.selProdDeleteResp(id: event.id);
      // print('user data $user');
      if (user['success'] == 1) {
        // snackBar(event.context, user['msg']);
        emit(SelProdSuccessState(data: user['data']));
      } else {
        emit(SelProdInitialState());
      }
    } catch (e) {
      emit(SelProdFailedState());
    }
  }
}

// ! Event for selProd and WishList
abstract class SelProductEvent extends Equatable {
  SelProductEvent();

  @override
  List<Object> get props => [];
}

// ! FIRST EVENT FOR FETCHING / INITIALIZE THE EVENT
class FetchSelProductEvent extends SelProductEvent {
  final dynamic homeData;
  FetchSelProductEvent({this.homeData});
  @override
  List<Object> get props => [];
}

// 1 selProd Item Add and Wishlist add
class SelProdAddEvent extends SelProductEvent {
  // final String? title, description;
  // dynamic pic, pic1, pic2, pic3;
  // final int? stock;
  // final double ? salesPrice, discountPrice;
  final dynamic context;
  FormData? prodItemModel;

  SelProdAddEvent({this.prodItemModel, this.context});
  @override
  List<Object> get props => [];
}

//  selProd Item Event
class SelProdPutEvent extends SelProductEvent {
  FormData? prodEditModel;
  final dynamic context;
  SelProdPutEvent({required this.prodEditModel, this.context});
  @override
  List<Object> get props => [];
}

class SelProdDelEvent extends SelProductEvent {
  final String? id;
  final dynamic context;
  SelProdDelEvent({required this.id, this.context});
  @override
  List<Object> get props => [];
}

// / ! State in selProd
abstract class SelProductState extends Equatable {
  const SelProductState();

  @override
  List<Object> get props => [];
}

class SelProdInitialState extends SelProductState {}

class SelProdLoadingState extends SelProductState {}

class SelProdSuccessState extends SelProductState {
  final dynamic data;
  SelProdSuccessState({this.data});
}

class SelProdFailedState extends SelProductState {
  final String? message;
  SelProdFailedState({this.message});
}

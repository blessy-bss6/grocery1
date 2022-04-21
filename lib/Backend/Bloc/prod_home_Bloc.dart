import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../Resp/cart_Resp.dart';
import '../Resp/prod_home_Resp.dart';

class ProdHomeBloc extends Bloc<ProdHomeEvent, ProdHomeState> {
  ProdHomeRespo prodResp = ProdHomeRespo();
  CartRespo cartResp = CartRespo();

  

  ProdHomeBloc() : super(ProdInitialState()) {
    on<FetchHomeEvent>(_homeMethod);
    on<FetchProdEvent>(_prodMethod);
  }
  void _homeMethod(FetchHomeEvent event, Emitter emit) async {
    // print(event);
    emit(ProdLoadingState());
    try {
      var user = await prodResp.homeResp();

      if (user != false) {
        emit(HomeSuccessState());
      }
      emit(ProdInitialState());
    } catch (e) {
      emit(ProdFailedState());
    }
  }

  void _prodMethod(FetchProdEvent event, Emitter emit) async {
    // print(event);
    emit(ProdLoadingState());
    try {
      var user = await prodResp.prodResp();
      // var cart = await cartResp.cartResp();

      if (user != false) {
        // print(user);
        emit(ProdSuccessState(data: user,));
      } else {
        emit(ProdInitialState());
      }
    } catch (e) {
      emit(ProdFailedState());
    }
  }
}

abstract class ProdHomeEvent extends Equatable {
  ProdHomeEvent();

  @override
  List<Object> get props => [];
}

// ! FIRST EVENT FOR FETCHING / INITIALIZE THE EVENT
class FetchHomeEvent extends ProdHomeEvent {
  final dynamic homeData;
  FetchHomeEvent({this.homeData});
  @override
  List<Object> get props => [];
}

class FetchProdEvent extends ProdHomeEvent {
  final dynamic prodData;
  FetchProdEvent({this.prodData});
  @override
  List<Object> get props => [];
}

// ! State in Prod Home
abstract class ProdHomeState extends Equatable {
  const ProdHomeState();

  @override
  List<Object> get props => [];
}

class ProdInitialState extends ProdHomeState {}

class ProdLoadingState extends ProdHomeState {}

class ProdSuccessState extends ProdHomeState {
  final dynamic data;
   final dynamic cartData;
  ProdSuccessState({this.data, this.cartData});
}

class HomeSuccessState extends ProdHomeState {
  final dynamic data;
  HomeSuccessState({this.data});
}

class ProdFailedState extends ProdHomeState {
  final String? message;
  ProdFailedState({this.message});
}

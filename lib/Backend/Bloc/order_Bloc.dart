import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import '../Resp/order_Resp.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderRespo orderRes = OrderRespo();

  OrderBloc() : super(OrderInitialState()) {
    on<FetchOrderEvent>(_orderMethod);

    // ====================ADD==========================
    on<OrderItemAddEvent>(_orderAddMethod);

    // ! Update Order and Wishlist
    // on<OrderItemPutEvent>(_OrderUpdateMethod);

    // ! Delete Order and Wishlist
    on<OrderItemDelEvent>(_orderDeleteMethod);
  }

  //  ! Order Data Get

   _orderMethod(FetchOrderEvent event, Emitter emit) async {
    // print(event);
    emit(OrderLoadingState());
    try {
      dynamic user = await orderRes.orderResp();
      // print('user data $user');
      if (user['success'] == 1) {
        emit(OrderSuccessState(data: user));
      }else{
     emit(OrderInitialState());
      }
     
    } catch (e) {
      emit(OrderFailedState());
    }
  }

  //  ============ Order AND WISHLIST PRODUCT ADD ======================
  _orderAddMethod(OrderItemAddEvent event, Emitter emit) async {
    // print(event);
    emit(OrderLoadingState());
    try {
      var user = await orderRes.orderAddResp(
        orderData: event.orderData,
      );
      // print('user data $user');
      if (user['success'] == 1) {
        emit(OrderAddSuccessState());
       
      } else {
        // snackBar(event.context, user['msg'] ?? '');
        emit(OrderInitialState());
      }
    } catch (e) {
      emit(OrderFailedState());
    }
  }

  // !  ==============  END ADD METHOD ===============================

  // ! Update Order and WishlIst Item
  // void _OrderUpdateMethod(OrderItemPutEvent event, Emitter emit) async {
  //   print(event);
  //   emit(OrderLoadingState());
  //   try {
  //     var user = await orderResp.orderUpdateResp(
  //       id: event.id,
  //       quantity: event.quantity,
  //     );
  //     // print('user data $user');
  //     if (user['success'] == 1) {
  //       emit(OrderSuccessState(data: user));
  //     }
  //     // emit(OrderWishInitialState());
  //   } catch (e) {
  //     emit(OrderFailedState());
  //   }
  // }

  // ! Delete for Order AND WISHLIST
  void _orderDeleteMethod(OrderItemDelEvent event, Emitter emit) async {
    // print(event);
    emit(OrderLoadingState());
    try {
      var usr = await orderRes.orderDeleteResp(id: event.id);
       dynamic user = await orderRes.orderResp();
      // print('user data $user');
      if (user['success'] == 1) {
        // snackBar(event.context, user['msg']);
        emit(OrderSuccessState(data: user));
      } else {
        emit(OrderInitialState());
      }
    } catch (e) {
      emit(OrderFailedState());
    }
  }
}

// ! Event for Order and WishList
abstract class OrderEvent extends Equatable {
  OrderEvent();

  @override
  List<Object> get props => [];
}

// ! FIRST EVENT FOR FETCHING / INITIALIZE THE EVENT
class FetchOrderEvent extends OrderEvent {
  final dynamic homeData;
  FetchOrderEvent({this.homeData});
  @override
  List<Object> get props => [];
}

// 1 Order Item Add and Wishlist add
class OrderItemAddEvent extends OrderEvent {
  final dynamic orderData;
  final dynamic context;

  OrderItemAddEvent({required this.orderData, this.context});
  @override
  List<Object> get props => [];
}

//  Order Item Event
// class OrderItemPutEvent extends OrderEvent {
//   final String? id;
//   final int? quantity;
//   final dynamic context;
//   OrderItemPutEvent({required this.id, required this.quantity, this.context});
//   @override
//   List<Object> get props => [];
// }

class OrderItemDelEvent extends OrderEvent {
  final String? id;
  final dynamic context;
  OrderItemDelEvent({required this.id, this.context});
  @override
  List<Object> get props => [];
}

// / ! State in Order
abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitialState extends OrderState {}

class OrderLoadingState extends OrderState {}

class OrderSuccessState extends OrderState {
  final dynamic data;
  OrderSuccessState({this.data});
}

class OrderAddSuccessState extends OrderState {
  final dynamic data;
  OrderAddSuccessState({this.data});
}

class OrderFailedState extends OrderState {
  final String? message;
  OrderFailedState({this.message});
}

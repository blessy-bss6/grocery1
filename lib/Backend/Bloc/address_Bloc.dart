import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:groce1/utils/common.dart';
import '../Resp/address_Resp.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressRespo prodResp = AddressRespo();

  AddressBloc() : super(AddressInitialState()) {
    on<FetchAddressEvent>(_addressMethod);

    // ====================ADD==========================
    on<AddressItemAddEvent>(_addressAddMethod);

    // ! Update Address and Wishlist
    on<AddressItemPutEvent>(_addressUpdateMethod);

    // ! Delete Address and Wishlist
    on<AddressItemDelEvent>(_addressDeleteMethod);
  }

  //  ! Address Data Get

  void _addressMethod(FetchAddressEvent event, Emitter emit) async {
    print(event);
    emit(AddressLoadingState());
    try {
      dynamic user = await prodResp.addressResp();
      // print('user data $user');
      if (user['success'] == 1) {
        emit(AddressSuccessState(data: user));
      }

      // emit(AddressInitialState());
    } catch (e) {
      emit(AddressFailedState());
    }
  }

  //  ============ Address AND WISHLIST PRODUCT ADD ======================
  _addressAddMethod(AddressItemAddEvent event, Emitter emit) async {
    // print(event);
    emit(AddressLoadingState());
    try {
      var user = await prodResp.addressAddResp(
        addressItem: event.addressItem,
      );
      // print('user data $user');
      if (user['success'] == 1) {
        emit(AddressAddSuccessState());

        // snackBar(event.context, user['msg'] ?? '');

      } else {
        //  snackBar(event.context, user['msg'] ?? '');
        emit(AddressInitialState());
      }
    } catch (e) {
      emit(AddressFailedState());
    }
  }

  // !  ==============  END ADD METHOD ===============================

  // ! Update Address and WishlIst Item
  void _addressUpdateMethod(AddressItemPutEvent event, Emitter emit) async {
    print(event);
    emit(AddressLoadingState());
    try {
      var user =
          await prodResp.addressUpdateResp(addressItem: event.addressItem);
      // print('user data $user');
      if (user['success'] == 1) {
        emit(AddressAddSuccessState(data: user));
      } else {
        emit(AddressInitialState());
      }
    } catch (e) {
      emit(AddressFailedState());
    }
  }

  // ! Delete for Address AND WISHLIST
  void _addressDeleteMethod(AddressItemDelEvent event, Emitter emit) async {
    // print(event);
    emit(AddressLoadingState());
    try {
      var usr = await prodResp.addressDeleteResp(id: event.id);

      dynamic user = await prodResp.addressResp();
      // print('user data $user');
      if (user['success'] == 1) {
        // snackBar(event.context, user['msg']);
        emit(AddressSuccessState(data: user));
      } else {
        emit(AddressInitialState());
      }
    } catch (e) {
      emit(AddressFailedState());
    }
  }
}

// ! Event for Address and WishList
abstract class AddressEvent extends Equatable {
  AddressEvent();

  @override
  List<Object> get props => [];
}

// ! FIRST EVENT FOR FETCHING / INITIALIZE THE EVENT
class FetchAddressEvent extends AddressEvent {
  FetchAddressEvent();
  @override
  List<Object> get props => [];
}

// 1 Address Item Add and Wishlist add
class AddressItemAddEvent extends AddressEvent {
  final dynamic addressItem;
  final dynamic context;

  AddressItemAddEvent({this.addressItem, this.context});
  @override
  List<Object> get props => [];
}

//  Address Item Event
class AddressItemPutEvent extends AddressEvent {
  final String? id;
  final dynamic addressItem;
  final dynamic context;
  AddressItemPutEvent({this.id, this.addressItem, this.context});
  @override
  List<Object> get props => [];
}

class AddressItemDelEvent extends AddressEvent {
  final String? id;
  final dynamic context;
  AddressItemDelEvent({required this.id, this.context});
  @override
  List<Object> get props => [];
}

// / ! State in Address
abstract class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object> get props => [];
}

class AddressInitialState extends AddressState {}

class AddressLoadingState extends AddressState {}

class AddressSuccessState extends AddressState {
  final dynamic data;
  AddressSuccessState({this.data});
}

class AddressAddSuccessState extends AddressState {
  final dynamic data;
  AddressAddSuccessState({this.data});
}

class AddressFailedState extends AddressState {
  final String? message;
  AddressFailedState({this.message});
}

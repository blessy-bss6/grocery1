import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:groce1/Screen/dashBoard.dart';
import 'package:groce1/Screen/home.dart';
import 'package:groce1/utils/common.dart';
import '../Resp/reg_login_resp.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  RegLoginResp userRespository = RegLoginResp();

  AuthBloc() : super(AuthInitialState()) {
    on<LoginBtnEvent>(_loginMethod);
    on<SignUpBtnEvent>(_registerMethod);
  }

  void _loginMethod(LoginBtnEvent event, Emitter emit) async {
    // print(event);
    emit(AuthLoadingState());
    try {
      var user = await userRespository.loginResp(
          phone: event.phone,
          isSeller: event.isSeller,
          password: event.password,
          context: event.context);
      // print('user data $user');
      if (user['success'] == 1) {
        if (user['isIdType'] == true) {
          navigationPushReplacement(
              event.context, SellerNavigationBar(currentTab: 0));
        } else {
          navigationPushReplacement(
              event.context, UserNavigationBar(currentTab: 0));
        }
        

        emit(AuthSuccessState());
      }

      if (user['success'] == 0) {
        snackBar(event.context, user['msg']);
        
        emit(AuthInitialState());
      }

      emit(AuthInitialState());
    } catch (e) {
      emit(AuthFailedState());
    }
  }

  // ! SignUp
  void _registerMethod(SignUpBtnEvent event, Emitter emit) async {
    // print(event);
    emit(AuthLoadingState());
    try {
      var user = await userRespository.registerResp(
          phone: event.phone,
          fullname: event.fullname,
          email: event.email,
          password: event.password,
          isSeller: event.isSeller,
          context: event.context);
      // print('user data $user');
      if (user['success'] == 1) {
        if (user['isIdType'] == true) {
          navigationPushReplacement(
              event.context, SellerNavigationBar(currentTab: 0));
        } else {
          navigationPushReplacement(
              event.context, UserNavigationBar(currentTab: 0));
        }

        emit(AuthSuccessState());
      }
      if (user['success'] == 0) {
        snackBar(event.context, user['msg']);
        
        emit(AuthInitialState());
      }
      // emit(AuthInitialState());
    } catch (e) {
      emit(AuthFailedState());
    }
  }
}

// ! Event For Signup
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignUpBtnEvent extends AuthEvent {
  final String? email, password, fullname, phone;
  final bool? isSeller;
  dynamic context;
  SignUpBtnEvent(
      {this.email,
      this.fullname,
      this.phone,
      this.password,
      this.context,
      this.isSeller = false});
}

class LoginBtnEvent extends AuthEvent {
  final String? phone, password;
  final bool? isSeller;
  dynamic context;
  LoginBtnEvent(
      {this.phone, this.password, this.isSeller = false, this.context});
}

// ! 3. STATE FOR Auth
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {}

class AuthFailedState extends AuthState {
  final String? message;
  AuthFailedState({this.message});
}

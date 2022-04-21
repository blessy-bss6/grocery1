import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groce1/utils/common.dart';

import '../Resp/otpResp.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpResp otpRespository = OtpResp();

  OtpBloc() : super(OtpInitialState()) {
    on<SendOtpBtnEvent>(_sendOtpMethod);
    on<VerifyOtpBtnEvent>(_verifyOtpMethod);
  }

  void _sendOtpMethod(SendOtpBtnEvent event, Emitter emit) async {
    // print(event);
    // print('event phone ${event.phone}');
    emit(OtpLoadingState());
    // print('state $state');
    try {
      var user = await otpRespository.sendOtpResp(phone: event.phone);

      // print('user data $user');
      if (user['success'] == 1) {
        snackBar(event.context, user['msg']);
        emit(OtpSuccessState());
      }
      if (user['success'] == 0) {
        snackBar(event.context, user['msg']);
        emit(OtpInitialState());
      }
      emit(OtpInitialState());
    } catch (e) {
      emit(OtpFailedState());
    }
  }

  void _verifyOtpMethod(VerifyOtpBtnEvent event, Emitter emit) async {
    // print(event);
    emit(OtpLoadingState());
    try {
      var user = await otpRespository.verifyOtpResp(
        phone: event.phone,
        otp: event.otp,
      );

      if (user['success'] == 1) {
        snackBar(event.context, user['msg']);
        emit(OtpSuccess2State());
      }
      if (user['success'] == 0) {
        snackBar(event.context, user['msg']);
        emit(OtpInitialState());
      }
      emit(OtpInitialState());
    } catch (e) {
      emit(OtpFailedState());
    }
  }

  // ! SignUp

}

// ! Event For Signup
abstract class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object> get props => [];
}

// ! Send Otp and verify Otp Event
class SendOtpBtnEvent extends OtpEvent {
  final String? phone;
  dynamic context;
  SendOtpBtnEvent({this.phone, this.context});
}

class VerifyOtpBtnEvent extends OtpEvent {
  final String? otp, phone;
  dynamic context;
  VerifyOtpBtnEvent({this.otp, this.phone, this.context});
}

// ! 3. STATE FOR REGISTER
abstract class OtpState extends Equatable {
  const OtpState();

  @override
  List<Object> get props => [];
}

class OtpInitialState extends OtpState {}

class OtpLoadingState extends OtpState {}

class OtpSuccessState extends OtpState {
  final bool? success;
  OtpSuccessState({this.success = false});
}

class OtpSuccess2State extends OtpState {
  final bool? success;
  OtpSuccess2State({this.success = false});
}

class OtpFailedState extends OtpState {
  final String? message;
  OtpFailedState({this.message});
}

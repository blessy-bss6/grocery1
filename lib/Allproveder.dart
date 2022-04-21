import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

import 'Backend/Bloc/cart_Bloc.dart';
import 'Backend/Bloc/otpsBloc.dart';
import 'Backend/Bloc/prod_home_Bloc.dart';
import 'Backend/Bloc/reg_Login_Bloc.dart';
import 'Backend/Bloc/seller/selprod_bloc.dart';
import 'Backend/Bloc/wishlist_Bloc.dart';

class MainBloc {
  static List<SingleChildWidget> allBlocs() {
    return [
      BlocProvider(create: (ctx) => OtpBloc()),
      BlocProvider(create: (ctx) => AuthBloc()),
      BlocProvider(create: (ctx) => ProdHomeBloc()),
      BlocProvider(create: (ctx) => CartBloc()),
      BlocProvider(create: (ctx) => WishListBloc()),
      BlocProvider(create: (ctx) => SelProductBloc()),
    ];
  }
}

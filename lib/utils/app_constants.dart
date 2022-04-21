class URLConstants {
  // static const baseUrl = "https://reqres.in/";
  static const baseUrl = "http://127.0.0.1:8000/";

  ///API onBoarding************************************************************************
  static const signUpApiUrl = baseUrl + 'register';
  static const loginApiUrl = baseUrl + 'login';
  static const logoutApiUrl = baseUrl + 'logout';

//   OTP
  static const sendOtpUrl = baseUrl + 'sendOtp';
  static const resentOtpUrl = baseUrl + 'resendOtp';
  static const verifyOtpUrl = baseUrl + 'verifyOtp';

  //  ! Home Product
  static const prodUrl = baseUrl + 'product';
  static const homeUrl = baseUrl + 'home';

  // ! WishList and Cart
  static const cartUrl = baseUrl + 'cart';
  static const wishListUrl = baseUrl + 'wishlist';

  // ! SELLER URLS
  static const selProdUrl = baseUrl + 'selproduct';
}
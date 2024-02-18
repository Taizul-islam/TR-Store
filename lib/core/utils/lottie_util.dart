

import '../constants/api_const.dart';
import '../constants/lottie_const.dart';

getLottie(String error) {
  switch (error) {
    case noInternetConnection:
      return noInternetLottie;

    case unauthorisedRequest:
      return unauthorizedLottie;

    case notFound:
      return notFoundLottie;

    default:
      return somethingWrongLottie;
  }
}

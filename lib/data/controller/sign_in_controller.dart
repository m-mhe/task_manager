import 'package:get/get.dart';
import '../../UI/utility/url_list.dart';
import '../model/api_response.dart';
import '../model/log_in_model.dart';
import '../network_caller/api_call.dart';
import 'authentication_controller.dart';

class SignInController extends GetxController {
  bool _notLoading = true;

  bool get notLoading => _notLoading;

  Future<bool> signInServer(
      {required String email, required String password}) async {
    bool success = false;
    _notLoading = false;
    update();
    final Map<String, String> userSignInData = {
      "email": email,
      "password": password,
    };
    ApiResponse getServerResponse =
        await ApiCall.postResponse(URLList.logInURL, userSignInData);
    if (getServerResponse.isSuccess == true) {
      LogInModel logInModel =
          LogInModel.fromJson(getServerResponse.responseData);
      await AuthenticationController.saveLogInToken(logInModel.token!);
      await AuthenticationController.saveUserData(logInModel.data!);
      success = true;
      _notLoading = true;
    } else {
      success = false;
      _notLoading = true;
    }
    update();
    return success;
  }
}

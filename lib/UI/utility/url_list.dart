class URLList {
  static const String _baseURL = 'https://task.teamrabbil.com/api/v1';
  static const String registrationURL = '$_baseURL/registration';
  static const String logInURL = '$_baseURL/login';
  static const String createTask = '$_baseURL/createTask';
  static const String fromAllTheTask = '$_baseURL/listTaskByStatus';
  static const String getNewTask = '$fromAllTheTask/New';
  static const String getCompletedTask = '$fromAllTheTask/Completed';
  static const String getCanceledTask = '$fromAllTheTask/Canceled';
  static const String getProgressTask = '$fromAllTheTask/Progress';
  static const String getStatus = '$_baseURL/taskStatusCount';
  static const String upDateProfile = '$_baseURL/profileUpdate';
  static const String reSetPassword = '$_baseURL/RecoverResetPass';

  static updateStatus(String idAndStatus) =>
      '$_baseURL/updateTaskStatus/$idAndStatus';

  static deleteTask(String iD) => '$_baseURL/deleteTask/$iD';

  static emailForResettingPassword(String email) =>
      '$_baseURL/RecoverVerifyEmail/$email';

  static otpResettingPassword(String emailAndOtp) =>
      '$_baseURL/RecoverVerifyOTP/$emailAndOtp';
}

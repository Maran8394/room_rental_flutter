class ApiUrls {
  static const String domain = "http://192.168.1.101:8000";
  static const String signin = "$domain/api/token";
  static const String signup = "$domain/api/create-user";
  static const String forgotPassword = "$domain/api/forgot-password";
  static const String resetPassword = "$domain/api/reset-password";
  static const String changePassword = "$domain/api/change-password";

  static const String getProperties = "$domain/api/user/properties/";
  static const String getServiceRequests = "$domain/api/user/service-requests/";
  static const String createBill = "$domain/api/bills/create";
  static const String createServiceRequest =
      "$domain/api/service-requests/create";
  static const String updateServiceRequest =
      "$domain/api/service-requests/update/";
  static const String updateServiceRequestDataOnly =
      "$domain/api/service-requests/";
  static const String userDataUpdate = "$domain/api/update-user";
}

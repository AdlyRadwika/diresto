class ErrorUtil {
  static String convertErrorMessage(String message) {
    switch (message) {
      case "Failed host lookup: 'restaurant-api.dicoding.dev'":
        return message =
            'No internet connection. Connect to a wifi or mobile data.';
      default:
        return message;
    }
  }
}

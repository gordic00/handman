class ApiUrls {
  // static const baseURL = 'http://localhost:8080/';
  static const baseURL = 'http://10.0.2.2:8080/'; //for android
  // static const baseURL = 'https://www.carzner.com:8443/carzner/';
  static const register = '${baseURL}api/v1/auth/register';
  static const login = '${baseURL}api/v1/auth/login';
  static const test = '${baseURL}api/v1/test';
  static const testSecond = '${baseURL}api/v1/test/second';
}

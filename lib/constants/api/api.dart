import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
// Routes
// TODO: Check Api in Postman
  static const String _baseUrl = 'https://r-wa-happ-be.azurewebsites.net/api';
  static const String _getAllProjects = '/project/read/all';
  static const String _getAllTimeTacks = '/timetracking/read/all';
  static const String _getProjectsAdress = '/project/list';
  static const String _getProjectsConsumable = '/userProjectMaterial/read/1';
  static const String _getServiceAdress = '/service/list';
  static const String _getTimeTacks = '/timetracking/read/3';
  static const String _getUserProjectDocumentation = '/userProjectDay/read/2';
  static const String _loginUserAdress = '/user/login';
  static const String _postDocumentationDay = '/userProjectDay/create';
  static const String _postTimeEntryAdress = '/timetracking/create';
  static const String _postProjectConsumabele = '/userProjectMaterial/create';
  static const String _putDocumentationDay = '/userProjectDay/update';
  static const String _putProjectMaterial = '/userProjectMaterial/update';
  static const String _getCustomerProject = '/customer/project/read/all';
  static const String _getMaterialsList = '/material/list';
  static const String _getAllUnitsList = '/material/unit/list';
// Getter
  // String get getAllProjects => _baseUrl + _getAllProjects;
  // String get getAllTimeEntrys => _baseUrl + _getAllTimeTacks;
  // String get getProjectsDM => _baseUrl + _getProjectsAdress;
  // String get getCustomerProjects => _baseUrl + _getCustomerProject;
  // String get getExecuteableServices => _baseUrl + _getServiceAdress;
  // String get getProjectConsumableEntry => _baseUrl + _getProjectsConsumable;
  // String get getProjectsTimeEntrys => _baseUrl+getProjectsTimeEntrys;
  // String get getUserDocumentationEntry => _baseUrl + _getUserProjectDocumentation;
  // String get postloginUser => _baseUrl + _loginUserAdress;
  // String get postProjectConsumable(data) => _baseUrl + _postProjectConsumabele;
  // String get postDocumentationEntry => _baseUrl + _postDocumentationDay;
  // String get postTimeEnty => _baseUrl + _postTimeEntryAdress;
  // String get updateDocumentationEntry => _baseUrl + _putDocumentationDay;
  // String get updateProjectConsumableEntry => _baseUrl + _putProjectMaterial;
  // String getDokuforProjectURL(int projectID) => '$_baseUrl/project/$projectID/documentations';
  Future<Response> get getAllProjects => api.get(_getAllProjects);

  Future<Response> get getAllTimeEntrys => api.get(_getAllTimeTacks);
  Future<Response> get getAllUnits => api.get(_getAllUnitsList);
  Future<Response> get getCustomerProjects => api.get(_getCustomerProject);
  Future<Response> getDokuforProjectURL(int projectID) =>
      api.get('/project/$projectID/documentations');
  Future<Response> get getExecuteableServices => api.get(_getServiceAdress);
  Future<Response> get getMaterialsList => api.get(_getMaterialsList);
  Future<Response> get getProjectsDM => api.get(_getProjectsAdress);
  Future<Response> get getProjectConsumableEntry => api.get(_getProjectsConsumable);
  Future<Response> get getProjectsTimeEntrys => api.get(_getTimeTacks);
  Future<Response> get getUserDocumentationEntry => api.get(_getUserProjectDocumentation);
  Future<Response> postloginUser(loginData) => api.post(_loginUserAdress, data: loginData);
  Future<Response> postProjectConsumable(data) => api.post(_postProjectConsumabele, data: data);
  Future<Response> postDocumentationEntry(data) => api.post(_postDocumentationDay, data: data);
  Future<Response> postTimeEnty(data) => api.post(_postTimeEntryAdress, data: data);
  Future<Response> updateProjectConsumableEntry(data) => api.post(_putProjectMaterial, data: data);
  Future<Response> updateDocumentationEntry(data) => api.post(_putDocumentationDay, data: data);

  void storeToken(String token) async =>
      await _storage.then((value) => value.setString('TOKEN', token));
  // final pref = await SharedPreferences.getInstance();

  Future<String?> get getToken async => await _storage.then((value) => value.getString('TOKEN'));

  final Dio api = Dio();

  final _storage = SharedPreferences.getInstance();
  String? accessToken;
  // TODO: wait for information what choose, shared prefences or secure storage
  // final _storage = const FlutterSecureStorage();
  final baseOption = BaseOptions(
    baseUrl: _baseUrl,
    // contentType: ResponseType.json.name,
  );
  Api() {
    api.options = baseOption;
    // api.interceptors.add(DioInterceptor());
    // api.interceptors.add(InterceptorsWrapper(
    //     onRequest: (options, handler) async {
    //       if (!options.path.contains('http')) {
    //         options.path = _baseUrl + options.path;
    //       }
    //       options.headers['Authorization'] = 'Bearer $accessToken';
    //       return handler.next(options);
    //     },
    // TODO: when its a way to centralise the logout logic than use it in the 401 statemend.
    // onError: (DioException error, handler) async => handler.next(error)
    // {
    // final storage = await _storage;
    // if (error.response?.statusCode == 401
    // && error.response?.data['message'] == 'Invalid JWT'
    // ) {
    // return;
    // if (storage.containsKey('bearerToken')) {
    // await refreshToken();
    // }
    // error.requestOptions.headers['Authorization'] = 'Bearer $accessToken';
    // return handler.resolve(await api.fetch(error.requestOptions));
    // return handler.resolve(await _retry(error.requestOptions));
    // }
    // return handler.next(error);
    // },
    // )
    // );
  }
  // Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
  //   final options = Options(
  //     method: requestOptions.method,
  //     headers: requestOptions.headers,
  //   );
  //   return api.request<dynamic>(
  //     requestOptions.path,
  //     data: requestOptions.data,
  //     queryParameters: requestOptions.queryParameters,
  //     options: options,
  //   );
  // }

// // TODO: when need login data than maybe hash the value in Storage?
//   Future<void> refreshToken() async {
//     final pref = await SharedPreferences.getInstance();
//     final token = pref.getString('TOKEN');
//     final response = await api.post(_baseUrl + _loginUserAdress, data: token);
//     if (response.statusCode == 201) {
//       pref.setString('bearerToken', response.data);
//       accessToken = response.data;
//     } else {
//       pref.clear();
//     }
//   }
}

class DioInterceptor extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await Api().getToken;
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers['content-Type'] = 'application/json';
    super.onRequest(options, handler);
  }
}

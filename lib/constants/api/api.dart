import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Customer {
  final String? companyName;
  final int id;

  Customer({this.companyName, required this.id});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      companyName: json['companyName'] != null ? json['companyName'] as String : 'Unknown Company',
      id: json['id'] != null ? json['id'] as int : -1,
    );
  }
}

// Project class
class Project {
  final String? title;
  final int id;
  final int customerId; // Add customerId property

  Project({this.title, required this.id, required this.customerId}); // Update constructor

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      title: json['title'] != null ? json['title'] as String : 'Default Title',
      id: json['id'] != null ? json['id'] as int : -1,
      customerId: json['customerId'] != null ? json['customerId'] as int : -1, // Parse customerId from JSON
    );
  }
}

class Api {
// Routes
// TODO: Check Api in Postman
  static const String _baseUrl = 'https://r-wa-happ-be.azurewebsites.net/api';
  final String _getAllProjects = '/project/read/all';
  final String _getAllTimeTacks = '/timetracking/read/all';
  final String _getProjectsAdress = '/project/list';
  final String _getProjectsConsumable = '/userProjectMaterial/read/1';
  final String _getServiceAdress = '/service/list';
  final String _getTimeTacks = '/timetracking/read/3';
  final String _getUserProjectDocumentation = '/userProjectDay/read/2';
  final String _loginUserAdress = '/user/login';
  final String _postDocumentationDay = '/userProjectDay/create';
  final String _postTimeEntryAdress = '  /timetracking/create';

  final String _postProjectConsumabele = '/userProjectMaterial/create';
  final String _putDocumentationDay = '/userProjectDay/update';
  final String _putProjectMaterial = '/userProjectMaterial/update';
  final String _getCustomerProject = '/customer/project/read/all';
  final String _getMaterialsList = '/material/list';
  final String _getAllUnitsList = '/material/unit/list';
  final String _getUserServiceListByID = 'i/userservice/list?userid=';
  final String _getUserServiceList = '/userservice/list';
  final String _getListUsersShort = '/user/list';
  final String _getListCustomer = '/customer/list';
  final String _getListProject = '/project/list';

  final String _deleteService = '/service/delete';

  Future get getAllProjects => api.get(_getAllProjects);
  Future get getAllTimeEntrys => api.get(_getAllTimeTacks);
  Future get getAllUnits => api.get(_getAllUnitsList);
  Future get getCustomerProjects => api.get(_getCustomerProject);
  Future get getUserDataShort => api.get(_getListUsersShort);
  Future getDokuforProjectURL(int projectID) => api.get('/project/$projectID/documentations');
  Future<Response> get getExecuteableServices => api.get(_getServiceAdress);
  Future get getMaterialsList => api.get(_getMaterialsList);
  Future get getProjectsDM => api.get(_getProjectsAdress);
  Future get getProjectConsumableEntry => api.get(_getProjectsConsumable);
  Future get getProjectsTimeEntrys => api.get(_getTimeTacks);
  Future get getUserDocumentationEntry => api.get(_getUserProjectDocumentation);
  Future<Response> get getUserServiceList => api.get(_getUserServiceList);

  Future<Response> deleteService(int serviceID) => api.delete('$_deleteService/$serviceID');

  Future postloginUser(loginData) => api.post(_loginUserAdress, data: loginData);
  Future postProjectConsumable(data) => api.post(_postProjectConsumabele, data: data);
  Future postDocumentationEntry(data) => api.post(_postDocumentationDay, data: data);
  Future postTimeEnty(data) => api.post(_postTimeEntryAdress, data: data);
  Future updateProjectConsumableEntry(data) => api.post(_putProjectMaterial, data: data);
  Future updateDocumentationEntry(data) => api.post(_putDocumentationDay, data: data);
  Future getUserServiceByID(id) => api.get(_getUserServiceListByID, data: id);

  // Getter for customer list
  Future get getListCustomer => api.get(_getListCustomer);

  // Getter for project list
  Future get getListProject => api.get(_getListProject);

  // Getter for customer list
  Future get getListCustomer => api.get(_getListCustomer);

  // Getter for project list
  Future get getListProject => api.get(_getListProject);

  void storeToken(String token) async => await _storage.then((value) => value.setString('TOKEN', token));
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
    api.interceptors.add(DioInterceptor());
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

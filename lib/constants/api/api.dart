import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Customer {
  final String? companyName;
  final int id;

  Customer({this.companyName, required this.id});

  factory Customer.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      // Return a default Customer object if json is null
      return Customer(companyName: 'Unknown Company', id: -1);
    }

    // Ensure that json['companyName'] and json['id'] are handled safely
    final companyName = json['companyName'] as String?;
    final id = json['id'] as int?;

    return Customer(
      companyName: companyName ?? 'Unknown Company',
      id: id ?? -1,
    );
  }
}

// Project class
class Project {
  final String? title;
  final int id;
  final int customerId; // Add customerId property

  Project({this.title, required this.id, required this.customerId}); // Update constructor

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        title: json['title'] != null ? json['title'] as String : 'Default Title',
        id: json['id'] != null ? json['id'] as int : -1,
        customerId: json['customerId'] != null
            ? json['customerId'] as int
            : -1, // Parse customerId from JSON
      );
}

class Api {
  final Dio _api = Dio();
  final _storage = SharedPreferences.getInstance();
  // Adresses
  static const String _baseUrl = 'https://r-wa-happ-be.azurewebsites.net/api';
  // delete Adress
  final String _deleteService = '/service/delete';
  final String _deleteServiceMaterial = '/material/delete';
  final String _deleteUser = '/user/delete';
  final String _deleteCustomer = '/customer/delete';
  // get Adress
  final String _getAllProjects = '/project/read/all';
  final String _getAllTimeTacks = '/timetracking/read/all';
  final String _getAllUnitsList = '/material/unit/list';
  // 'TODO: check if its needed!!'
  // final String _getAllCustomer = '/customer/project/read/all';
  final String _getAllCustomerWeb = '/customer/web/read/all';
  final String _getCustomerProjectReport = '/customer/web/read/report';
  final String _getListUsersShort = '/user/list';
  final String _getListCustomer = '/customer/list';
  final String _getListProject = '/project/list';
  // final String _getProjects = '/project/list';
  final String _getProjectByCustomer = '/project/list?customerId=';
  final String _getProjectsConsumable = '/userProjectMaterial/read/1';
  final String _getService = '/service/list';
  final String _getTimeTacks = '/timetracking/read/3';
  final String _getUserProjectDocumentation = '/userProjectDay/read/2';
  final String _getUserRole = '/role/list';
  final String _getMaterialsList = '/material/list';
  final String _getUserServiceListByID = '/userservice/list?userid=';
  final String _getUserServiceList = '/userservice/list';
  // post Adress
  final String _postcreateCardMaterial = '/material/create';
  final String _postCreateCustomer = '/customer/create';
  final String _postCreateService = '/service/create';
  final String _postDocumentationDay = '/userProjectDay/create';
  final String _postloginUser = '/user/login';
  final String _postNewUser = '/user/create';
  final String _postResetPasswordRequest = '/user/password/request/';
  final String _postTimeEntry = '/timetracking/create';
  final String _postProjectConsumabele = '/userProjectMaterial/create';
  // put Adress
  final String _putDocumentationDay = '/userProjectDay/update';
  final String _putProjectMaterial = '/userProjectMaterial/update';
  final String _putProjectWebMaterial = '/material/update';
  final String _putResetPassword = '/user/password/reset';
  final String _putSetNewPassword = '/user/password/change';
  final String _putUpdateService = '/service/update';
  final String _putUpdateUser = '/user/update';
  final String _postCreateProjectEntry = '/project/create';
  final String _putUpdateProjectEntry = '/project/update'; // New endpoint for updating projects
  final String _delDeleteProjectEntry = '/project/delete'; // New endpoint for deleting projects
  final String _getReadAllProjects = '/project/read';
  final String _putUpdateCustomer = '/customer/update';

  Api() {
    _api.options = BaseOptions(baseUrl: _baseUrl);
    _api.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
        String? token = await getToken;
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        if (!options.path.contains('http')) {
          options.path = _baseUrl + options.path;
        }
        handler.next(options);
      },
      // onError: (DioException error, ErrorInterceptorHandler handler) async {
      //   if (error.response?.statusCode == 401) {
      //     // Handle token refresh logic here if needed
      //     log('401 Unauthorized: ${error.response?.data}');
      //   }
      //   handler.next(error);
      // },
      // onResponse: (Response response, ResponseInterceptorHandler handler) {
      //   if (response.statusCode == 401) {
      //     log('401 Unauthorized response: ${response.data}');
      //     throw Exception('nicht Autorisiert');
      //   }
      //   handler.next(response);
      // },
    ));
  }

  Future<Response> get getAllProjects => _api.get(_getAllProjects);
  Future<Response> get getAllTimeEntrys => _api.get(_getAllTimeTacks);
  Future<Response> get getAllUnits => _api.get(_getAllUnitsList);
  Future<Response> get getAllCustomers => _api.get(_getAllCustomerWeb);
  Future<Response> get getAllCustomerProjectReports => _api.get(_getCustomerProjectReport);
  Future<Response> get getExecuteableServices => _api.get(_getService);
  Future<Response> get getListCustomer => _api.get(_getListCustomer);
  Future<Response> get getListProject => _api.get(_getListProject);
  Future<Response> get getMaterialsList => _api.get(_getMaterialsList);
  Future<Response> get getProjectConsumableEntry => _api.get(_getProjectsConsumable);
  Future<Response> get getProjectsDM => _api.get('/project/list');
  Future<Response> get getProjectsTimeEntrys => _api.get(_getTimeTacks);
  Future<String?> get getToken async => await _storage.then((value) => value.getString('TOKEN'));
  Future<Response> get getUserDataShort => _api.get(_getListUsersShort);
  Future<Response> get getUserDocumentationEntry => _api.get(_getUserProjectDocumentation);
  Future<Response> getProjectByCustomerID(int id) => _api.get('$_getProjectByCustomer$id');
  Future<Response> get getUserRoles => _api.get(_getUserRole);
  Future<Response> get getUserServiceList => _api.get(_getUserServiceList);
  Future<Response> postCreateCustomer(Map<String, dynamic> json) =>
      _api.post(_postCreateCustomer, data: json);
  Future<Response> putUpdateCustomer(Map<String, dynamic> json) =>
      _api.put(_putUpdateCustomer, data: json);
  Future<Response> get getReadAllProjects => _api.get(_getReadAllProjects);

  Future<Response> postCreateProjectEntry(Map<String, dynamic> data) =>
      _api.post(_postCreateProjectEntry, data: data);

  Future<Response> putUpdateProjectEntry(Map<String, dynamic> data) =>
      _api.put(_putUpdateProjectEntry, data: data);

  Future<Response> delDeleteProjectEntry(int projectId) =>
      _api.delete('$_delDeleteProjectEntry/$projectId');

  Future<Response> deleteService(int serviceID) => _api.delete('$_deleteService/$serviceID');
  Future<Response> deleteConsumable(int serviceID) =>
      _api.delete('$_deleteServiceMaterial/$serviceID');

  Future<Response> deleteCustomer(int customerID) => _api.delete('$_deleteCustomer/$customerID');
  void deleteToken() => _storage.then((value) {
        if (value.getString('TOKEN')?.isNotEmpty ?? false) {
          value.remove('TOKEN');
        }
        return;
      });

  Future<Response> deleteUser(String userID) => _api.delete('$_deleteUser/$userID');
  Future<Response> getDokuforProjectURL(int projectID) =>
      _api.get('/project/$projectID/documentations');

  Future<Response> getUserServiceByID(id) => _api.get(_getUserServiceListByID, data: id);

  Future<Response> postCreateMaterial(Map<String, dynamic> data) =>
      _api.post(_postcreateCardMaterial, data: data);
  Future<Response> postCreateNewUser(Map<String, dynamic> user) =>
      _api.post(_postNewUser, data: user);
  Future<Response> postCreateService(Map<String, dynamic> json) =>
      _api.post(_postCreateService, data: json);
  Future<Response> postDocumentationEntry(data) => _api.post(_postDocumentationDay, data: data);

  Future<Response> postloginUser(Map<String, dynamic> json) =>
      _api.post(_postloginUser, data: json);
  Future<Response> postProjectConsumable(Map<String, dynamic> json) =>
      _api.post(_postProjectConsumabele, data: json);
  Future<Response> postResetPasswordRequest(Map<String, dynamic> json) =>
      _api.post('$_postResetPasswordRequest/marten.meissner@layer-four.de', data: json);

  Future<Response> postTimeEnty(Map<String, dynamic> json) => _api.post(_postTimeEntry, data: json);
  Future<Response> putUpdateConsumableEntry(Map<String, dynamic> json) =>
      _api.put(_putProjectWebMaterial, data: json);

  Future<Response> postUpdateDocumentationEntry(Map<String, dynamic> data) =>
      _api.post(_putDocumentationDay, data: data);

  Future<Response> postUpdateProjectConsumableEntry(Map<String, dynamic> data) =>
      _api.post(_putProjectMaterial, data: data);
  Future<Response> putResetPassword(Map<String, dynamic> json) =>
      _api.put(_putResetPassword, data: json);
  Future<Response> putSetNewPassword(Map<String, dynamic> json) =>
      _api.put(_putSetNewPassword, data: json);
  Future<Response> putUpdateService(Map<String, dynamic> json) =>
      _api.put(_putUpdateService, data: json);

  Future<Response> putUpdateUser(Map<String, dynamic> json) => _api.put(_putUpdateUser, data: json);

  void storeToken(String token) async =>
      await _storage.then((value) => value.setString('TOKEN', token));
}

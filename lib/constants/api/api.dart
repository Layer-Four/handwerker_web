import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/project_entry_models/project_entry_vm/project_entry_vm.dart';

class Customer {
  final String? companyName;
  final int id;

  Customer({this.companyName, required this.id});

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        companyName: json['companyName'] != null ? json['companyName'] as String : 'Unknown Company',
        id: json['id'] != null ? json['id'] as int : -1,
      );
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
        customerId: json['customerId'] != null ? json['customerId'] as int : -1, // Parse customerId from JSON
      );
}

class Api {
  // Routes
  final Dio _api = Dio();
  final _storage = SharedPreferences.getInstance();
  final _baseOption = BaseOptions(baseUrl: _baseUrl);
  // Adresses
  static const String _baseUrl = 'https://r-wa-happ-be.azurewebsites.net/api';
  // delete Adress
  final String _deleteService = '/service/delete';
  final String _deleteServiceMaterial = '/material/delete';
  final String _deleteUser = '/user/delete';
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
  final String _getProjects = '/project/list';
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

  Api() {
    _api.options = _baseOption;
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
      onError: (DioException error, ErrorInterceptorHandler handler) async {
        if (error.response?.statusCode == 401) {
          // Handle token refresh logic here if needed
          log('401 Unauthorized: ${error.response?.data}');
        }
        handler.next(error);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        if (response.statusCode == 401) {
          log('401 Unauthorized response: ${response.data}');
          throw Exception('nicht Autorisiert');
        }
        handler.next(response);
      },
    ));
  }
  Future<Response> get getAllProjects => _api.get(_getAllProjects);
  Future<Response> get getAllTimeEntrys => _api.get(_getAllTimeTacks);
  Future<Response> get getAllUnits => _api.get(_getAllUnitsList);
  Future<Response> get getAllCustomers => _api.get(_getAllCustomerWeb);
  Future<Response> get getAllCustomerProjectReports => _api.get(_getCustomerProjectReport);
  Future<Response> get getExecuteableServices => _api.get(_getService);
  // Getter for customer list
  Future<Response> get getListCustomer => _api.get(_getListCustomer);
  // Getter for project list
  Future<Response> get getListProject => _api.get(_getListProject);
  Future<Response> get getMaterialsList => _api.get(_getMaterialsList);
  Future<Response> get getProjectConsumableEntry => _api.get(_getProjectsConsumable);
  Future<Response> get getProjectsDM => _api.get(_getProjects);
  Future<Response> get getProjectsTimeEntrys => _api.get(_getTimeTacks);
  Future<String?> get getToken async => await _storage.then((value) => value.getString('TOKEN'));
  Future<Response> get getUserDataShort => _api.get(_getListUsersShort);
  Future<Response> get getUserDocumentationEntry => _api.get(_getUserProjectDocumentation);

  Future<Response> get getUserRoles => _api.get(_getUserRole);

  Future<Response> get getUserServiceList => _api.get(_getUserServiceList);
  Future<Response> postCreateCustomer(Map<String, dynamic> json) => _api.post(_postCreateCustomer, data: json);
  Future<Response> postCreateProjectEntry(ProjectEntryVM data) =>
      _api.post(_postCreateProjectEntry, data: data.toJson());
  Future<Response> deleteService(int serviceID) => _api.delete('$_deleteService/$serviceID');
  Future<Response> deleteConsumable(int serviceID) => _api.delete('$_deleteServiceMaterial/$serviceID');
  void deleteToken() => _storage.then((value) {
        if (value.getString('TOKEN')?.isNotEmpty ?? false) {
          value.remove('TOKEN');
        }
        return;
      });
  Future<Response> deleteUser(String userID) => _api.delete('$_deleteUser/$userID');
  Future<Response> getDokuforProjectURL(int projectID) => _api.get('/project/$projectID/documentations');
  Future<Response> getUserServiceByID(id) => _api.get(_getUserServiceListByID, data: id);
  Future<Response> postCreateMaterial(Map<String, dynamic> data) => _api.post(_postcreateCardMaterial, data: data);
  Future<Response> postCreateNewUser(Map<String, dynamic> user) => _api.post(_postNewUser, data: user);
  Future<Response> postCreateService(Map<String, dynamic> json) => _api.post(_postCreateService, data: json);
  Future<Response> postDocumentationEntry(data) => _api.post(_postDocumentationDay, data: data);

  Future<Response> postloginUser(loginData) => _api.post(_postloginUser, data: loginData);

  Future<Response> postProjectConsumable(data) => _api.post(_postProjectConsumabele, data: data);
  Future<Response> postTimeEnty(data) => _api.post(_postTimeEntry, data: data);
  Future<Response> putUpdateConsumableEntry(Map<String, dynamic> json) => _api.put(_putProjectWebMaterial, data: json);

  Future<Response> postUpdateDocumentationEntry(data) => _api.post(_putDocumentationDay, data: data);

  Future<Response> postUpdateProjectConsumableEntry(data) => _api.post(_putProjectMaterial, data: data);
  Future<Response> putResetPassword(Map<String, dynamic> json) => _api.put(_putResetPassword, data: json);
  Future<Response> putSetNewPassword(Map<String, dynamic> json) => _api.put(_putSetNewPassword, data: json);
  Future<Response> putUpdateService(Map<String, dynamic> json) => _api.put(_putUpdateService, data: json);

  Future<Response> putUpdateUser(Map<String, dynamic> json) => _api.put(_putUpdateUser, data: json);
  void storeToken(String token) async => await _storage.then((value) => value.setString('TOKEN', token));
}

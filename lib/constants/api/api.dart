import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final String _postTimeEntryAdress = '/timetracking/create';
  final String _getUserRoleAdress = '/role/list';
  final String _postNewUserAdress = '/user/create';
  final String _postProjectConsumabele = '/userProjectMaterial/create';
  final String _putDocumentationDay = '/userProjectDay/update';
  final String _putProjectMaterial = '/userProjectMaterial/update';
  final String _getCustomerProject = '/customer/project/read/all';
  final String _getMaterialsList = '/material/list';
  final String _getAllUnitsList = '/material/unit/list';
  final String _getUserServiceListByID = '/userservice/list?userid=';
  final String _getUserServiceList = '/userservice/list';
  final String _getListUsersShort = '/user/list';
  final String _getListCustomer = '/customer/list';
  final String _getListProject = '/project/list';
  final String _putProjectWebMaterialAdress = '/material/update';
  final String _deleteService = '/service/delete';
  final String _deleteServiceMaterial = '/service/delete';
  final String _putResetPasswordAdress = '/user/password/reset';
  final String _deleteUserAdress = '/user/delete';

  Future<Response> get getAllProjects => _api.get(_getAllProjects);
  Future<Response> get getAllTimeEntrys => _api.get(_getAllTimeTacks);
  Future<Response> get getAllUnits => _api.get(_getAllUnitsList);
  Future<Response> get getCustomerProjects => _api.get(_getCustomerProject);
  Future<Response> get getUserDataShort => _api.get(_getListUsersShort);
  Future<Response> get getUserRoles => _api.get(_getUserRoleAdress);
  Future<Response> getDokuforProjectURL(int projectID) => _api.get('/project/$projectID/documentations');
  Future<Response> get getExecuteableServices => _api.get(_getServiceAdress);
  Future<Response> get getMaterialsList => _api.get(_getMaterialsList);
  Future<Response> get getProjectsDM => _api.get(_getProjectsAdress);
  Future<Response> get getProjectConsumableEntry => _api.get(_getProjectsConsumable);
  Future<Response> get getProjectsTimeEntrys => _api.get(_getTimeTacks);
  Future<Response> get getUserDocumentationEntry => _api.get(_getUserProjectDocumentation);
  Future<Response> get getUserServiceList => _api.get(_getUserServiceList);
  // Getter for customer list
  Future<Response> get getListCustomer => _api.get(_getListCustomer);

  // Getter for project list
  Future<Response> get getListProject => _api.get(_getListProject);

  Future<Response> deleteService(int serviceID) => _api.delete('$_deleteService/$serviceID');
  Future<Response> deleteServiceMaterial(int serviceID) => _api.delete('$_deleteServiceMaterial/$serviceID');
  Future<Response> deleteUser(String userID) => _api.delete('$_deleteUserAdress/$userID');
  Future<Response> postCreateNewUser(Map<String, dynamic> user) => _api.post(_postNewUserAdress, data: user);
  Future<Response> postloginUser(loginData) => _api.post(_loginUserAdress, data: loginData);
  Future<Response> postProjectConsumable(data) => _api.post(_postProjectConsumabele, data: data);
  Future<Response> postDocumentationEntry(data) => _api.post(_postDocumentationDay, data: data);
  Future<Response> postTimeEnty(data) => _api.post(_postTimeEntryAdress, data: data);
  Future<Response> postUpdateProjectConsumableEntry(data) => _api.post(_putProjectMaterial, data: data);

  Future<Response> postUpdateConsumableEntry(Map<String, dynamic> json) =>
      _api.put(_putProjectWebMaterialAdress, data: json);

  Future<Response> postUpdateDocumentationEntry(data) => _api.post(_putDocumentationDay, data: data);
  Future<Response> getUserServiceByID(id) => _api.get(_getUserServiceListByID, data: id);
  Future<Response> putResetPassword(Map<String, dynamic> json) => _api.put(_putResetPasswordAdress, data: json);

  void storeToken(String token) async => await _storage.then((value) => value.setString('TOKEN', token));

  Future<String?> get getToken async => await _storage.then((value) => value.getString('TOKEN'));
  void deleteToken() => _storage.then((value) {
        if (value.getString('TOKEN')?.isNotEmpty ?? false) {
          value.remove('TOKEN');
        }
        return;
      });

  final Dio _api = Dio();

  final _storage = SharedPreferences.getInstance();
  final _baseOption = BaseOptions(baseUrl: _baseUrl);
  Api() {
    _api.options = _baseOption;
    _api.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
        getToken.then((e) {
          final accesMap = {'Authorization': 'Bearer $e'};
          return options.headers.addEntries(accesMap.entries);
        });

        if (!options.path.contains('http')) {
          options.path = _baseUrl + options.path;
        }
        log('Request URL: ${options.uri}');
        log('Request data: ${options.data}');
        return handler.next(options);
      },
      onError: (DioException error, ErrorInterceptorHandler handler) async {
        if (error.message != null && error.message!.contains('500')) {
          _storage.then((e) => e.clear());
        }
        handler.next(error);
      },
      // onResponse: (Response<dynamic> response, ResponseInterceptorHandler handler) {
      //   if (response.statusCode == 401) {
      //     throw Exception('nicht Autorisiert');
      //   }
      //   handler.next(response);
      // },
    ));
  }
}

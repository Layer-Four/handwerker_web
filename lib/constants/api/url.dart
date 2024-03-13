class DbAdress {
  const DbAdress();

  final String _baseUrl = 'https://r-wa-happ-be.azurewebsites.net/api';
  final String _getServiceAdress = '/service/list';
  final String _getProjectsAdress = '/project/list';
  final String _gedTimeTacksAdress = '/timetracking/read/3';
  final String _loginUserAdress = '/user/login';
  final String _postTimeEntryAdress = '/timetracking/create';
  Uri get getServices => Uri.parse(_baseUrl + _getServiceAdress);
  Uri get getProjects => Uri.parse(_baseUrl + _getProjectsAdress);
  Uri get getTimeEntrys => Uri.parse(_baseUrl + _gedTimeTacksAdress);
  Uri get loginUser => Uri.parse(_baseUrl + _loginUserAdress);
  Uri get postTimeEnty => Uri.parse(_baseUrl + _postTimeEntryAdress);
}

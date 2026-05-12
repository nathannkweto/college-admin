import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:admin_api/api.dart' as admin;
import 'package:core_api/api.dart' as core;
import 'package:student_api/api.dart' as studentapi;
import 'package:lecturer_api/api.dart' as lecturerapi;

/// A custom HTTP client that intercepts 401 responses
class UnauthorizedInterceptorClient extends http.BaseClient {
  final http.Client _inner = http.Client();
  final VoidCallback onUnauthorized;

  UnauthorizedInterceptorClient({required this.onUnauthorized});

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final response = await _inner.send(request);

    // If 401 and NOT a login request, trigger the callback
    if (response.statusCode == 401 && !request.url.path.contains('/auth/login')) {
      onUnauthorized();
    }

    return response;
  }
}

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  // Base Clients
  late admin.ApiClient _adminClient;
  late core.ApiClient _coreClient;
  late studentapi.ApiClient _studentClient;
  late lecturerapi.ApiClient _lecturerClient;

  // API Modules
  late core.DefaultApi _authApi;
  late admin.DashboardApi _dashboardApi;
  late admin.StudentsApi _studentsApi;
  late admin.AcademicsApi _academicsApi;
  late admin.LecturersApi _lecturersApi;
  late admin.ExamsApi _examsApi;
  late admin.TimetablesApi _timetablesApi;
  late admin.FinanceApi _financeApi;
  late admin.ResultsApi _resultsApi;
  late studentapi.DefaultApi _studentApi;
  late lecturerapi.DefaultApi _lecturerApi;

void init({required String baseUrl, VoidCallback? onUnauthorized}) {
    // 1. Create the custom intercepting client
    final interceptiveClient = UnauthorizedInterceptorClient(
      onUnauthorized: onUnauthorized ?? () {},
    );

    // 2. Initialize Clients (Constructor only takes basePath)
    _coreClient = core.ApiClient(basePath: baseUrl);
    _adminClient = admin.ApiClient(basePath: '$baseUrl/admin');
    _studentClient = studentapi.ApiClient(basePath: '$baseUrl/student');
    _lecturerClient = lecturerapi.ApiClient(basePath: '$baseUrl/lecturer');

    // 3. Manually inject the interceptor using the setter we found in ApiClient.dart
    _coreClient.client = interceptiveClient;
    _adminClient.client = interceptiveClient;
    _studentClient.client = interceptiveClient;
    _lecturerClient.client = interceptiveClient;

    // 4. Initialize API Group Instances
    _authApi = core.DefaultApi(_coreClient);
    _dashboardApi = admin.DashboardApi(_adminClient);
    _studentsApi = admin.StudentsApi(_adminClient);
    _academicsApi = admin.AcademicsApi(_adminClient);
    _lecturersApi = admin.LecturersApi(_adminClient);
    _examsApi = admin.ExamsApi(_adminClient);
    _timetablesApi = admin.TimetablesApi(_adminClient);
    _financeApi = admin.FinanceApi(_adminClient);
    _resultsApi = admin.ResultsApi(_adminClient);
    _studentApi = studentapi.DefaultApi(_studentClient);
    _lecturerApi = lecturerapi.DefaultApi(_lecturerClient);
  }
  void setToken(String token) {
    final bearer = 'Bearer $token';
    _adminClient.addDefaultHeader('Authorization', bearer);
    _coreClient.addDefaultHeader('Authorization', bearer);
    _studentClient.addDefaultHeader('Authorization', bearer);
    _lecturerClient.addDefaultHeader('Authorization', bearer);
  }

  // Getters
  core.DefaultApi get auth => _authApi;
  admin.DashboardApi get dashboard => _dashboardApi;
  admin.StudentsApi get students => _studentsApi;
  admin.AcademicsApi get academics => _academicsApi;
  admin.LecturersApi get lecturers => _lecturersApi;
  admin.FinanceApi get finance => _financeApi;
  admin.ExamsApi get exams => _examsApi;
  admin.TimetablesApi get timetables => _timetablesApi;
  admin.ResultsApi get results => _resultsApi;
  studentapi.DefaultApi get student => _studentApi;
  lecturerapi.DefaultApi get lecturer => _lecturerApi;
}
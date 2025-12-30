import 'package:dio/dio.dart';
import 'package:admin_api/api.dart' as admin;
import 'package:core_api/api.dart' as core;
import 'package:student_api/api.dart' as studentapi;
import 'package:lecturer_api/api.dart' as lecturerapi; // [NEW]

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  late admin.ApiClient _adminClient;
  late core.ApiClient _coreClient;
  late studentapi.ApiClient _studentClient;
  late lecturerapi.ApiClient _lecturerClient; // [NEW]

  // Existing APIs
  late core.DefaultApi _authApi;
  late admin.DashboardApi _dashboardApi;
  late admin.StudentsApi _studentsApi;
  late admin.AcademicsApi _academicsApi;
  late admin.LecturersApi _lecturersApi;
  late admin.ExamsApi _examsApi;
  late admin.TimetablesApi _timetablesApi;
  late admin.FinanceApi _financeApi;
  late admin.ResultsApi _resultsApi;

  // Portal Specific APIs
  late studentapi.DefaultApi _studentApi;
  late lecturerapi.DefaultApi _lecturerApi; // [NEW]

  void init({required String baseUrl}) {
    // 1. Core Client
    _coreClient = core.ApiClient(basePath: baseUrl);
    _coreClient.addDefaultHeader('Accept', 'application/json');
    _coreClient.addDefaultHeader('Content-Type', 'application/json');

    // 2. Admin Client gets the '/admin' suffix
    _adminClient = admin.ApiClient(basePath: '$baseUrl/admin');
    _adminClient.addDefaultHeader('Accept', 'application/json');
    _adminClient.addDefaultHeader('Content-Type', 'application/json');

    // 3. Student Client gets the '/student' suffix
    _studentClient = studentapi.ApiClient(basePath: '$baseUrl/student');
    _studentClient.addDefaultHeader('Accept', 'application/json');
    _studentClient.addDefaultHeader('Content-Type', 'application/json');

    // 4. [NEW] Lecturer Client gets the '/lecturer' suffix
    _lecturerClient = lecturerapi.ApiClient(basePath: '$baseUrl/lecturer');
    _lecturerClient.addDefaultHeader('Accept', 'application/json');
    _lecturerClient.addDefaultHeader('Content-Type', 'application/json');

    // Initialize APIs
    _authApi = core.DefaultApi(_coreClient);

    // Admin
    _dashboardApi = admin.DashboardApi(_adminClient);
    _studentsApi = admin.StudentsApi(_adminClient);
    _academicsApi = admin.AcademicsApi(_adminClient);
    _lecturersApi = admin.LecturersApi(_adminClient);
    _examsApi = admin.ExamsApi(_adminClient);
    _timetablesApi = admin.TimetablesApi(_adminClient);
    _financeApi = admin.FinanceApi(_adminClient);
    _resultsApi = admin.ResultsApi(_adminClient);

    // Portals
    _studentApi = studentapi.DefaultApi(_studentClient);
    _lecturerApi = lecturerapi.DefaultApi(_lecturerClient); // [NEW]
  }

  void setToken(String token) {
    _adminClient.addDefaultHeader('Authorization', 'Bearer $token');
    _coreClient.addDefaultHeader('Authorization', 'Bearer $token');
    _studentClient.addDefaultHeader('Authorization', 'Bearer $token');
    _lecturerClient.addDefaultHeader('Authorization', 'Bearer $token'); // [NEW]
  }

  // Getters - Admin & Core
  core.DefaultApi get auth => _authApi;
  admin.DashboardApi get dashboard => _dashboardApi;
  admin.StudentsApi get students => _studentsApi;
  admin.AcademicsApi get academics => _academicsApi;
  admin.LecturersApi get lecturers => _lecturersApi;
  admin.FinanceApi get finance => _financeApi;
  admin.ExamsApi get exams => _examsApi;
  admin.TimetablesApi get timetables => _timetablesApi;
  admin.ResultsApi get results => _resultsApi;

  // Getters - Student
  studentapi.DefaultApi get student => _studentApi;

  // Getters - Lecturer
  lecturerapi.DefaultApi get lecturer => _lecturerApi; // [NEW]
}
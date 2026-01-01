import 'package:dio/dio.dart';
import 'package:admin_api/api.dart' as admin;
import 'package:core_api/api.dart' as core;
import 'package:student_api/api.dart' as studentapi;
import 'package:lecturer_api/api.dart' as lecturerapi;

class ApiService {
  // 1. Singleton Pattern
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  // 2. Base Clients (Wrappers around Dio)
  late admin.ApiClient _adminClient;
  late core.ApiClient _coreClient;
  late studentapi.ApiClient _studentClient;
  late lecturerapi.ApiClient _lecturerClient;

  // 3. Admin APIs
  late core.DefaultApi _authApi;
  late admin.DashboardApi _dashboardApi;
  late admin.StudentsApi _studentsApi;
  late admin.AcademicsApi _academicsApi;
  late admin.LecturersApi _lecturersApi;
  late admin.ExamsApi _examsApi; // <--- This now contains seasons & schedules endpoints
  late admin.TimetablesApi _timetablesApi;
  late admin.FinanceApi _financeApi;
  late admin.ResultsApi _resultsApi;

  // 4. Portal Specific APIs
  late studentapi.DefaultApi _studentApi;
  late lecturerapi.DefaultApi _lecturerApi;

  void init({required String baseUrl}) {
    // --- Configuration (Timeouts & Headers) ---
    // It is good practice to set timeouts to prevent the app from hanging indefinitely
    const int connectionTimeout = 15000; // 15 seconds
    const int receiveTimeout = 15000;

    // --- 1. Core Client ---
    _coreClient = core.ApiClient(basePath: baseUrl);
    _coreClient.addDefaultHeader('Accept', 'application/json');
    _coreClient.addDefaultHeader('Content-Type', 'application/json');
    // _coreClient.getDio().options.connectTimeout = const Duration(milliseconds: connectionTimeout);

    // --- 2. Admin Client ('/admin') ---
    _adminClient = admin.ApiClient(basePath: '$baseUrl/admin');
    _adminClient.addDefaultHeader('Accept', 'application/json');
    _adminClient.addDefaultHeader('Content-Type', 'application/json');

    // --- 3. Student Client ('/student') ---
    _studentClient = studentapi.ApiClient(basePath: '$baseUrl/student');
    _studentClient.addDefaultHeader('Accept', 'application/json');
    _studentClient.addDefaultHeader('Content-Type', 'application/json');

    // --- 4. Lecturer Client ('/lecturer') ---
    _lecturerClient = lecturerapi.ApiClient(basePath: '$baseUrl/lecturer');
    _lecturerClient.addDefaultHeader('Accept', 'application/json');
    _lecturerClient.addDefaultHeader('Content-Type', 'application/json');

    // --- Initialize API Group Instances ---

    // Auth (Core)
    _authApi = core.DefaultApi(_coreClient);

    // Admin Modules
    _dashboardApi = admin.DashboardApi(_adminClient);
    _studentsApi = admin.StudentsApi(_adminClient);
    _academicsApi = admin.AcademicsApi(_adminClient);
    _lecturersApi = admin.LecturersApi(_adminClient);

    // This API instance now has methods like:
    // examSeasonsList(), examSeasonsPost(), examSeasonsActiveGet()
    _examsApi = admin.ExamsApi(_adminClient);

    _timetablesApi = admin.TimetablesApi(_adminClient);
    _financeApi = admin.FinanceApi(_adminClient);
    _resultsApi = admin.ResultsApi(_adminClient);

    // Portal Modules
    _studentApi = studentapi.DefaultApi(_studentClient);
    _lecturerApi = lecturerapi.DefaultApi(_lecturerClient);
  }

  // --- Auth Token Injection ---
  void setToken(String token) {
    final bearer = 'Bearer $token';
    _adminClient.addDefaultHeader('Authorization', bearer);
    _coreClient.addDefaultHeader('Authorization', bearer);
    _studentClient.addDefaultHeader('Authorization', bearer);
    _lecturerClient.addDefaultHeader('Authorization', bearer);
  }

  // --- Getters ---

  // Admin
  core.DefaultApi get auth => _authApi;
  admin.DashboardApi get dashboard => _dashboardApi;
  admin.StudentsApi get students => _studentsApi;
  admin.AcademicsApi get academics => _academicsApi;
  admin.LecturersApi get lecturers => _lecturersApi;
  admin.FinanceApi get finance => _financeApi;
  admin.ExamsApi get exams => _examsApi; // <--- The provider will use this
  admin.TimetablesApi get timetables => _timetablesApi;
  admin.ResultsApi get results => _resultsApi;

  // Student
  studentapi.DefaultApi get student => _studentApi;

  // Lecturer
  lecturerapi.DefaultApi get lecturer => _lecturerApi;
}
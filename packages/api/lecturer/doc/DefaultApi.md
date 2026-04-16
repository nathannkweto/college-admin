# lecturer_api.api.DefaultApi

## Load the API package
```dart
import 'package:lecturer_api/api.dart';
```

All URIs are relative to *https://api.college.edu/api/v1/lecturer*

Method | HTTP request | Description
------------- | ------------- | -------------
[**lecturerCourseDetailsGet**](DefaultApi.md#lecturercoursedetailsget) | **GET** /courses/{course_public_id} | Get Course Details & Student List
[**lecturerCoursesGet**](DefaultApi.md#lecturercoursesget) | **GET** /courses | Get All Assigned Courses (Current Semester)
[**lecturerGradesPost**](DefaultApi.md#lecturergradespost) | **POST** /courses/{course_public_id}/grades | Submit or Update Grades
[**lecturerProfileGet**](DefaultApi.md#lecturerprofileget) | **GET** /profile | Get Lecturer Profile
[**lecturerScheduleGet**](DefaultApi.md#lecturerscheduleget) | **GET** /schedule | Get Weekly Schedule


# **lecturerCourseDetailsGet**
> CourseCohortDetails lecturerCourseDetailsGet(coursePublicId)

Get Course Details & Student List

### Example
```dart
import 'package:lecturer_api/api.dart';

final api_instance = DefaultApi();
final coursePublicId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.lecturerCourseDetailsGet(coursePublicId);
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->lecturerCourseDetailsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **coursePublicId** | **String**|  | 

### Return type

[**CourseCohortDetails**](CourseCohortDetails.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **lecturerCoursesGet**
> LecturerCoursesGet200Response lecturerCoursesGet()

Get All Assigned Courses (Current Semester)

Returns a list of courses assigned to the lecturer for the active semester (Odd/Even logic applied).

### Example
```dart
import 'package:lecturer_api/api.dart';

final api_instance = DefaultApi();

try {
    final result = api_instance.lecturerCoursesGet();
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->lecturerCoursesGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**LecturerCoursesGet200Response**](LecturerCoursesGet200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **lecturerGradesPost**
> lecturerGradesPost(coursePublicId, gradeSubmissionBatch)

Submit or Update Grades

### Example
```dart
import 'package:lecturer_api/api.dart';

final api_instance = DefaultApi();
final coursePublicId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final gradeSubmissionBatch = GradeSubmissionBatch(); // GradeSubmissionBatch | 

try {
    api_instance.lecturerGradesPost(coursePublicId, gradeSubmissionBatch);
} catch (e) {
    print('Exception when calling DefaultApi->lecturerGradesPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **coursePublicId** | **String**|  | 
 **gradeSubmissionBatch** | [**GradeSubmissionBatch**](GradeSubmissionBatch.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **lecturerProfileGet**
> LecturerProfileGet200Response lecturerProfileGet()

Get Lecturer Profile

### Example
```dart
import 'package:lecturer_api/api.dart';

final api_instance = DefaultApi();

try {
    final result = api_instance.lecturerProfileGet();
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->lecturerProfileGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**LecturerProfileGet200Response**](LecturerProfileGet200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **lecturerScheduleGet**
> LecturerScheduleGet200Response lecturerScheduleGet()

Get Weekly Schedule

Returns the lecturer's timetable for the currently active semester, grouped by day.

### Example
```dart
import 'package:lecturer_api/api.dart';

final api_instance = DefaultApi();

try {
    final result = api_instance.lecturerScheduleGet();
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->lecturerScheduleGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**LecturerScheduleGet200Response**](LecturerScheduleGet200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


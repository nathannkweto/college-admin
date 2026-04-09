# student_api.api.DefaultApi

## Load the API package
```dart
import 'package:student_api/api.dart';
```

All URIs are relative to *https://api.college.edu/api/v1/student*

Method | HTTP request | Description
------------- | ------------- | -------------
[**studentCurrentCoursesGet**](DefaultApi.md#studentcurrentcoursesget) | **GET** /courses/current | 
[**studentCurriculumGet**](DefaultApi.md#studentcurriculumget) | **GET** /curriculum | 
[**studentExamsGet**](DefaultApi.md#studentexamsget) | **GET** /exams/upcoming | 
[**studentFinanceGet**](DefaultApi.md#studentfinanceget) | **GET** /finance | 
[**studentProfileGet**](DefaultApi.md#studentprofileget) | **GET** /profile | 
[**studentResultsGet**](DefaultApi.md#studentresultsget) | **GET** /results | Get Student Academic History
[**studentScheduleGet**](DefaultApi.md#studentscheduleget) | **GET** /schedule | Get Student Weekly Timetable


# **studentCurrentCoursesGet**
> StudentCurrentCoursesGet200Response studentCurrentCoursesGet()



### Example
```dart
import 'package:student_api/api.dart';

final api_instance = DefaultApi();

try {
    final result = api_instance.studentCurrentCoursesGet();
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->studentCurrentCoursesGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**StudentCurrentCoursesGet200Response**](StudentCurrentCoursesGet200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **studentCurriculumGet**
> StudentCurriculumGet200Response studentCurriculumGet()



### Example
```dart
import 'package:student_api/api.dart';

final api_instance = DefaultApi();

try {
    final result = api_instance.studentCurriculumGet();
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->studentCurriculumGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**StudentCurriculumGet200Response**](StudentCurriculumGet200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **studentExamsGet**
> StudentExamsGet200Response studentExamsGet()



### Example
```dart
import 'package:student_api/api.dart';

final api_instance = DefaultApi();

try {
    final result = api_instance.studentExamsGet();
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->studentExamsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**StudentExamsGet200Response**](StudentExamsGet200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **studentFinanceGet**
> StudentFinanceGet200Response studentFinanceGet()



### Example
```dart
import 'package:student_api/api.dart';

final api_instance = DefaultApi();

try {
    final result = api_instance.studentFinanceGet();
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->studentFinanceGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**StudentFinanceGet200Response**](StudentFinanceGet200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **studentProfileGet**
> StudentProfileGet200Response studentProfileGet()



### Example
```dart
import 'package:student_api/api.dart';

final api_instance = DefaultApi();

try {
    final result = api_instance.studentProfileGet();
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->studentProfileGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**StudentProfileGet200Response**](StudentProfileGet200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **studentResultsGet**
> StudentResultsGet200Response studentResultsGet()

Get Student Academic History

Returns a list of all enrolled courses grouped by semester sequence (e.g., Year 1 - Semester 1). Scores are masked if results are not yet published.

### Example
```dart
import 'package:student_api/api.dart';

final api_instance = DefaultApi();

try {
    final result = api_instance.studentResultsGet();
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->studentResultsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**StudentResultsGet200Response**](StudentResultsGet200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **studentScheduleGet**
> StudentScheduleGet200Response studentScheduleGet()

Get Student Weekly Timetable

Returns the full weekly schedule grouped by day for the student's current program and semester.

### Example
```dart
import 'package:student_api/api.dart';

final api_instance = DefaultApi();

try {
    final result = api_instance.studentScheduleGet();
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->studentScheduleGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**StudentScheduleGet200Response**](StudentScheduleGet200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


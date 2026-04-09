# admin_api.api.DashboardApi

## Load the API package
```dart
import 'package:admin_api/api.dart';
```

All URIs are relative to *https://api.college.edu/api/v1/admin*

Method | HTTP request | Description
------------- | ------------- | -------------
[**dashboardFinanceGet**](DashboardApi.md#dashboardfinanceget) | **GET** /dashboard/finance | Get financial overview
[**dashboardMetricsGet**](DashboardApi.md#dashboardmetricsget) | **GET** /dashboard/metrics | Get core KPI counts


# **dashboardFinanceGet**
> DashboardFinanceGet200Response dashboardFinanceGet()

Get financial overview

### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = DashboardApi();

try {
    final result = api_instance.dashboardFinanceGet();
    print(result);
} catch (e) {
    print('Exception when calling DashboardApi->dashboardFinanceGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**DashboardFinanceGet200Response**](DashboardFinanceGet200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **dashboardMetricsGet**
> DashboardMetricsGet200Response dashboardMetricsGet()

Get core KPI counts

### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = DashboardApi();

try {
    final result = api_instance.dashboardMetricsGet();
    print(result);
} catch (e) {
    print('Exception when calling DashboardApi->dashboardMetricsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**DashboardMetricsGet200Response**](DashboardMetricsGet200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


# lecturer_api.model.CourseCohortDetails

## Load the model package
```dart
import 'package:lecturer_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**programCourseId** | **int** | The internal database ID (not UUID) required for the grading endpoint. | 
**course** | [**CourseCohortDetailsCourse**](CourseCohortDetailsCourse.md) |  | [optional] 
**program** | [**CourseCohortDetailsProgram**](CourseCohortDetailsProgram.md) |  | [optional] 
**context** | [**CourseCohortDetailsContext**](CourseCohortDetailsContext.md) |  | [optional] 
**students** | [**List<StudentGradeRecord>**](StudentGradeRecord.md) |  | [optional] [default to const []]

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)



// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tiimee/GetController/LoginController/LoginController.dart';
// import 'package:tiimee/Models/Request/Calculate.dart';
// import 'package:tiimee/Models/Request/Request.dart';
// import 'package:tiimee/Models/Request/RequestPictureRequired.dart';
// import 'package:tiimee/Models/Request/RequestTime.dart';
// import 'package:tiimee/Models/Request/RequestType.dart';
// import 'package:tiimee/Models/Request/TimelessDaysModel.dart';

// import 'package:tiimee/Repository/Repository.dart';
// import 'package:tiimee/Utils/CustomColors.dart';
// import 'package:tiimee/Utils/ReusableWidgets.dart';

// import '../../Models/Month.dart';
// import '../../Models/Request/RequestDetail.dart';
// import '../../Screens/HomeScreen/HomeMainMenus/RequestScreen/RequestSend/RequestSend.dart';

import 'package:get/get.dart';
import 'package:project1/model/GetCategory.dart';
import 'package:project1/model/GetNews.dart';
import 'package:project1/model/Request.dart';
import 'package:project1/model/CalculateTime.dart';
import 'package:project1/model/RequestDetails.dart';
import 'package:project1/model/RequestTime.dart';
import 'package:project1/model/RequestType.dart';
import 'package:project1/repo/Repository.dart';

class RequestController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getRequest();
  }

  var request = <Request>[].obs;
  var isLoading = false.obs;
  final RxString selectedMonth = ''.obs;

  Future<void> getRequest() async {
    isLoading.value = true;
    request.value = await Repository().getRequest();
    print(request.length);
    isLoading.value = false;
  }
}

class GetNewsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getNews();
  }

  var request = GetNews(success: '', feature: [], news: []).obs;
  var isLoading = false.obs;
  var selectedCategoryId = '201'.obs;

  Future<void> getNews() async {
    isLoading.value = true;
    request.value =
        await Repository().getNews(int.parse(selectedCategoryId.value));
    isLoading.value = false;
  }
}

class RequestTypeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getRequestType();
  }

  var request = <RequestType>[].obs;
  var isLoading = false.obs;
  void getRequestType() async {
    isLoading.value = true;
    request.value = await Repository().getRequestType();
    isLoading.value = false;
  }
}

class GetCategoryController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getCategory();
  }

  var request = <GetCategory>[].obs;
  var isLoading = false.obs;
  void getCategory() async {
    isLoading.value = true;
    request.value = await Repository().getCategory();
    isLoading.value = false;
  }
}

class RequestTimeController extends GetxController {
  get calculatedTime => null;

  @override
  void onInit() {
    super.onInit();
    getRequestTime("2023-01-10 00:00:00.000", 2);
  }

  var request = <RequestTime>[].obs;
  var isLoading = false.obs;

  void getRequestTime(String date, int requestTypeId) async {
    isLoading.value = true;
    request.value = await Repository().getRequestTime(date, requestTypeId);
    isLoading.value = false;
  }
}

class CalculateTimeController extends GetxController {
  var isCalculating = false.obs;
  var calculatedTime = CalculateTime(
    success: "0",
    message: "",
    totalTime: "0",
  ).obs;

  Future<void> getCalculateTime(DateTime startDate, DateTime endDate,
      String requestType, String requestSubType) async {
    isCalculating.value = true;

    var result = await Repository().getCalculateTime(
      startDate.toString(),
      endDate.toString(),
      requestType,
      requestSubType,
    );

    if (result.success == "1") {
      calculatedTime.value = result;
    }

    isCalculating.value = false;
  }
}

class RequestDetailController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getRequestDetails("889581");
  }

  var request = RequestDetails().obs;
  var isLoading = false.obs;

  void getRequestDetails(String requestId) async {
    isLoading.value = true;
    request.value = await Repository().getRequestDetails(requestId);
    isLoading.value = false;
  }
}

class RequestSendController extends GetxController {
  var isSentRequest = false.obs;

  Future<bool> sendRequest(DateTime? startDate, DateTime? endDate, int type,
      int subType, String time, String description,
      {String? date}) async {
    isSentRequest.value = true;

    var result = await Repository().sendRequest(
        startDate, endDate, type, subType, time, description,
        date: date);

    if (result.success == "1") {
      Get.back(result: true);

      isSentRequest.value = false;
      return true;
    } else {
      isSentRequest.value = false;
      return false;
    }
  }
}

class RequestTimeDateController extends GetxController {
  Rx<DateTime> startDate = Rx<DateTime>(
    DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      9,
      0,
    ),
  );

  Rx<DateTime> endDate = Rx<DateTime>(
    DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      9,
      0,
    ),
  );

  @override
  void onInit() {
    super.onInit();

    print('object');

    startDate.value = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 9, 0);
    endDate.value = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 9, 0);
  }
}

//   var login = Get.find<LoginController>();
//   RxList<dynamic> timelessDays = [].obs;
//   var timelessDayModel = TimelessDaysModel().obs;

//   var sendRequestSelectedType = RequestType(id: "-1").obs;
//   var sendRequestSelectSubType = SubType(id: "-1").obs;
//   var sendRequestStartTime = TimeOfDay(hour: 0, minute: 0).obs;
//   var sendRequestEndTime = TimeOfDay(hour: 0, minute: 0).obs;
//   var sendRequestStartDate = DateTime.now().obs;
//   var sendRequestEndDate = DateTime.now().obs;
//   Rx<TimeOfDay> sendRequestCalculatedTime = TimeOfDay(hour: 0, minute: 0).obs;
//   RxList<MissedTimeModel> missedTimeList = <MissedTimeModel>[].obs;

//   var isTimelessDaysLoading = false.obs;

//   var isRequestLoading = false.obs;
//   var isDeleteLoading = false.obs;
//   var isSentRequest = false.obs;

//   var isRequestDetail = false.obs;

//   var approvedList = <Request>[].obs;
//   var denyList = <Request>[].obs;
//   var newList = <Request>[].obs;
//   var requestTypeList = <RequestType>[].obs;
//   var requestDetailModel = RequestDetail().obs;
//   var sendRequestTFC = TextEditingController(text: '0${"h".tr}').obs;

//   var requestPictureRequired = <RequestPictureRequired>[].obs;

//   var isMonthLoading = false.obs;
//   var isTimeLoading = false.obs;
//   var isCalculating = false.obs;
//   var isRequestType = false.obs;
//   var isRequestSubType = false.obs;

//   var isNewListCalled = false.obs;
//   var isApprovedListCalled = false.obs;
//   var isDeniedListCalled = false.obs;

//   var calculatedTime = CalculateTime().obs;

//   @override
//   void onInit() {
//     super.onInit();
//     getMonth();
//     getRequestType();
//     getRequest("new", month: "");
//     getRequestPictureRequired();
//   }

//   void getRequest(String requestId, {String? month, int? tabbarIndex}) async {
//     isRequestLoading.value = true;

//     var result = await Repository().getRequest(requestId, month ?? "");
//     if (requestId == "approved") {
//       approvedList.value = result;
//       isApprovedListCalled.value = true;
//     }
//     if (requestId == "new") {
//       newList.value = result;
//       isNewListCalled.value = true;
//     }
//     if (requestId == "denied") {
//       denyList.value = result;
//       isDeniedListCalled.value = true;
//     }
//     isRequestLoading.value = false;
//   }

//   void deteleRequest(String id, String requestId) async {
//     isDeleteLoading.value = true;
//     var result = await Repository().deleteRequest(id);

//     if (result.success == "1") {
//       ReusableWidgets.showSnackBar(
//           "${result.message}", "", Icons.send, Colors.amber,
//           backgroundColor: CustomColors.mainGreen,
//           position: SnackPosition.BOTTOM);

//       isDeleteLoading.value = false;
//       if (requestId == "new") newList(result.requestList);
//     } else {
//       ReusableWidgets.showSnackBar(
//           "Амжилтгүй, ${result.message}", "", Icons.send, Colors.white,
//           iconSize: 20, position: SnackPosition.BOTTOM);
//     }
//     isDeleteLoading.value = false;
//   }

  

//   Future getRequestDetail(String id) async {
//     isRequestDetail.value = true;
//     var result = await Repository().getRequestDetail(id);

//     requestDetailModel.value = result;
//     isRequestDetail.value = false;
//   }

//   var monthList = <Month>[].obs;

//   void getMonth() async {
//     isMonthLoading.value = true;
//     var result = await Repository().getMonth();

//     if (result.length > 0) {
//       isMonthLoading.value = false;
//       monthList(result);
//     }
//     isMonthLoading.value = false;
//   }

//   var requestTimelist = <RequestTime>[].obs;

// Future<void> getRequestTime(String date, int requestType) async {
//   isLoading.value = true;
//   var result = await Repository().getRequestTime(date, requestType);

//   if (result.length > 0) {
//     isLoading.value = false;
//     requestTimelist.clear();
//     requestTimelist.value = result;
//   }
//   isLoading.value = false;
// }

  
//   void getRequestType() async {
//     isRequestType.value = true;
//     var result = await Repository().getRequestType();

//     if (result.length > 0) {
//       requestTypeList.value = result;
//       isRequestType.value = false;
//     }
//     isRequestType.value = false;
//   }

//   Future<void> getTimelessDays(int type) async {
//     isTimelessDaysLoading.value = true;

//     var result = await Repository().getTimelessDays(type);
//     timelessDayModel.value = result;
//     timelessDays.value = result.timelessDays!;
//     missedTimeList.clear();

//     for (int i = 0; i < timelessDays.length; i++) {
//       try {
//         var hour = type == 1
//             ? timelessDays[i].startTime.toString().substring(0, 2).obs
//             : timelessDays[i].endTime.toString().substring(0, 2).obs;

//         var minute = type == 1
//             ? timelessDays[i]
//                 .startTime
//                 .toString()
//                 .substring(
//                   timelessDays[i].startTime!.length - 2,
//                   timelessDays[i].startTime!.length,
//                 )
//                 .obs
//             : timelessDays[i]
//                 .endTime
//                 .toString()
//                 .substring(
//                   timelessDays[i].endTime!.length - 2,
//                   timelessDays[i].endTime!.length,
//                 )
//                 .obs;
//         var date = timelessDays[i].date!.toString().obs;
//         var hourIndex = (int.parse(hour.value) - 1).obs;
//         var minuteIndex = (int.parse(minute.value)).obs;
//         missedTimeList.add(
//           MissedTimeModel(
//             hour: hour,
//             minute: minute,
//             date: date,
//             hourIndex: hourIndex,
//             minuteIndex: minuteIndex,
//             isSelected: false.obs,
//           ),
//         );
//       } catch (e) {}
//     }

//     isTimelessDaysLoading.value = false;
//   }

//   Future<void> getRequestPictureRequired() async {
//     List<RequestPictureRequired> _result =
//         await Repository().getRequestPictureRequired();

//     requestPictureRequired.value = _result;
//   }
// }

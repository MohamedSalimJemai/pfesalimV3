import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../response/api_response.dart';
import '../response/status.dart';

abstract class BaseViewModel<T> extends ChangeNotifier {
  bool isDisposed = false;

  ApiResponse<dynamic> apiResponse = ApiResponse.loading();

  late List<T> itemList = [];
  late T item;

  BaseViewModel();

  Future<ApiResponse> getAll() async {
    return apiResponse;
  }

  Future<ApiResponse> getAllSecondary() async {
    return apiResponse;
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }

  void setItem({required T item, bool notifyChanges = true}) {
    this.item = item;
    if (apiResponse.status != Status.completed) {
      apiResponse.status = Status.completed;
    }
    if (!isDisposed) notifyListeners();
  }

  void setItemList(List<T> itemList) {
    this.itemList = itemList;
    if (apiResponse.status != Status.completed) {
      apiResponse.status = Status.completed;
    }
    if (!isDisposed) notifyListeners();
  }

  void completeAndNotify() {
    if (apiResponse.status != Status.completed) {
      apiResponse.status = Status.completed;
    }
    if (!isDisposed) notifyListeners();
  }

  void setApiResponse(
    ApiResponse<dynamic> response, {
    bool stackData = false,
    bool addToList = false,
  }) {
    apiResponse = response;

    if (apiResponse.status == Status.completed) {
      if (response.data.runtimeType == List<T>) {
        if (stackData) {
          itemList.addAll(response.data);
        } else {
          itemList = response.data as List<T>;
        }
      } else if (response.data.runtimeType == T) {
        item = response.data as T;
        if (addToList) itemList.insert(0, item);
      } else {
        log('Unsupported api response type');
      }
    }

    if (!isDisposed) notifyListeners();
  }

  Future<ApiResponse> makeApiCall({
    required Future<dynamic> Function() apiCall,
    bool addToList = false,
    int page = 0,
    bool withoutLoading = false,
  }) async {
    if (page == 0 && !withoutLoading) setApiResponse(ApiResponse.loading());

    try {
      final data = await apiCall();
      setApiResponse(
        ApiResponse.completed(data: data),
        stackData: page != 0,
        addToList: addToList,
      );
    } catch (e, stackTrace) {
      log('Network error : $e');
      if (kDebugMode) print(stackTrace);
      setApiResponse(ApiResponse.error(message: e.toString()));
    }

    return apiResponse;
  }
}

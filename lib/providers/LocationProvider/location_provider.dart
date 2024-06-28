import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tima_app/ApiService/postApiBaseHelper.dart';
import 'package:tima_app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/core/constants/apiUrlConst.dart';
import 'package:tima_app/core/helper/permissionToUser.dart';

class LocationProvider extends ChangeNotifier with WidgetsBindingObserver {
  final SecureStorageService _secureStorageService = SecureStorageService();
  Position? initialPosition;
  final lat = ValueNotifier<double>(0.0);
  final lng = ValueNotifier<double>(0.0);
  final address = ValueNotifier<String>('Getting Address..');
  Timer? _timer;

  LocationProvider() {
    WidgetsBinding.instance.addObserver(this);
    initLocation();
    startTimer();
  }

  void initLocation() async {
    await GetPermissionToUser.permissionForLocation().then((value) async {
      initialPosition = await GetPermissionToUser.determinePosition();
    }).whenComplete(() {
      getPositionData();
      getAddressFromLatLang(initialPosition);
    });
  }

  void startTimer() async {
    final userId = _secureStorageService.getUserData(key: 'userId');
    _timer = Timer.periodic(const Duration(minutes: 5), (timer) async {
      var url = Uri.parse(updatecurrent_location_url);
      updateMap();
      var body = {
        "user_id": userId,
        "location": "${lat.value},${lng.value}",
      };
      await ApiBaseHelper().postAPICall(url, body);
    });
  }

  void updateMap() async {
    await GetPermissionToUser.permissionForLocation().then((value) async {
      initialPosition = await GetPermissionToUser.determinePosition();
    }).whenComplete(() {
      getPositionData();
      getAddressFromLatLang(initialPosition);
    });
  }

  void getPositionData() async {
    if (initialPosition != null) {
      lat.value = initialPosition!.latitude;
      lng.value = initialPosition!.longitude;
    }
  }

  Future<void> getAddressFromLatLang(Position? position) async {
    if (position != null) {
      List<Placemark> placemark =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemark[0];
      address.value =
          'Address : ${place.street},${place.subLocality},${place.locality},${place.country}';
      notifyListeners();
    }
  }

  void stopTimer() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    stopTimer();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    var appStatus = "";
    if (state == AppLifecycleState.resumed) {
      appStatus = "active";
      sendAppStatusToServer(appStatus);
    }
    if (state == AppLifecycleState.paused) {
      appStatus = "minimize";
      sendAppStatusToServer(appStatus);
    }
    if (state == AppLifecycleState.inactive) {
      appStatus = "minimize";
      sendAppStatusToServer(appStatus);
    }
    if (state == AppLifecycleState.detached) {
      appStatus = "logout";
      sendAppStatusToServer(appStatus);
    }
  }

  void sendAppStatusToServer(appStatus) async {
    final userId = await _secureStorageService.getUserData(key: 'userId');
    var url = Uri.parse(set_user_app_status_url);
    var body = {
      "user_id": userId,
      "app_status": appStatus,
    };
    await ApiBaseHelper().postAPICall(url, body);
  }
}

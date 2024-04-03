import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frequency_app/presentation/presentation.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:wifi_scan/wifi_scan.dart';

import '../../domain/domain.dart';
import '../../ui/ui.dart';

class GetxHomePresenter extends GetxController with LoadingManager, UIErrorManagerPresenter, FormManager implements HomePresenter {
  final LoadCurrentAccount loadCurrentAccount;
  final DeleteAccount deleteAccount;
  final Validation validation;
  final ClassroomUsecase classroomUsecase;
  final WifiInformationUsecase wifiInformationUsecase;

  GetxHomePresenter(
      {required this.loadCurrentAccount, required this.deleteAccount, required this.validation, required this.classroomUsecase, required this.wifiInformationUsecase});

  String? _codeClass;
  Rx<bool>? isSameBluetooth = false.obs;

  @override
  Rx<UserType?> userType = Rx(null);

  @override
  RxInt currentPageIndex = 0.obs;

  @override
  Rx<AccountEntity?> accountEntity = Rx(null);

  @override
  Rx<AulaEntity?> aulaEntity = Rx(null);

  @override
  Rxn<UIError?> codeClassError = Rxn<UIError?>();

  Rx<WifiClassConfirmationEntity?> wifiInfoClass = Rx(null);

  Rx<double?> currentLat = Rx(null);
  Rx<double?> currentLong = Rx(null);

  @override
  Rx<List<AulaEntity>?> aulas = Rx(null);

  @override
  void onInit() async {
    await loadUserInfo();
    super.onInit();
  }

  Future<void> loadUserInfo() async {
    isSetLoading = true;

    accountEntity.value = await loadCurrentAccount.loadUserEntity();

    if (accountEntity.value != null) {
      userType.value = accountEntity.value?.tipo?.contains('aluno') == true ? UserType.aluno : UserType.professor;
      if (userType.value == UserType.professor) {
        await _loadAulasByIdProfessor();
      }
    }

    await requestLocationPermition();
    isSetLoading = false;
  }

  Future<void> _loadAulasByIdProfessor() async {
    try {
      isSetLoading = true;
      if (accountEntity.value != null) {
        aulas.value = await classroomUsecase.loadAulaByUsuario(accountEntity.value!.id!);

        aulas.value = aulas.value?.where((aula) => aula.finalizada != true).toList();

        if (aulas.value != null) {
          DateTime dataAtual = DateTime.now();
          dataAtual = DateTime(dataAtual.year, dataAtual.month, dataAtual.day);

          // Filtrando apenas as datas iguais ou posteriores à data atual
          aulas.value = aulas.value?.where((data) => !data.dataAula!.isBefore(dataAtual)).toList();
        }
        _sortedByMostRecent();
      }
      isSetLoading = false;
    } catch (e) {
      Exception(e);
    }
  }

  void _sortedByMostRecent() {
    final dateNow = DateTime.now();
    if (aulas.value != null) {
      aulas.value?.sort((a, b) {
        final list1 = dateNow.difference(a.dataAula!).inDays.abs();
        final list2 = dateNow.difference(b.dataAula!).inDays.abs();
        return list1.compareTo(list2);
      });
    }
  }

  @override
  Future<void> logout() async {
    try {
      isSetLoading = true;
      Get.defaultDialog(
        backgroundColor: Colors.white,
        title: '',
        radius: 15,
        barrierDismissible: false,
        content: const Column(
          children: [
            SizedBox(height: 30, width: 30, child: CircularProgressIndicator(strokeWidth: 2, color: AppColor.bluegreen600)),
            SizedBox(height: 20),
            Text('Saindo...', style: TextStyle(fontWeight: FontWeight.w600, color: AppColor.bluegreen600))
          ],
        ),
      );
      deleteAccount.deleteLocalAccount();

      await Future.delayed(const Duration(seconds: 2));

      Get.back();

      Get.offAllNamed('/login');

      isSetLoading = false;
    } on DomainError catch (error) {
      isSetMainError = null;
      switch (error) {
        default:
          isSetMainError = UIError.unexpected;
          break;
      }
      isSetLoading = false;
    }
  }

  Future<void> requestLocationPermition() async {
    try {
      Location location = Location();

      bool serviceEnabled;

      serviceEnabled = await location.serviceEnabled();

      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return;
        }
      }
    } on DomainError catch (error) {
      isSetMainError = null;
      switch (error) {
        default:
          isSetMainError = UIError.unexpected;
          break;
      }
      isSetLoading = false;
    }
  }

  @override
  Future<void> requestClassByCode() async {
    try {
      isSetLoading = true;
      aulaEntity.value = null;
      aulaEntity.value = await classroomUsecase.getClassByCode(_codeClass!, accountEntity.value!.id!);
      if (aulaEntity.value != null) {
        wifiInfoClass.value = await wifiInformationUsecase.getNetworkInformationByIdClass(aulaEntity.value!.id!);
        if (wifiInfoClass.value != null) {
          Get.to(() => const ClassResultPage());
        }
        isSetLoading = false;
      } else {
        isSetLoading = false;
        isSetMainError = UIError.classNotFound;
      }
      isSetLoading = false;
    } on DomainError catch (error) {
      isSetMainError = null;
      switch (error) {
        default:
          isSetMainError = UIError.unexpected;
          break;
      }
      isSetLoading = false;
    }
  }

  @override
  Future<void> teste() async {
    isSetLoading = true;
    // String? bluetoothName;
    // String? bluetoothAddress;

    try {
      final bluetoothState = FlutterBluePlus.isSupported;
      await FlutterBluePlus.turnOn();
      // await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5), androidUsesFineLocation: false);

      final deviceName = await FlutterBluePlus.adapterName; // Nome do bluetooth

      // var localDevice = devices.first;
      // bluetoothName = localDevice.name;
      // bluetoothAddress = localDevice.id.id;
      // } else {
      //   bluetoothName = 'No connected devices';
      //   bluetoothAddress = 'N/A';
      // }
    } catch (e) {}
    // await FlutterBluePlus.connectedDevices.then((value) => value.firstWhere((element) => element.id.));
    // await FlutterBluePlus.turnOn();
    // await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5), androidUsesFineLocation: false);

    // await FlutterBluePlus.stopScan();

    isSetLoading = false;
  }

  Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;

  @override
  void validateCodeClass(String codeClass) {
    _codeClass = codeClass.toUpperCase();
    codeClassError.value = _validateField('codeClass');
    _validateForm();
  }

  UIError? _validateField(String field) {
    final formData = {'codeClass': _codeClass};
    final error = validation.validate(field: field, input: formData);
    switch (error) {
      case ValidationError.invalidField:
        return UIError.invalidField;
      case ValidationError.requiredField:
        return UIError.requiredField;
      default:
        return null;
    }
  }

  void _validateForm() => setFormValid = codeClassError.value == null && _codeClass != null;

  @override
  Future<void> confirmPresence() async {
    try {
      isSetLoading = true;
      bool? similarList = await checkWifi();
      bool? inClassLocation = await checkLocation();

      RxBool isPresent = false.obs;
      if (inClassLocation == true && similarList == true) {
        isPresent.value = true;
      } else {
        isPresent.value = false;
      }
      // await checkBuetooth();
      // await Future.delayed(const Duration(seconds: 3));
      isSetLoading = false;

      if (isPresent.value) {
        FrequencyEntity frequencyEntity = FrequencyEntity(
          id: null,
          latitude: currentLat.toString(),
          longitude: currentLong.toString(),
          dataHoraConfirmacao: DateTime.now(),
          idAluno: accountEntity.value?.id,
          idAula: aulaEntity.value?.id,
          presente: isPresent.value,
        );

        await classroomUsecase.confirmPresence(frequencyEntity);
      }
      Get.dialog(AlertDialog(
        title: SvgPicture.asset('assets/icons/check-square.svg', color: isPresent.value ? Colors.green : Colors.red, height: 50),
        backgroundColor: AppColor.bluegreen.withOpacity(0.8),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              isPresent.value ? 'Presença confirmada' : 'Sua informações não estão dentro do perímetro da aula',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => Get.back(),
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(AppColor.grey100),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
                overlayColor: MaterialStatePropertyAll(AppColor.grey500),
                padding: MaterialStatePropertyAll((EdgeInsets.symmetric(vertical: 15, horizontal: 10))),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Fechar', style: TextStyle(color: AppColor.bluegreen600, fontSize: 18)),
                ],
              ),
            )
          ],
        ),
      ));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool?> checkWifi() async {
    try {
      Rx<List<WiFiAccessPoint>> accessPoints = Rx([]);
      Rx<List<String>> listSSID = Rx([]);
      listSSID.value.clear();

      final can = await WiFiScan.instance.canStartScan(askPermissions: true);
      if (can == CanStartScan.yes) {
        await WiFiScan.instance.startScan();

        accessPoints.value = await WiFiScan.instance.getScannedResults();

        accessPoints.value.map((e) => e.level);
        accessPoints.value.where((element) => element.level > (-80)).toList();
        listSSID.value.addAll(accessPoints.value.map((e) => e.ssid));
        listSSID.value.removeWhere((element) => element.isEmpty);

        bool ssid1 = listSSID.value.contains(wifiInfoClass.value?.ssid1);
        bool ssid2 = listSSID.value.contains(wifiInfoClass.value?.ssid2);
        bool ssid3 = listSSID.value.contains(wifiInfoClass.value?.ssid3);

        List<bool> list = [ssid1, ssid2, ssid3];

        return list.where((element) => element == true).length >= 2;
      }
    } on DomainError catch (error) {
      isSetMainError = null;
      switch (error) {
        default:
          isSetMainError = UIError.unexpected;
          break;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool?> checkBuetooth() async {
    try {
      await FlutterBluePlus.turnOn();
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));

      FlutterBluePlus.scanResults.listen((results) {
        // print(results.map((e) => e.device.platformName));
        // print(results.map((element) => print(element.advertisementData.localName)));
        isSameBluetooth?.value = results.any((element) => element.advertisementData.localName == aulaEntity.value?.nomeBluetooth);
      });
      return isSameBluetooth?.value;
    } catch (e) {}
  }

  Future<bool?> checkLocation() async {
    try {
      Location location = Location();
      PermissionStatus permissionGranted;
      LocationData locationData;
      double latitudeClass = double.parse(aulaEntity.value?.latitude ?? '0');
      double longitudeClass = double.parse(aulaEntity.value?.longitude ?? '0');
      // print("LOCALIZACAO AULAAA----------------------------------------------");

      // print(latitudeClass);
      // print(longitudeClass);
      // print("----------------------------------------------------------------");

      permissionGranted = await location.hasPermission();

      if (permissionGranted == PermissionStatus.denied || permissionGranted != PermissionStatus.granted) {
        permissionGranted = await location.requestPermission();
      } else {
        locationData = await location.getLocation();
        // print("SUA LOCALIZACAO----------------------------------------------");

        currentLat.value = locationData.latitude;
        currentLong.value = locationData.longitude;

        const int earthRadius = 6371000; // Raio da Terra em metros
        double dLat = (currentLat.value! - latitudeClass) * (3.141592653589793 / 180);
        double dLon = (currentLong.value! - longitudeClass) * (3.141592653589793 / 180);
        double a =
            sin(dLat / 2) * sin(dLat / 2) + cos(latitudeClass * (3.141592653589793 / 180)) * cos(currentLat.value! * (3.141592653589793 / 180)) * sin(dLon / 2) * sin(dLon / 2);
        double c = 2 * atan2(sqrt(a), sqrt(1 - a));
        double distance = earthRadius * c;
        // print("distance -----------------------------------------------------");
        // print(distance);

        String message = distance < 12 ? 'As localizações estão próximas.' : 'As localizações estão distantes.';
        // print(message);

        return distance < 12;
      }
    } on DomainError catch (error) {
      isSetMainError = null;
      switch (error) {
        default:
          isSetMainError = UIError.unexpected;
          break;
      }
    }
  }
}

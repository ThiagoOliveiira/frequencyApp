import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:wifi_scan/wifi_scan.dart';

import '../../domain/domain.dart';
import '../../ui/ui.dart';
import '../mixins/mixins.dart';

class GetxClassroomPresenter extends GetxController with LoadingManager, UIErrorManagerPresenter, FormManager implements ClassroomPresenter {
  final ClassroomUsecase classroomUsecase;
  final LoadCurrentAccount loadCurrentAccount;
  final WifiInformationUsecase wifiInformationUsecase;

  GetxClassroomPresenter({required this.classroomUsecase, required this.loadCurrentAccount, required this.wifiInformationUsecase});

  @override
  Rx<AccountEntity?> accountEntity = Rx(null);

  @override
  Rx<List<AulaEntity>?> aulaEntity = Rx(null);

  @override
  Rx<List<AulaEntity>?> aulaNotClosed = Rx(null);

  @override
  Rx<List<AulaEntity>?> aulaClosed = Rx(null);

  @override
  void onInit() async {
    await loadUserInfo();
    await _loadAulasByIdProfessor();
    super.onInit();
  }

  Future<void> loadUserInfo() async {
    try {
      isSetLoading = true;
      accountEntity.value = await loadCurrentAccount.loadUserEntity();
      isSetLoading = false;
    } catch (e) {
      Exception(e);
    }
  }

  Future<void> _loadAulasByIdProfessor() async {
    try {
      isSetLoading = true;
      if (accountEntity.value != null) {
        aulaEntity.value = await classroomUsecase.loadAulaByUsuario(accountEntity.value!.id!);

        aulaNotClosed.value = aulaEntity.value?.where((aula) => aula.finalizada != true).toList();
        aulaClosed.value = aulaEntity.value?.where((aula) => aula.finalizada == true).toList();

        await _sortedByMostRecentFinished();
        _sortedByMostRecent();
      }
      isSetLoading = false;
    } catch (e) {
      Exception(e);
    }
  }

  @override
  Future<AulaEntity?> getPositionFixed(AulaEntity? aulaEntity) async {
    Location location = Location();
    PermissionStatus permissionGranted;
    LocationData locationData;

    permissionGranted = await location.hasPermission();

    if (permissionGranted == PermissionStatus.denied || permissionGranted != PermissionStatus.granted) {
      permissionGranted = await location.requestPermission();
    } else {
      locationData = await location.getLocation();

      return AulaEntity.copy(aulaEntity, latitude: locationData.latitude.toString(), longitude: locationData.longitude.toString());
    }
  }

  @override
  Future<void> startClass(AulaEntity? aulaEntity) async {
    try {
      isSetLoading = true;

      if (aulaEntity != null) {
        final bluetoothState = FlutterBluePlus.isSupported;
        await FlutterBluePlus.turnOn();

        final deviceName = await FlutterBluePlus.adapterName; // Nome do bluetooth
        var aulaData = await getPositionFixed(aulaEntity);
        var aula = AulaEntity.copy(aulaData, iniciada: true, nomeBluetooth: deviceName);
        await classroomUsecase.startClass(aula);
        WifiClassConfirmationEntity? wifiList = await getWifiNetworks(aulaEntity.id);
        if (wifiList != null) {
          await wifiInformationUsecase.saveNetworkInformation(wifiList);
        }

        await _loadAulasByIdProfessor();

        Get.to(() => ClassroomCodePage(aulaEntity: aula));
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
  Future<void> endClass(AulaEntity? aulaEntity) async {
    try {
      isSetLoading = true;
      if (aulaEntity != null) {
        await classroomUsecase.endClass(AulaEntity.copy(aulaEntity, finalizada: true));
        await _loadAulasByIdProfessor();
        // await classroomUsecase.loadAulaByUsuario(accountEntity.value!.id!);
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
  Future<WifiClassConfirmationEntity?> getWifiNetworks(int? aulaId) async {
    try {
      Rx<List<WiFiAccessPoint>> accessPoints = Rx([]);
      Rx<List<String>> listSSID = Rx([]);
      listSSID.value.clear();

      final can = await WiFiScan.instance.canStartScan(askPermissions: true);
      if (can == CanStartScan.yes) {
        await WiFiScan.instance.startScan();

        accessPoints.value = await WiFiScan.instance.getScannedResults();
      }

      listSSID.value.addAll(accessPoints.value.map((e) => e.ssid));

      listSSID.value.removeWhere((element) => element.isEmpty);

      return WifiClassConfirmationEntity(ssid1: listSSID.value.first, ssid2: listSSID.value[1], ssid3: listSSID.value.last, aulaId: aulaId, id: null);
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

  void _sortedByMostRecent() {
    final dateNow = DateTime.now();
    if (aulaClosed.value != null) {
      aulaClosed.value?.sort((a, b) {
        final list1 = dateNow.difference(a.dataAula!).inDays.abs();
        final list2 = dateNow.difference(b.dataAula!).inDays.abs();
        return list1.compareTo(list2);
      });
    }
  }

  Future<void> _sortedByMostRecentFinished() async {
    final dateNow = DateTime.now();
    if (aulaNotClosed.value != null) {
      aulaNotClosed.value?.sort((a, b) {
        final list1 = dateNow.difference(a.dataAula!).inDays.abs();
        final list2 = dateNow.difference(b.dataAula!).inDays.abs();
        return list1.compareTo(list2);
      });
    }
  }
}

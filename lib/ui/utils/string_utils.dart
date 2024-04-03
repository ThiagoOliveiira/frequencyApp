String? handleDataTimeDay(DateTime? dataAula, {bool? iniciada, bool? finalizada}) {
  DateTime currentDay = DateTime.now();
  currentDay = DateTime(currentDay.year, currentDay.month, currentDay.day);

  if (dataAula != null) {
    if (iniciada == true && finalizada != true) {
      return 'Iniciada';
    } else if (finalizada == true) {
      return 'Encerrada';
    } else {
      if (dataAula.difference(currentDay).inDays == 0) {
        return 'Hoje';
      } else {
        return 'Dia ${handleDate(dataAula.day)}/${handleDate(dataAula.month)}';
      }
    }
  }
  return null;
}

String? handleDate(int? info) {
  if (info != null) {
    if (info >= 0 && info <= 9) {
      return '0$info';
    }
    return info.toString();
  }
  return null;
}

String? handleDataTimeHour(DateTime? dataAula) {
  int currentHour = DateTime.now().hour;

  return '${dataAula?.hour}:${dataAula?.minute == 0 ? '${dataAula?.minute}0' : dataAula?.minute}';
}

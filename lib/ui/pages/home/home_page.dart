import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../ui.dart';

class HomePage extends StatelessWidget {
  final HomePresenter presenter;
  const HomePage({super.key, required this.presenter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const DefaultBottomNavigationBar(currentPageIndex: 0),
      appBar: AppBar(
        title: const Text('Oi, Thiago.', style: TextStyle(color: AppColor.bluegreen600, fontSize: 18, fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(50),
              splashColor: AppColor.bege,
              child: SvgPicture.asset('assets/icons/logout.svg', color: AppColor.bluegreen),
            ),
          ),
        ],
      ),
      body: presenter.userType == UserType.aluno
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  const Text('Informe o código da aula', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColor.bluegreen)),
                  const SizedBox(height: 10),
                  const TextField(
                    decoration: InputDecoration(
                      isDense: true,
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: AppColor.bluegreen), borderRadius: BorderRadius.all(Radius.circular(15))),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: AppColor.bluegreen), borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(AppColor.bluegreen),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
                      overlayColor: MaterialStatePropertyAll(AppColor.bluegreen600),
                      padding: MaterialStatePropertyAll((EdgeInsets.symmetric(vertical: 15, horizontal: 10))),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Confirmar', style: TextStyle(color: AppColor.white, fontSize: 18)),
                      ],
                    ),
                  ),
                  const SizedBox(height: kBottomNavigationBarHeight),
                ],
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [],
            ),
    );
  }
}

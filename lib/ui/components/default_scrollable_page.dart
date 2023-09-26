import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';

class DefaultScrollablePage extends StatelessWidget {
  final Widget? bottomNavigationBar;
  final Widget child;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final bool? extendBodyBehindAppBar;
  DefaultScrollablePage({super.key, required this.child, this.bottomNavigationBar, this.appBar, this.backgroundColor, this.extendBodyBehindAppBar});
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return KeyboardSizeProvider(
      child: Scaffold(
        extendBodyBehindAppBar: extendBodyBehindAppBar ?? false,
        appBar: appBar,
        bottomNavigationBar: bottomNavigationBar,
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: true,
        body: Consumer<ScreenHeight>(
          builder: (_, res, __) {
            if (!res.isOpen) {
              if (Platform.isAndroid) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
              if (_scrollController.hasClients) {
                _scrollController.animateTo(_scrollController.initialScrollOffset, duration: const Duration(milliseconds: 300), curve: Curves.linear);
              }
            }
            return SingleChildScrollView(controller: _scrollController, physics: res.isOpen ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(), child: child);
          },
        ),
      ),
    );
  }
}

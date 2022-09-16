// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noonpool_web/controller/app_bar_controller.dart';
import 'package:noonpool_web/helpers/network_helper.dart';
import 'package:noonpool_web/helpers/shared_preference_util.dart';
import 'package:noonpool_web/main.dart';
import 'package:noonpool_web/models/user_secret.dart';
import 'package:noonpool_web/routing/app_router.gr.dart';
import 'package:noonpool_web/widgets/error_widget.dart';

class Update2FA extends StatefulWidget {
  const Update2FA({
    Key? key,
  }) : super(key: key);

  @override
  State<Update2FA> createState() => _Update2FAState();
}

class _Update2FAState extends State<Update2FA> {
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, getData);
  }

  getData() async {
    Get.find<AppBarController>().updateIsRefreshing(true);

    if (AppPreferences.loginStatus) {
      setState(() {
        _isLoading = true;
        _hasError = false;
      });
      try {
        UserSecret userSecret = await get2FAStatus(id: AppPreferences.userId);
        if (userSecret.isSecret != null && userSecret.loginKey != null) {
          if (userSecret.loginKey == AppPreferences.currentLoginKey) {
            AppPreferences.set2faSecurityStatus(
                isEnabled: userSecret.isSecret!);
            _hasError = false;
            Get.find<AppBarController>().updateIsRefreshing(false);
            context.router.replace(const HomeBody());
          } else {
            AppPreferences.setLoginStatus(status: false);
            _hasError = false;
            Get.find<AppBarController>()
                .updateLoginStatus(AppPreferences.loginStatus);
            Get.find<AppBarController>().updateIsRefreshing(false);
            context.router.replaceAll(const [HomeBody(), LoginRoute()]);
          }
        } else {
          _hasError = true;
          throw AppLocalizations.of(context)!
              .anErrorOccurredPleaseRefreshThePage;
        }
      } catch (exception) {
        MyApp.scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(
            content: Text(
              exception.toString(),
            ),
          ),
        );
        _hasError = true;
      }
      setState(() {
        _isLoading = false;
      });
    } else {
      AppPreferences.set2faSecurityStatus(isEnabled: false);
      Get.find<AppBarController>().updateIsRefreshing(false);
      context.router.replace(const HomeBody());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: buildBody());
  }

  buildProgressBar() {
    return const Center(
      child: SizedBox(
        height: 50,
        width: 50,
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }

  Widget buildBody() {
    return _isLoading
        ? buildProgressBar()
        : _hasError
            ? CustomErrorWidget(
                error: AppLocalizations.of(context)!
                    .anErrorOccurredWithTheDataFetchPleaseTryAgain,
                onRefresh: () {
                  getData();
                })
            : const SizedBox();
  }
}

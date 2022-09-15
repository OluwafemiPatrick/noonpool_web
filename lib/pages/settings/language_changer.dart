import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:noonpool_web/constants/style.dart';
import 'package:noonpool_web/controller/locale_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageChanger extends StatefulWidget {
  const LanguageChanger({Key? key}) : super(key: key);

  @override
  State<LanguageChanger> createState() => _LanguageChangerState();
}

class _LanguageChangerState extends State<LanguageChanger> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!;
    final bodyText2 = textTheme.bodyText2!;
    const spacer = SizedBox(
      height: kDefaultMargin,
    );

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          buildAppBar(bodyText1),
          Expanded(
            child: GetX<LocaleController>(
              builder: (controller) {
                final allLocales = appLocales(context);
                return ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(10),
                  children: [
                    spacer,
                    Center(
                      child: Lottie.asset('assets/lottie/language.json',
                          width: 180,
                          animate: true,
                          reverse: true,
                          repeat: true,
                          height: 150,
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.center),
                    ),
                    spacer,
                    ...allLocales
                        .map(
                          (appLocale) => Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Divider(),
                              ListTile(
                                contentPadding: const EdgeInsets.all(0),
                                onTap: () {
                                  controller
                                      .updateCurrentLocale(appLocale.locale);
                                },
                                trailing: Checkbox(
                                  value: controller.locale.value ==
                                      appLocale.locale,
                                  onChanged: (bool? value) {
                                    if (value == null) {
                                      return;
                                    } else if (value) {
                                      controller.updateCurrentLocale(
                                          appLocale.locale);
                                    }
                                  },
                                ),
                                title: Text(
                                  "${appLocale.rawName} ${appLocale.translatedName}",
                                  style: bodyText2,
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                    spacer,
                    spacer
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(TextStyle? bodyText1) {
    return AppBar(
      elevation: 0,
      leading: null,
      centerTitle: false,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      title: Text(
        AppLocalizations.of(context)!.language,
        style: bodyText1,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:noonpool_web/constants/style.dart';
import 'package:noonpool_web/helpers/network_helper.dart';
import 'package:noonpool_web/main.dart';
import 'package:noonpool_web/models/recieve_data/recieve_data.dart';
import 'package:noonpool_web/models/wallet_data/datum.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noonpool_web/widgets/error_widget.dart';
import 'package:clipboard/clipboard.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReceiveAssets extends StatefulWidget {
  final WalletDatum walletDatum;
  const ReceiveAssets({Key? key, required this.walletDatum}) : super(key: key);

  @override
  State<ReceiveAssets> createState() => _ReceiveAssetsState();
}

class _ReceiveAssetsState extends State<ReceiveAssets> {
  RecieveData recieveData = RecieveData();
  bool _isLoading = true;
  bool _hasError = false;
  @override
  initState() {
    super.initState();
    Future.delayed(Duration.zero, getData);
  }

  getData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      recieveData = await walletData(walletDatum: widget.walletDatum);

      _hasError = false;
    } catch (exception) {
      _hasError = true;
      MyApp.scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(
            exception.toString(),
          ),
        ),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyText2 = textTheme.bodyMedium;
    final bodyText1 = textTheme.bodyLarge;
    return _isLoading
        ? buildProgressBar()
        : _hasError
            ? CustomErrorWidget(
                error: AppLocalizations.of(context)!
                    .anErrorOccurredWithTheDataFetchPleaseTryAgain,
                onRefresh: () {
                  getData();
                })
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppBar(
                    elevation: 0,
                    centerTitle: false,
                    backgroundColor: Colors.transparent,
                    title: Text(
                      '${AppLocalizations.of(context)!.receive} ${widget.walletDatum.coinSymbol}',
                      style: bodyText1?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    leading: null,
                    automaticallyImplyLeading: false,
                  ),
                  buildQrCode(bodyText2),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    '${AppLocalizations.of(context)!.youShouldOnlySend} ${widget.walletDatum.coinName} (${widget.walletDatum.coinSymbol}) ${AppLocalizations.of(context)!.toThisAddressSendingAnyOtherCoinsMayResultInPermanentLoss}',
                    textAlign: TextAlign.center,
                    style: bodyText2,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  buildBottomControllers()
                ],
              );
  }

  buildProgressBar() {
    return const Center(
      child: SizedBox(
        height: 50,
        width: 50,
        child: CircularProgressIndicator.adaptive(
          backgroundColor: kLightBackgroud,
        ),
      ),
    );
  }

  Row buildBottomControllers() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        RoundedIconWithTitle(
            title: AppLocalizations.of(context)!.copy,
            icon: Icons.copy_rounded,
            onPressed: () async {
              try {
                await FlutterClipboard.copy(
                    recieveData.coinInfo?.address ?? '');
                () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        AppLocalizations.of(context)!
                            .walletAddressHasBeenCopiedToYourClipboard,
                      ),
                    ),
                  );
                }();
              } catch (exception) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      exception.toString(),
                    ),
                  ),
                );
              }
            }),
      ],
    );
  }

  Card buildQrCode(TextStyle? bodyText2) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            QrImageView(
              data: recieveData.coinInfo?.address ?? '',
              version: QrVersions.auto,
              size: 250,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              recieveData.coinInfo?.address ?? '',
              textAlign: TextAlign.center,
              style: bodyText2,
            ),
          ],
        ),
      ),
    );
  }
}

class RoundedIconWithTitle extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  const RoundedIconWithTitle({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyText2 = textTheme.bodyMedium;

    return InkWell(
      onTap: onPressed,
      splashColor: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kPrimaryColor.withOpacity(.05),
            ),
            child: Icon(
              icon,
              size: 30,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: bodyText2,
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:noonpool_web/constants/style.dart';
import 'package:noonpool_web/helpers/network_helper.dart';
import 'package:noonpool_web/helpers/shared_preference_util.dart';
import 'package:noonpool_web/main.dart';
import 'package:noonpool_web/models/send_creation_model/send_creation_model.dart';
import 'package:noonpool_web/models/wallet_data/datum.dart';
import 'package:noonpool_web/routing/app_router.gr.dart';

import 'package:noonpool_web/widgets/elevated_button.dart';
import 'package:noonpool_web/widgets/error_widget.dart';
import 'receipt_detail_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SendAsset extends StatefulWidget {
  final WalletDatum assetDatum;
  final String recipientAddress;
  final double amount;

  const SendAsset(
      {Key? key,
      required this.assetDatum,
      required this.recipientAddress,
      required this.amount})
      : super(key: key);

  @override
  State<SendAsset> createState() => _SendAssetState();
}

class _SendAssetState extends State<SendAsset> {
  bool _isLoading = false;
  bool _isFetchingPrice = true;
  bool _priceFetchHasError = false;

  SendCreationModel sendCreationModel = SendCreationModel();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, getData);
  }

  getData() async {
    setState(() {
      _isFetchingPrice = true;
      _priceFetchHasError = false;
    });

    try {
      final reciever = widget.recipientAddress;
      final network = widget.assetDatum.coinSymbol ?? '';
      final amount = widget.amount;
      sendCreationModel = await createSendTransaction(
        reciever: reciever,
        amount: amount,
        network: network,
      );
      _priceFetchHasError = false;
    } catch (exception) {
      MyApp.scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(
            exception.toString(),
          ),
        ),
      );
      _priceFetchHasError = true;
    }

    setState(() {
      _isFetchingPrice = false;
    });
  }

  void showConfirmationDialog() async {
    if (_isLoading) {
      return;
    }
    final action = await confirmTransaction();
    if (action != null && action) {
      if (AppPreferences.get2faSecurityEnabled) {
        context.router.push(
          VerifyOtpRoute(
              onNext: (_) => showSendAssetStatus(), id: AppPreferences.userId),
        );
      } else {
        showSendAssetStatus();
      }
    }
  }

  Future showSendAssetStatus() async {
    final network = widget.assetDatum.coinSymbol ?? '';

    setState(() {
      _isLoading = true;
    });
    try {
      await sendFromWallet(
        creationModel: sendCreationModel,
        network: network,
      );
      await showMessage(
        AppLocalizations.of(context)!.yourTransactionWasSentSuccessfully,
      );
      () {
        Navigator.of(context).pop();
      }();
    } catch (exception) {
      await showMessage(
        exception.toString(),
      );
      () {
        Navigator.of(context).pop();
      }();
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<bool?> confirmTransaction() async {
    return showDialog<bool>(
      context: context,
      useRootNavigator: false,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.transactionConfirmation),
          content: Text(AppLocalizations.of(context)!
              .doYouWantToTransferThisAmountToTheSelectedAddress),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.cancel),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text(AppLocalizations.of(context)!.confirm),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            )
          ],
        );
      },
    );
  }

  showMessage(String message) async {
    return showDialog(
      context: context,
      useRootNavigator: false,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.transactionStatus),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.confirm),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
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

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!;
    final bodyText2 = textTheme.bodyText2!;

    return _isFetchingPrice
        ? buildProgressBar()
        : _priceFetchHasError
            ? CustomErrorWidget(
                error: AppLocalizations.of(context)!
                    .anErrorOccurredWithTheDataFetchPleaseTryAgain,
                onRefresh: () {
                  getData();
                })
            : buildBody(bodyText1, bodyText2);
  }

  Column buildBody(TextStyle bodyText1, TextStyle bodyText2) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            '${AppLocalizations.of(context)!.send} ${widget.assetDatum.coinSymbol}',
            style: bodyText1.copyWith(fontWeight: FontWeight.bold),
          ),
          leading: null,
          centerTitle: false,
          automaticallyImplyLeading: false,
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            '-${widget.amount} ${widget.assetDatum.coinSymbol}',
            style:
                bodyText2.copyWith(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        ReceiptDetailsTab(
            heading: AppLocalizations.of(context)!.asset,
            tailingText:
                "${widget.assetDatum.coinName} (${widget.assetDatum.coinSymbol})"),
        ReceiptDetailsTab(
            heading: AppLocalizations.of(context)!.to,
            tailingText: sendCreationModel.reciepient ?? ''),
        ReceiptDetailsTab(
            heading: AppLocalizations.of(context)!.noonPoolFee,
            tailingText:
                '-${sendCreationModel.fee} ${widget.assetDatum.coinSymbol}'),
        ReceiptDetailsTab(
            heading: AppLocalizations.of(context)!.totalAmount,
            tailingText:
                '-${widget.amount - (double.tryParse(sendCreationModel.fee ?? '0.0') ?? 0)} ${widget.assetDatum.coinSymbol}'),
        const SizedBox(
          height: 40,
        ),
        CustomElevatedButton(
          onPressed: showConfirmationDialog,
          widget: _isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white,
                  ),
                )
              : Text(
                  AppLocalizations.of(context)!.confirm,
                  style: bodyText2.copyWith(color: Colors.white),
                ),
        ),
      ],
    );
  }
}

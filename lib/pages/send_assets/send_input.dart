import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:noonpool_web/models/wallet_data/datum.dart';
import 'package:noonpool_web/routing/app_router.gr.dart';
import 'package:noonpool_web/widgets/outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SendInputScreen extends StatefulWidget {
  final WalletDatum walletDatum;
  const SendInputScreen({Key? key, required this.walletDatum})
      : super(key: key);

  @override
  State<SendInputScreen> createState() => _SendInputScreenState();
}

class _SendInputScreenState extends State<SendInputScreen> {
  final _formKey = GlobalKey<FormState>();

  static const _recipientAddress = "recipientAddress";
  static const _amount = "amount";

  final _recipientAddressController = TextEditingController(text: '');
  final _amountTextController = TextEditingController(text: '');

  final _amountFocusNode = FocusNode();
  final Map<String, dynamic> _initValues = {_recipientAddress: '', _amount: ''};

  @override
  void dispose() {
    _amountFocusNode.dispose();
    _recipientAddressController.dispose();
    _amountTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _recipientAddressController.addListener(() {
      _initValues[_recipientAddress] = _recipientAddressController.text;
    });
    _amountTextController.addListener(() {
      _initValues[_amount] = _amountTextController.text;
    });
  }

  void _saveForm() async {
    final isValid = _formKey.currentState?.validate();
    if ((isValid ?? false) == false) {
      return;
    }

    _formKey.currentState?.save();
    showSendAssetStatus();
  }

  Future showSendAssetStatus() async {
    final reciever = _initValues[_recipientAddress] ?? '';
    final amount = double.tryParse(_initValues[_amount] ?? '') ?? 0;
    context.router.push(SendAsset(
      assetDatum: widget.walletDatum,
      recipientAddress: reciever,
      amount: amount,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!;
    final bodyText2 = textTheme.bodyText2!;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              '${AppLocalizations.of(context)!.send} ${widget.walletDatum.coinSymbol}',
              style: bodyText1.copyWith(fontWeight: FontWeight.bold),
            ),
            leading: null,
            centerTitle: false,
            automaticallyImplyLeading: false,
          ),
          const SizedBox(
            height: 20,
          ),
          ...buildRecipientField(bodyText2),
          const SizedBox(
            height: 20,
          ),
          ...buildAmountField(bodyText2),
          const SizedBox(
            height: 40,
          ),
          buildContinueButton()
        ],
      ),
    );
  }

  List<Widget> buildAmountField(TextStyle bodyText2) {
    return [
      TextFormField(
        textInputAction: TextInputAction.done,
        focusNode: _amountFocusNode,
        controller: _amountTextController,
        style: bodyText2,
        decoration: InputDecoration(
          labelText:
              '${AppLocalizations.of(context)!.amount} ${widget.walletDatum.coinSymbol}',
          suffixIcon: TextButton(
            onPressed: () {
              _amountTextController.text =
                  (widget.walletDatum.balance ?? 0).toString();
            },
            child: Text(
              '${AppLocalizations.of(context)!.max} ${widget.walletDatum.coinSymbol}',
              style: bodyText2.copyWith(
                fontSize: 12,
              ),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
        keyboardType: TextInputType.number,
        validator: (value) {
          final parsedDouble = double.tryParse(value ?? '');
          if (value == null || value.isEmpty) {
            return AppLocalizations.of(context)!.pleaseProvideTheAmount;
          } else if (parsedDouble == null || parsedDouble == 0) {
            return AppLocalizations.of(context)!.pleaseEnterAValidAmount;
          } else if (parsedDouble > (widget.walletDatum.balance ?? 0)) {
            return AppLocalizations.of(context)!
                .youCanNotSendMoreThanYouPresentlyHave;
          }
          return null;
        },
      ),
    ];
  }

  Widget buildContinueButton() {
    return CustomOutlinedButton(
      onPressed: _saveForm,
      widget: Text(AppLocalizations.of(context)!.continueH),
    );
  }

  List<Widget> buildRecipientField(TextStyle bodyText2) {
    return [
      TextFormField(
        textInputAction: TextInputAction.next,
        controller: _recipientAddressController,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context)!.recipientAdddress,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
        style: bodyText2,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_amountFocusNode);
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return AppLocalizations.of(context)!
                .pleaseProvideTheRecipientAddress;
          }
          return null;
        },
      ),
    ];
  }
}

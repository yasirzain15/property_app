import 'package:flutter/material.dart';
import 'package:rent_pay/Core/Constants/colors.dart';
import 'package:rent_pay/Widgets/Payment%20Success/back_home_button.dart';
import 'package:rent_pay/Widgets/Payment%20Success/success_header.dart';
import 'package:rent_pay/Widgets/Payment%20Success/transaction_card.dart';

class PaymentSuccessView extends StatelessWidget {
  const PaymentSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: const [
              SizedBox(height: 20),
              SuccessHeader(),
              SizedBox(height: 24),
              TransactionCard(),
              Spacer(),
              BackHomeButton(),
            ],
          ),
        ),
      ),
    );
  }
}

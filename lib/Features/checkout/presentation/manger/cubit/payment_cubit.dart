import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:checkout_payment_ui/Features/checkout/data/models/payment_intent_input_model.dart';
import 'package:checkout_payment_ui/Features/checkout/data/repos/checkout_repo_impl.dart';
import 'package:meta/meta.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.checkoutRepoImpl) : super(PaymentInitial());
  final CheckoutRepoImpl checkoutRepoImpl;

  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    emit(PaymentLoading());
    var data = await checkoutRepoImpl.makePayment(
        paymentIntentInputModel: paymentIntentInputModel);
    data.fold(
      (l) => emit(PaymentFailure(l.errMessage)),
      (r) => emit(
        PaymentSuccess(),
      ),
    );
  }

  @override
  void onChange(Change<PaymentState> change) {
    log(change.toString());
    super.onChange(change);
  }
}

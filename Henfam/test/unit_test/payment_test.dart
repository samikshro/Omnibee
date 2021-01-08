import 'package:test/test.dart';
import 'package:Henfam/services/paymentService.dart';

void main() {
  group('Payments', () {
    double orderPrice = 9.99;
    test('standard pcharge test', () {
      double pCharge = PaymentService.getPCharge(orderPrice);
      expect(pCharge, 14.43);
    });

    test('standard omnibeeFee test', () {
      double omnibeeFee = PaymentService.getOmnibeeFee(orderPrice);
      expect(omnibeeFee, 0.54);
    });

    test('standard totalfees test', () {
      double totalFees = PaymentService.getTotalFees(orderPrice);
      expect(totalFees, 3.42);
    });

    test('standard stripe fee test', () {
      double stripeFee = PaymentService.getStripeFee(orderPrice);
      expect(stripeFee, 0.72);
    });
  });
}

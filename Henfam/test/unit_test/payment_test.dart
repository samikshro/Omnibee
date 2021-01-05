import 'package:test/test.dart';
import 'package:Henfam/services/paymentService.dart';

void main() {
  group('Payments', () {
    test('standard pcharge test', () {
      double orderPrice = 9.259;
      double pCharge = PaymentService.getPCharge(orderPrice);

      expect(pCharge, 13.39);
    });

    test('standard omnibeeFee test', () {
      double orderPrice = 9.259;
      double omnibeeFee = PaymentService.getOmnibeeFee(orderPrice);

      expect(omnibeeFee, 0.54);
    });

    test('standard totalfees test', () {
      double orderPrice = 9.259;
      double totalFees = PaymentService.getTotalFees(orderPrice);

      expect(totalFees, 3.39);
    });
  });
}

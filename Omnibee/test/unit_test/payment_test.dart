import 'package:test/test.dart';
import 'package:Omnibee/services/paymentService.dart';

void main() {
  group('Payments', () {
    double orderPrice = 9.99;
    test('standard pcharge test', () {
      double pCharge = PaymentService.getPCharge(orderPrice);
      expect(pCharge, 14.20);
    });

    test('standard omnibeeFee test', () {
      double omnibeeFee = PaymentService.getOmnibeeFee(orderPrice);
      expect(omnibeeFee, 0.54);
    });

    test('standard totalfees test', () {
      double totalFees = PaymentService.getTotalFees(orderPrice);
      expect(totalFees, 3.41);
    });

    test('standard stripe fee test', () {
      double stripeFee = PaymentService.getStripeFee(orderPrice);
      expect(stripeFee, 0.71);
    });

    test('basket form displayed prices', () {
      double tax = PaymentService.getTaxedPrice(orderPrice) - orderPrice;
      double fees = PaymentService.getTotalFees(orderPrice);
      double totalPrice = orderPrice + tax + fees;
      expect(totalPrice, 14.20);
    });
  });
}

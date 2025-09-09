//D - Dependency Inversion Principle (DIP) 

abstract class PaymentMethod {
  void pay(double amount);
}

abstract class CardPayment extends PaymentMethod {
  String cardNumber;
  String expiryDate;

  CardPayment(this.cardNumber, this.expiryDate);

  bool validateCard() {
    return cardNumber.isNotEmpty && expiryDate.isNotEmpty;
  }
}

class CreditPayment extends CardPayment {
  CreditPayment(String cardNumber, String expiryDate)
      : super(cardNumber, expiryDate);

  @override
  void pay(double amount) {
    if (!validateCard()) throw Exception("Cartão de crédito inválido!");
    print("Pagamento de R\$${amount} via Crédito realizado!");
  }
}

class DebitPayment extends CardPayment {
  DebitPayment(String cardNumber, String expiryDate)
      : super(cardNumber, expiryDate);

  @override
  void pay(double amount) {
    if (!validateCard()) throw Exception("Cartão de débito inválido!");
    print("Pagamento de R\$${amount} via Débito realizado!");
  }
}

class PixPayment implements PaymentMethod {
  @override
  void pay(double amount) {
    print("Pagamento de R\$${amount} via Pix realizado!");
  }
}

// Checkout agora recebe qualquer PaymentMethod via injeção
class Checkout {
  final PaymentMethod paymentMethod;

  Checkout(this.paymentMethod);

  void process(double amount) {
    paymentMethod.pay(amount);
  }
}

void main() {
  // Injeção de dependência explícita
  final creditCheckout = Checkout(CreditPayment("1234-5678", "12/25"));
  final debitCheckout = Checkout(DebitPayment("9876-5432", "11/24"));
  final pixCheckout = Checkout(PixPayment());

  creditCheckout.process(500); 
  debitCheckout.process(200);  
  pixCheckout.process(100); 
}

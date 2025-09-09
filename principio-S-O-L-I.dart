//L  - Liskov Substitution Principle (LSP)
//I - Interface Segregation Principle (ISP)

abstract class PaymentMethod {
  void pay(double amount);
}

// Abstração para cartões (Crédito e Débito)
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
    if (!validateCard()) {
      throw Exception("Cartão de crédito inválido!");
    }
    print("Pagamento de R\$${amount} via Crédito realizado!");
  }
}

class DebitPayment extends CardPayment {
  DebitPayment(String cardNumber, String expiryDate) 
      : super(cardNumber, expiryDate);

  @override
  void pay(double amount) {
    if (!validateCard()) {
      throw Exception("Cartão de débito inválido!");
    }
    print("Pagamento de R\$${amount} via Débito realizado!");
  }
}

class PixPayment implements PaymentMethod {
  @override
  void pay(double amount) {
    print("Pagamento de R\$${amount} via Pix realizado!");
  }
}

// Checkout é um módulo de alto nível (responsável por processar pagamentos).
// DIP: depender de interfaces/abstrações, não de classes concretas.
class Checkout {
  void process(PaymentMethod paymentMethod, double amount) {
    paymentMethod.pay(amount);
  }
}

void main() {
  final checkout = Checkout();

  final credit = CreditPayment("1234-5678", "12/25");
  final debit = DebitPayment("9876-5432", "11/24");
  final pix = PixPayment();

  checkout.process(credit, 500); // Funciona
  checkout.process(debit, 200);  // Funciona
  checkout.process(pix, 100);    // Funciona, sem validação

  
}

// Forma errada. 

// abstract class PaymentMethod {
//   bool validateCard(); // Todo PaymentMethod precisa implementar (Debito, Credito e Pix)
//   void pay(double amount); // Todo PaymentMethod precisa implementar
// }

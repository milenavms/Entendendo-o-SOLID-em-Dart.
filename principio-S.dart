// S - Single Responsibility Principle (SRP)

String pixPayment() => "Pagamento via Pix";
String debitPayment() => "Pagamento via Débito";
String creditPayment() => "Pagamento via Crédito";

String checkout(String payment) {
  String process(String payment) {
    switch (payment.toLowerCase()) {
      case "pix":
        return pixPayment();
      case "debito":
        return debitPayment();
      case "credito":
        return creditPayment();
      default:
        throw Exception("Pagamento inválido");
    }
  }

  return process(payment);
}

void main() {
  print(checkout("pix"));     // Pagamento via Pix
  print(checkout("debito"));  // Pagamento via Débito
  print(checkout("credito")); // Pagamento via Crédito
}

// ###########################
// Sem responsabilidade Unica
// ❌ Exemplo: alterar a classe `PaymentMethod` para incluir novas regras.
class PaymentMethod {
  void pay(String type, double amount) {
    if (type.toLowerCase() == "pix") {
      print("Pagamento de R\$${amount} via Pix realizado!");
    } else if (type.toLowerCase() == "debito") {
      print("Pagamento de R\$${amount} via Débito realizado!");
    } else if (type.toLowerCase() == "credito") {
      print("Pagamento de R\$${amount} via Crédito realizado!");
    } else {
      throw Exception("Tipo de pagamento inválido");
    }
  }
}

// void main() {
//   final payment = PaymentMethod();

//   payment.pay("pix", 100);    
//   payment.pay("debito", 50);   
//   payment.pay("credito", 200); 
// }


//O -  Open/Closed Principle (OCP)

String pixPayment() => "Pagamento via Pix";
String debitPayment() => "Pagamento via Débito";
String creditPayment() => "Pagamento via Crédito";


final Map<String, String Function()> paymentMethods = {
  'pix': pixPayment,
  'debito': debitPayment,
  'credito': creditPayment,
};

// Aplicando o (O)
String checkout(String payment) {
  final method = paymentMethods[payment.toLowerCase()];
  if (method == null) {
    throw Exception("Pagamento inválido");
  }
  return method();
}

void main() {
  print(checkout("pix"));     
  print(checkout("debito"));  
  print(checkout("credito")); 

  // Novo tipo de pagamento
  String boletoPayment() => "Pagamento via Boleto";

  // Adicionando ao mapa sem modificar checkout (O - Open/Closed)
  paymentMethods['boleto'] = boletoPayment;

  print(checkout("boleto"));
}

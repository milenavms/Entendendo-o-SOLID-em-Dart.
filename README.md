# Princípios SOLID em Dart

Este repositório contém exemplos práticos em **Dart** aplicando (e também quebrando) os princípios do **SOLID**.  
O objetivo é demonstrar de forma simples como cada princípio pode ser aplicado no dia a dia do desenvolvimento de software.

---

## 🔹 O que é SOLID?

**SOLID** é um acrônimo para cinco princípios da programação orientada a objetos que ajudam a escrever código mais **organizado, reutilizável e fácil de manter**:

1. **S** – Single Responsibility Principle (Princípio da Responsabilidade Única)  
2. **O** – Open/Closed Principle (Princípio Aberto/Fechado)  
3. **L** – Liskov Substitution Principle (Princípio da Substituição de Liskov)  
4. **I** – Interface Segregation Principle (Princípio da Segregação de Interfaces)  
5. **D** – Dependency Inversion Principle (Princípio da Inversão de Dependência)

---

## 📌 Exemplos Implementados

### 1. Single Responsibility Principle (SRP)
Cada classe deve ter apenas **uma responsabilidade**.  
✅ Exemplo correto: classes separadas para cada tipo de pagamento (`PixPayment`, `DebitPayment`, `CreditPayment`).  
❌ Exemplo incorreto: uma única classe `PaymentMethod` que trata todos os pagamentos com vários `if`.

---

### 2. Open/Closed Principle (OCP)
As classes devem estar **abertas para extensão**, mas **fechadas para modificação**.  
✅ Exemplo: Criar uma nova classe `checkout` fechada para alteracoes e aberta para extensão, responsavel por realizar pagamentos, podendo adicionar novos tipos de pagamento no codigo sem modificar a classe checkout.
❌ Exemplo incorreto:  alterar a classe `PaymentMethod` para incluir novas regras, novos tipos de pagamento.

---

### 3. Liskov Substitution Principle (LSP)

O princípio diz que **subclasses devem poder substituir suas superclasses sem quebrar o código**.  

✅ No exemplo, temos a abstração `PaymentMethod` e diferentes implementações (`CreditPayment`, `DebitPayment` e `PixPayment`).  
Todas podem ser usadas no `Checkout` sem causar erro — ou seja, respeitam o contrato de `PaymentMethod`.  

```dart
final checkout = Checkout();

final credit = CreditPayment("1234-5678", "12/25");
final debit = DebitPayment("9876-5432", "11/24");
final pix = PixPayment();

checkout.process(credit, 500); // Funciona
checkout.process(debit, 200);  // Funciona
checkout.process(pix, 100);    // Funciona
```

❌ Exemplo incorreto:  Forçar todos os métodos de pagamento a implementar coisas que não fazem sentido.
Por exemplo, se PaymentMethod tivesse validateCard(), o Pix seria obrigado a implementar algo que não se aplica a ele, quebrando o LSP.


---

### 4. Interface Segregation Principle (ISP)
Os clientes não devem ser forçados a depender de interfaces que **não utilizam**.  

✅ No exemplo, criamos a abstração `CardPayment` apenas para métodos que realmente usam cartão `(CreditPayment e DebitPayment)`.
O `PixPayment` implementa apenas o que precisa `(PaymentMethod)`.

❌ Exemplo incorreto: Se tivéssemos colocado `validateCard()` direto na interface `PaymentMethod`, o Pix seria obrigado a ter esse método sem necessidade, o que fere o ISP
 
---

### 5. Dependency Inversion Principle (DIP)

O princípio diz que **módulos de alto nível não devem depender de módulos de baixo nível, ambos devem depender de abstrações**.  

✅ No exemplo, o `Checkout` (módulo de alto nível) **não depende de implementações concretas** (`CreditPayment`, `DebitPayment`, `PixPayment`), mas sim da interface `PaymentMethod`.  
Isso é feito via **injeção de dependência** no construtor:

```dart
final creditCheckout = Checkout(CreditPayment("1234-5678", "12/25"));
final debitCheckout = Checkout(DebitPayment("9876-5432", "11/24"));
final pixCheckout = Checkout(PixPayment());

creditCheckout.process(500); 
debitCheckout.process(200);  
pixCheckout.process(100);
```

Assim, o Checkout funciona com qualquer método de pagamento, sem precisar alterar a classe quando adicionamos novos tipos de pagamento, garantindo baixo acoplamento e maior flexibilidade.

❌ Exemplo incorreto:  criar instâncias concretas dentro do Checkout, como CreditPayment() ou PixPayment(). Isso faz o módulo depender de implementações específicas, quebrando o DIP.

---

## 🚀 Como rodar o projeto

1. Clone este repositório:  
   ```bash
   git clone https://github.com/seu-usuario/solid-dart.git
   cd solid-dart
    ```
2. Rodar :  
   ```bash
    dart run nome-do-arquivo.dart
   ```
  

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(
    this.valor,
    this.numeroConta,
  );

  @override
  String toString() {
    return 'Transferencia(valor:$valor, numeroConta: $numeroConta)'; //retornando os valores, int e double como uma string.
  }
}

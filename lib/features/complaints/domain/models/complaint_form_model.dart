class ComplaintFormModel {
  final String? id;
  final String nomeCompleto;
  final String numeroCelular;
  final String endereco;
  final String especieAnimal;
  final String localizacao;
  final String descricao;
  final String? fotoUrl;
  final String status;

  ComplaintFormModel({
    this.id,
    required this.nomeCompleto,
    required this.numeroCelular,
    required this.endereco,
    required this.especieAnimal,
    required this.localizacao,
    required this.descricao,
    this.fotoUrl,
    this.status = 'Pendente',
  });
}
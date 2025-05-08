class RescueModel {
  final String endereco;
  final String data;
  final String hora;
  final String descricao;
  final String status;
  final String? nomeAnimal;
  final String? especie;
  final String? idade;
  final String? sexo;
  final String? condicaoAnimal;
  final String? observacoes;
  final List<String>? fotos;

  RescueModel({
    required this.endereco,
    required this.data,
    required this.hora,
    required this.descricao,
    required this.status,
    this.nomeAnimal,
    this.especie,
    this.idade,
    this.sexo,
    this.condicaoAnimal,
    this.observacoes,
    this.fotos,
  });
}
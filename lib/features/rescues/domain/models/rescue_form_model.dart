class RescueFormModel {
  final String nomeAnimal;
  final String especie;
  final String idade;
  final String sexo;
  final String descricao;
  final String endereco;
  final String data;
  final String hora;
  final String condicaoAnimal;
  final String observacoes;
  final List<String>? fotos;

  RescueFormModel({
    required this.nomeAnimal,
    required this.especie,
    required this.idade,
    required this.sexo,
    required this.descricao,
    required this.endereco,
    required this.data,
    required this.hora,
    required this.condicaoAnimal,
    required this.observacoes,
    this.fotos,
  });
}
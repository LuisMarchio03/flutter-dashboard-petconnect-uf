class AnimalModel {
  final String nome;
  final String genero;
  final String raca;
  final String cor;
  final String porte;
  final String especie;
  final String idade;
  final String status;
  final String peso;
  final String localizacao;
  final String observacoes;
  final String ultimaVacina;
  final String proximaVacina;
  final String condicoesMedicas;

  AnimalModel({
    required this.nome,
    required this.genero,
    required this.raca,
    required this.cor,
    this.porte = '',
    this.especie = '',
    this.idade = '',
    required this.status,
    this.peso = '',
    this.localizacao = '',
    this.observacoes = '',
    this.ultimaVacina = '',
    this.proximaVacina = '',
    this.condicoesMedicas = '',
  });
}
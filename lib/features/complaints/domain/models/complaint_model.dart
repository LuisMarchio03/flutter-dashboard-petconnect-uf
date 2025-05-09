class ComplaintModel {
  final String endereco;
  final String dataReporte;
  final String descricao;
  final String status;
  final String? imagemUrl; // Novo campo para a URL da imagem

  ComplaintModel({
    required this.endereco,
    required this.dataReporte,
    required this.descricao,
    required this.status,
    this.imagemUrl, // Campo opcional para a imagem
  });
}
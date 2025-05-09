class AdoptionModel {
  final String id;
  final String animalId;
  final String animalNome;
  final String adotante;
  final String cpf;
  final String email;
  final String telefone;
  final String endereco;
  final DateTime dataAdocao;
  final String status;
  final String observacoes;

  AdoptionModel({
    required this.id,
    required this.animalId,
    required this.animalNome,
    required this.adotante,
    required this.cpf,
    required this.email,
    required this.telefone,
    required this.endereco,
    required this.dataAdocao,
    required this.status,
    required this.observacoes,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'animalId': animalId,
      'animalNome': animalNome,
      'adotante': adotante,
      'cpf': cpf,
      'email': email,
      'telefone': telefone,
      'endereco': endereco,
      'dataAdocao': dataAdocao.toIso8601String(),
      'status': status,
      'observacoes': observacoes,
    };
  }

  factory AdoptionModel.fromJson(Map<String, dynamic> json) {
    return AdoptionModel(
      id: json['id'] as String,
      animalId: json['animalId'] as String,
      animalNome: json['animalNome'] as String,
      adotante: json['adotante'] as String,
      cpf: json['cpf'] as String,
      email: json['email'] as String,
      telefone: json['telefone'] as String,
      endereco: json['endereco'] as String,
      dataAdocao: DateTime.parse(json['dataAdocao'] as String),
      status: json['status'] as String,
      observacoes: json['observacoes'] as String,
    );
  }

  AdoptionModel copyWith({
    String? id,
    String? animalId,
    String? animalNome,
    String? adotante,
    String? cpf,
    String? email,
    String? telefone,
    String? endereco,
    DateTime? dataAdocao,
    String? status,
    String? observacoes,
  }) {
    return AdoptionModel(
      id: id ?? this.id,
      animalId: animalId ?? this.animalId,
      animalNome: animalNome ?? this.animalNome,
      adotante: adotante ?? this.adotante,
      cpf: cpf ?? this.cpf,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
      endereco: endereco ?? this.endereco,
      dataAdocao: dataAdocao ?? this.dataAdocao,
      status: status ?? this.status,
      observacoes: observacoes ?? this.observacoes,
    );
  }
}

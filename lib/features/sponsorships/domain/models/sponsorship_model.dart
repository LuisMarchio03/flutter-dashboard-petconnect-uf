class SponsorshipModel {
  final String id;
  final String animalId;
  final String animalNome;
  final String padrinho;
  final String cpf;
  final String email;
  final String telefone;
  final String endereco;
  final DateTime dataInicio;
  final DateTime? dataFim;
  final double valorMensal;
  final String status;
  final String observacoes;

  SponsorshipModel({
    required this.id,
    required this.animalId,
    required this.animalNome,
    required this.padrinho,
    required this.cpf,
    required this.email,
    required this.telefone,
    required this.endereco,
    required this.dataInicio,
    this.dataFim,
    required this.valorMensal,
    required this.status,
    required this.observacoes,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'animalId': animalId,
      'animalNome': animalNome,
      'padrinho': padrinho,
      'cpf': cpf,
      'email': email,
      'telefone': telefone,
      'endereco': endereco,
      'dataInicio': dataInicio.toIso8601String(),
      'dataFim': dataFim?.toIso8601String(),
      'valorMensal': valorMensal,
      'status': status,
      'observacoes': observacoes,
    };
  }

  factory SponsorshipModel.fromJson(Map<String, dynamic> json) {
    return SponsorshipModel(
      id: json['id'] as String,
      animalId: json['animalId'] as String,
      animalNome: json['animalNome'] as String,
      padrinho: json['padrinho'] as String,
      cpf: json['cpf'] as String,
      email: json['email'] as String,
      telefone: json['telefone'] as String,
      endereco: json['endereco'] as String,
      dataInicio: DateTime.parse(json['dataInicio'] as String),
      dataFim:
          json['dataFim'] != null
              ? DateTime.parse(json['dataFim'] as String)
              : null,
      valorMensal: (json['valorMensal'] as num).toDouble(),
      status: json['status'] as String,
      observacoes: json['observacoes'] as String,
    );
  }

  SponsorshipModel copyWith({
    String? id,
    String? animalId,
    String? animalNome,
    String? padrinho,
    String? cpf,
    String? email,
    String? telefone,
    String? endereco,
    DateTime? dataInicio,
    DateTime? dataFim,
    double? valorMensal,
    String? status,
    String? observacoes,
  }) {
    return SponsorshipModel(
      id: id ?? this.id,
      animalId: animalId ?? this.animalId,
      animalNome: animalNome ?? this.animalNome,
      padrinho: padrinho ?? this.padrinho,
      cpf: cpf ?? this.cpf,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
      endereco: endereco ?? this.endereco,
      dataInicio: dataInicio ?? this.dataInicio,
      dataFim: dataFim ?? this.dataFim,
      valorMensal: valorMensal ?? this.valorMensal,
      status: status ?? this.status,
      observacoes: observacoes ?? this.observacoes,
    );
  }
}

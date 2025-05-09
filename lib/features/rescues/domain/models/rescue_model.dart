import 'package:flutter/material.dart';

class RescueModel {
  final String? id;
  final String? nomeAnimal;
  final String? especie;
  final String? idade;
  final String? sexo;
  final String? condicaoAnimal;
  final String? localizacao;
  final String? dataResgate;
  final String? responsavel;
  final String? contato;
  final String? observacoes;
  final String status;
  final String? imagemUrl;
  final bool? origemDenuncia;

  // Status possíveis
  static const String STATUS_PENDENTE = 'Pendente';
  static const String STATUS_EM_ANDAMENTO = 'Em andamento';
  static const String STATUS_RESGATADO = 'Resgatado';
  static const String STATUS_NAO_LOCALIZADO = 'Não localizado';
  static const String STATUS_CANCELADO = 'Cancelado';

  static var STATUS_FINALIZADO;

  RescueModel({
    this.id,
    this.nomeAnimal,
    this.especie,
    this.idade,
    this.sexo,
    this.condicaoAnimal,
    this.localizacao,
    this.dataResgate,
    this.responsavel,
    this.contato,
    this.observacoes,
    required this.status,
    this.imagemUrl,
    this.origemDenuncia,
  });

  // Método para obter a cor do status
  static Color getStatusColor(String status) {
    switch (status) {
      case STATUS_PENDENTE:
        return const Color(0xFFEAB308); // Amarelo
      case STATUS_EM_ANDAMENTO:
        return const Color(0xFF3B82F6); // Azul
      case STATUS_RESGATADO:
        return const Color(0xFF10B981); // Verde
      case STATUS_NAO_LOCALIZADO:
        return const Color(0xFF6B7280); // Cinza
      case STATUS_CANCELADO:
        return const Color(0xFFEF4444); // Vermelho
      default:
        return const Color(0xFF6B7280); // Cinza
    }
  }

  // Método para criar uma cópia com alterações
  RescueModel copyWith({
    String? id,
    String? nomeAnimal,
    String? especie,
    String? idade,
    String? sexo,
    String? condicaoAnimal,
    String? localizacao,
    String? dataResgate,
    String? responsavel,
    String? contato,
    String? observacoes,
    String? status,
    String? imagemUrl,
    bool? origemDenuncia,
  }) {
    return RescueModel(
      id: id ?? this.id,
      nomeAnimal: nomeAnimal ?? this.nomeAnimal,
      especie: especie ?? this.especie,
      idade: idade ?? this.idade,
      sexo: sexo ?? this.sexo,
      condicaoAnimal: condicaoAnimal ?? this.condicaoAnimal,
      localizacao: localizacao ?? this.localizacao,
      dataResgate: dataResgate ?? this.dataResgate,
      responsavel: responsavel ?? this.responsavel,
      contato: contato ?? this.contato,
      observacoes: observacoes ?? this.observacoes,
      status: status ?? this.status,
      imagemUrl: imagemUrl ?? this.imagemUrl,
      origemDenuncia: origemDenuncia ?? this.origemDenuncia,
    );
  }

  // Método para obter a lista de status
  static List<String> getStatusList() {
    return [
      STATUS_PENDENTE,
      STATUS_EM_ANDAMENTO,
      STATUS_RESGATADO,
      STATUS_NAO_LOCALIZADO,
      STATUS_CANCELADO,
    ];
  }
}
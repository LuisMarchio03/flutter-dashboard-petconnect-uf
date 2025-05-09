import 'package:flutter/material.dart';

class AdoptionModel {
  final String? id;
  final String animalId;
  final String adopterId;
  final String adopterName;
  final String adopterEmail;
  final String adopterPhone;
  final String adoptionDate;
  final String status;
  final String? observations;
  final String? contractUrl;
  final String? documentsUrl;

  // Status possíveis
  static const String STATUS_PENDING = 'Pendente';
  static const String STATUS_APPROVED = 'Aprovado';
  static const String STATUS_REJECTED = 'Rejeitado';
  static const String STATUS_COMPLETED = 'Concluído';
  static const String STATUS_CANCELLED = 'Cancelado';

  AdoptionModel({
    this.id,
    required this.animalId,
    required this.adopterId,
    required this.adopterName,
    required this.adopterEmail,
    required this.adopterPhone,
    required this.adoptionDate,
    required this.status,
    this.observations,
    this.contractUrl,
    this.documentsUrl,
  });

  // Método para obter a cor do status
  static Color getStatusColor(String status) {
    switch (status) {
      case STATUS_PENDING:
        return const Color(0xFFEAB308); // Amarelo
      case STATUS_APPROVED:
        return const Color(0xFF3B82F6); // Azul
      case STATUS_REJECTED:
        return const Color(0xFFEF4444); // Vermelho
      case STATUS_COMPLETED:
        return const Color(0xFF10B981); // Verde
      case STATUS_CANCELLED:
        return const Color(0xFF6B7280); // Cinza
      default:
        return const Color(0xFF6B7280); // Cinza
    }
  }

  // Método para criar uma cópia com alterações
  AdoptionModel copyWith({
    String? id,
    String? animalId,
    String? adopterId,
    String? adopterName,
    String? adopterEmail,
    String? adopterPhone,
    String? adoptionDate,
    String? status,
    String? observations,
    String? contractUrl,
    String? documentsUrl,
  }) {
    return AdoptionModel(
      id: id ?? this.id,
      animalId: animalId ?? this.animalId,
      adopterId: adopterId ?? this.adopterId,
      adopterName: adopterName ?? this.adopterName,
      adopterEmail: adopterEmail ?? this.adopterEmail,
      adopterPhone: adopterPhone ?? this.adopterPhone,
      adoptionDate: adoptionDate ?? this.adoptionDate,
      status: status ?? this.status,
      observations: observations ?? this.observations,
      contractUrl: contractUrl ?? this.contractUrl,
      documentsUrl: documentsUrl ?? this.documentsUrl,
    );
  }

  // Método para obter a lista de status
  static List<String> getStatusList() {
    return [
      STATUS_PENDING,
      STATUS_APPROVED,
      STATUS_REJECTED,
      STATUS_COMPLETED,
      STATUS_CANCELLED,
    ];
  }
}

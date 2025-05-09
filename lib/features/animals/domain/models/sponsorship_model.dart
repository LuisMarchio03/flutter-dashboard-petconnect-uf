import 'dart:ui';

class SponsorshipModel {
  final String? id;
  final String animalId;
  final String sponsorId;
  final String sponsorName;
  final String sponsorEmail;
  final String sponsorPhone;
  final String startDate;
  final String? endDate;
  final String status;
  final String sponsorshipType;
  final double monthlyValue;
  final String? observations;
  final String? contractUrl;
  final String? documentsUrl;

  // Status possíveis
  static const String STATUS_ACTIVE = 'Ativo';
  static const String STATUS_PENDING = 'Pendente';
  static const String STATUS_SUSPENDED = 'Suspenso';
  static const String STATUS_CANCELLED = 'Cancelado';
  static const String STATUS_COMPLETED = 'Concluído';

  // Tipos de apadrinhamento
  static const String TYPE_FULL = 'Completo';
  static const String TYPE_PARTIAL = 'Parcial';
  static const String TYPE_TEMPORARY = 'Temporário';

  SponsorshipModel({
    this.id,
    required this.animalId,
    required this.sponsorId,
    required this.sponsorName,
    required this.sponsorEmail,
    required this.sponsorPhone,
    required this.startDate,
    this.endDate,
    required this.status,
    required this.sponsorshipType,
    required this.monthlyValue,
    this.observations,
    this.contractUrl,
    this.documentsUrl,
  });

  // Método para obter a cor do status
  static Color getStatusColor(String status) {
    switch (status) {
      case STATUS_ACTIVE:
        return const Color(0xFF10B981); // Verde
      case STATUS_PENDING:
        return const Color(0xFFEAB308); // Amarelo
      case STATUS_SUSPENDED:
        return const Color(0xFFEF4444); // Vermelho
      case STATUS_CANCELLED:
        return const Color(0xFF6B7280); // Cinza
      case STATUS_COMPLETED:
        return const Color(0xFF3B82F6); // Azul
      default:
        return const Color(0xFF6B7280); // Cinza
    }
  }

  // Método para criar uma cópia com alterações
  SponsorshipModel copyWith({
    String? id,
    String? animalId,
    String? sponsorId,
    String? sponsorName,
    String? sponsorEmail,
    String? sponsorPhone,
    String? startDate,
    String? endDate,
    String? status,
    String? sponsorshipType,
    double? monthlyValue,
    String? observations,
    String? contractUrl,
    String? documentsUrl,
  }) {
    return SponsorshipModel(
      id: id ?? this.id,
      animalId: animalId ?? this.animalId,
      sponsorId: sponsorId ?? this.sponsorId,
      sponsorName: sponsorName ?? this.sponsorName,
      sponsorEmail: sponsorEmail ?? this.sponsorEmail,
      sponsorPhone: sponsorPhone ?? this.sponsorPhone,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      sponsorshipType: sponsorshipType ?? this.sponsorshipType,
      monthlyValue: monthlyValue ?? this.monthlyValue,
      observations: observations ?? this.observations,
      contractUrl: contractUrl ?? this.contractUrl,
      documentsUrl: documentsUrl ?? this.documentsUrl,
    );
  }

  // Método para obter a lista de status
  static List<String> getStatusList() {
    return [
      STATUS_ACTIVE,
      STATUS_PENDING,
      STATUS_SUSPENDED,
      STATUS_CANCELLED,
      STATUS_COMPLETED,
    ];
  }

  // Método para obter a lista de tipos de apadrinhamento
  static List<String> getSponsorshipTypes() {
    return [TYPE_FULL, TYPE_PARTIAL, TYPE_TEMPORARY];
  }
}

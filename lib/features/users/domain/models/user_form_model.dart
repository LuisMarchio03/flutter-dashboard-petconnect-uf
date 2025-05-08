class UserFormModel {
  final String? id;
  final String nomeCompleto;
  final String cpf;
  final String dataNascimento;
  final String email;
  final String telefone;
  final String nomeUsuario;
  final String senha;
  final String tipoUsuario;
  final List<String> perfisAcesso;
  final String enderecoCompleto;
  final String cidade;
  final String estado;
  final String cep;
  final List<AnimalVinculado> animaisVinculados;
  final String? fotoUrl;

  UserFormModel({
    this.id,
    required this.nomeCompleto,
    required this.cpf,
    required this.dataNascimento,
    required this.email,
    required this.telefone,
    required this.nomeUsuario,
    required this.senha,
    required this.tipoUsuario,
    required this.perfisAcesso,
    required this.enderecoCompleto,
    required this.cidade,
    required this.estado,
    required this.cep,
    this.animaisVinculados = const [],
    this.fotoUrl,
  });
}

class AnimalVinculado {
  final String id;
  final String nome;
  final String tipo;

  AnimalVinculado({
    required this.id,
    required this.nome,
    required this.tipo,
  });
}
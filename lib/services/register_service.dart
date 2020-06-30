class RegisterService {
  String id;
  String nome;
  String email;
  String senha;

  RegisterService(this.id, this.email, this.senha, this.nome);

  @override
  String toString() {
    return 'RegisterService{id: $id, nome: $nome, email: $email, senha: $senha}';
  }
}

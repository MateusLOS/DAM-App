# Ticket Sis

## Descrição
O Ticket Sis é um sistema de abertura de chamados que permite aos usuários gerenciar chamados de forma eficiente, utilizando suas credenciais corporativas.

## Funcionalidade de Login
Como usuário do Ticket Sis, você pode realizar o login no sistema para acessar suas funcionalidades, seguindo os critérios de aceite especificados.

### Critérios de Aceite
- **Tela de Login**: Ao acessar o Ticket Sis pela WEB, a tela de login será exibida como a primeira tela do sistema.
- **Autenticação**: O usuário utilizará e-mail e senha para acessar o Ticket Sis, e um token será enviado para seu e-mail corporativo.
- **Validação de Token**: O usuário deverá digitar o token recebido por e-mail para ser direcionado à tela inicial da aplicação.
- **Feedback de Erro**: Se o token estiver incorreto, será exibida a mensagem “Token incorreto, tente novamente”.
- **Expiração de Token**: Se o token expirar após 5 minutos, será exibida a mensagem “Token expirado, reenvie o token”.
- **Reenvio de Token**: O usuário poderá clicar em “Reenviar token” para solicitar um novo token.

## Estrutura do Projeto
- `src/`: Contém o código fonte do projeto.
- `docs/`: Documentação e protótipos da interface.
- `tests/`: Testes para as funcionalidades.

## Como Contribuir
1. Faça um fork deste repositório.
2. Crie uma nova branch: `git checkout -b minha-nova-feature`
3. Faça suas alterações e commit: `git commit -m 'Adicionando nova feature'`
4. Envie para o repositório remoto: `git push origin minha-nova-feature`
5. Abra um Pull Request.

## Licença
Este projeto é licenciado sob a MIT License - veja o arquivo [LICENSE](LICENSE) para mais detalhes.

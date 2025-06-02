# Recomendou – Aplicativo de Recomendações de Filmes e Séries

## Descrição

O **MovieRecommender** é um aplicativo móvel focado em indicações personalizadas de filmes e séries. Baseado em algoritmos de recomendação, o app analisa preferências, histórico de avaliações e interações dos usuários para sugerir conteúdos alinhados aos seus gostos. Além disso, permite gerenciar listas de assistidos e favoritos de forma intuitiva.

## Contextualização

O consumo de conteúdo audiovisual por streaming tem crescido exponencialmente. No Brasil, 75% da população assiste a vídeos diariamente e dedica 21% do tempo total a essas plataformas. Apesar disso, muitos usuários perdem tempo escolhendo o que assistir e sentem que as recomendações são genéricas ou repetitivas.

## Problema

- Usuários gastam, em média, 18 minutos escolhendo um filme na Netflix antes de decidir o que assistir.  
- Recomendações atuais nem sempre capturam preferências detalhadas, levando a frustrações e desistências.  
- Falta de ferramentas que conciliem sugestões personalizadas com organização prática de listas de assistidos e favoritos.

## Objetivos

### Objetivo Geral

Desenvolver um aplicativo móvel que auxilie os usuários na descoberta de filmes e séries, oferecendo recomendações personalizadas com base em suas preferências, avaliações e interações.

### Objetivos Específicos

- Criar sistema de cadastro e login seguro.  
- Implementar personalização de perfil (bio, foto e gêneros favoritos).  
- Desenvolver recomendação baseada em histórico de avaliações e preferências.  
- Permitir busca por nome de título ou atores.  
- Oferecer seção de “Favoritos” e “Assistidos” para organização do conteúdo.  
- Fornecer histórico de avaliações editável (visualizar, editar, excluir).  
- Projetar interface intuitiva e acessível.  
- Garantir segurança e privacidade dos dados.

## Funcionalidades Principais

- **Autenticação**: cadastro, login, recuperação de senha.  
- **Perfil do Usuário**: foto, bio e seleção de gêneros favoritos.  
- **Recomendações**: sugestões dinâmicas baseadas em histórico e preferências.  
- **Busca**: pesquisa por título ou nome de elenco.  
- **Listas**: gerenciamento de filmes/séries “Favoritos” e “Assistidos”.  
- **Avaliações**: sistema de curtidas (odiei, curti, amei) com edição posterior.  
- **Detalhes de Conteúdo**: sinopse, elenco, gênero e duração.  
- **Notificações**: alertas sobre novas recomendações.

## Requisitos do Sistema

### Requisitos Funcionais

- RF-01: Criação de conta de usuário  
- RF-02: Recuperação de senha  
- RF-03: Seleção de gêneros favoritos  
- RF-04: Recomendações baseadas no histórico de avaliação  
- RF-05: Registro de conteúdo assistido com opções de avaliação  
- RF-06: Exibição de informações detalhadas do título  
- RF-07: Adição de títulos a “Favoritos” e “Assistidos”  
- RF-08: Edição e exclusão de avaliações passadas  
- RF-09: Busca por filme/série ou ator  
- RF-10: Alteração de foto de perfil

### Requisitos Não Funcionais

- RNF-01: Armazenamento seguro de dados dos usuários  
- RNF-02: Disponibilidade 24/7 com tempo de carregamento ≤ 4s  
- RNF-03: Interface responsiva e fácil de navegar  
- RNF-04: Autenticação segura (2FA)  
- RNF-05: Compatibilidade com diferentes dispositivos e navegadores  
- RNF-06: Suporte a grande volume de usuários simultâneos  
- RNF-07: Operação offline para acesso a históricos e favoritos  
- RNF-08: Possibilidade de futuras integrações com outras plataformas de streaming

## Personas

- **João, 25 anos**: Maratonista de séries, busca sempre novidades que se encaixem no seu perfil de fantasia e ação.  
- **Mariana, 32 anos**: Amante de documentários, valoriza recomendações que levem em conta suas avaliações passadas.  
- **Pedro, 19 anos**: Usuário ocasional, quer escolher rápido e sem frustrações.

## Especificação do Projeto

| ID    | Descrição                                                    | Prioridade |
|-------|--------------------------------------------------------------|------------|
| RF-01 | Criação de conta                                             | Alta       |
| RF-02 | Recuperação de senha                                         | Alta       |
| RF-03 | Seleção de gêneros favoritos                                 | Média      |
| RF-04 | Recomendações pelo histórico                                 | Alta       |
| RF-05 | Registro de avaliação (odiei, curti, amei)                   | Alta       |
| RF-06 | Exibição de sinopse, elenco, gênero, duração                 | Média      |
| RF-07 | Adição a favoritos/assistidos                                | Média      |
| RF-08 | Configurações de notificações                                | Baixa      |
| RF-09 | Busca por filme/série ou ator                                | Média      |
| RF-10 | Alteração de foto de perfil                                  | Baixa      |

| ID     | Descrição                                                    | Prioridade |
|--------|--------------------------------------------------------------|------------|
| RNF-01 | Armazenamento seguro de dados                                | Alta       |
| RNF-02 | Tempo de carregamento ≤ 4 segundos                           | Alta       |
| RNF-03 | Interface intuitiva e responsiva                            | Média      |
| RNF-04 | Autenticação segura com 2FA                                  | Alta       |
| RNF-05 | Compatibilidade cross-platform                               | Média      |
| RNF-06 | Disponibilidade 24/7                                         | Média      |
| RNF-07 | Suporte a alto número de usuários simultâneos                | Baixa      |
| RNF-08 | Suporte offline para histórico e favoritos                   | Média      |

## Justificativas

- Grande volume de conteúdo: plataformas de streaming exigem filtragem eficiente.  
- Necessidade de personalização: evitar recomendações genéricas e repetitivas.  
- Organização do usuário: gerenciamento prático de listas e avaliações.

## Equipe do Projeto

- Guilherme Henrique Chaves Freire – Desenvolvedor Mobile  
- Mateus Lucas Oliveira Siqueira – Desenvolvedor FullStack  
- Ramon Alves Bastos Junior – Analista de Processos  
- Sarah Jardim Lana – Estratégia de Performance e UX  
- Stéfani da Silva Honorio – QA e Documentação

## Instituição e Disciplina

- **Instituto de Informática e Ciências Exatas – PUC Minas**  
- **Bacharelado em Sistemas de Informação**  
- **Disciplina**: Desenvolvimento de Aplicações Móveis  
- **Professor**: Cristiano Neves Rodrigues  
- **Área de Concentração**: Algoritmo de Recomendação de Filmes/Séries  
- **Local**: Belo Horizonte, 2025

## Fontes

- https://www.maxwell.vrac.puc-rio.br/57546/57546.PDF  
- https://www.cnnbrasil.com.br/entretenimento/pesquisa-revela-como-streaming-mudou-habitos-dos-brasileiros-veja/  
- https://www.gruporbs.com.br/conteudosdenegocios/120/a-explosao-do-streaming-no-brasil-75-dos-brasileiros-assistem-a-videos-diariamente

## Licença

Consulte o arquivo **LICENSE.md** para mais detalhes.

# Estrutura de Pastas do Projeto Enxoval Baby

Este documento descreve a organização e estrutura de pastas do projeto Enxoval Baby, seguindo os princípios de Clean Architecture e MVVM.

## Visão Geral

O projeto está organizado em camadas bem definidas, seguindo os princípios de Clean Architecture, com separação clara de responsabilidades:

```
enxoval_baby/
├── lib/
│   ├── app/           # Código principal da aplicação
│   ├── enxoval_baby_app.dart
│   ├── firebase_options.dart
│   └── main.dart
```

## Estrutura Detalhada

### 1. Camada de Configuração (`app/config/`)
```
config/
├── injector/     # Configuração de injeção de dependências
└── navigation/   # Configuração de rotas e navegação
```
- **injector/**: Configuração do GetIt para injeção de dependências
- **navigation/**: Gerenciamento de rotas e navegação do app

### 2. Camada Core (`app/core/`)
```
core/
├── commands/     # Implementação do padrão Command
├── failures/     # Definições de falhas e exceções
├── handler/      # Manipuladores genéricos
├── log/         # Sistema de logging
├── result/      # Tipos de retorno padronizados
└── utils/       # Utilitários gerais
```
- Contém código de infraestrutura e utilitários compartilhados
- Implementa padrões e estruturas fundamentais

### 3. Camada de Dados (`app/data/`)
```
data/
├── datasources/
│   ├── local/   # Fontes de dados locais
│   └── remote/  # Fontes de dados remotas
├── models/      # Modelos de dados
└── repositories/# Implementações dos repositórios
```
- **datasources/**: Implementações concretas de fontes de dados
  - **local/**: SQLite, SharedPreferences, etc.
  - **remote/**: Firebase, APIs REST, etc.
- **models/**: Classes de modelo para serialização/deserialização
- **repositories/**: Implementações concretas das interfaces de repositório

### 4. Camada de Domínio (`app/domain/`)
```
domain/
├── dtos/        # Objetos de Transferência de Dados
├── entities/    # Entidades de domínio
└── repositories/# Interfaces dos repositórios
```
- **dtos/**: Objetos para transferência de dados entre camadas
- **entities/**: Entidades de negócio
- **repositories/**: Contratos (interfaces) dos repositórios

### 5. Camada de Apresentação (`app/presentation/`)
```
presentation/
├── auth/
│   ├── forgot_password/
│   ├── login/
│   │   ├── view/
│   │   ├── view_model/
│   │   └── widgets/
│   ├── logout/
│   └── register/
├── home/
├── onboarding_layette_customization/
└── splash/
```
- Organizada por features/módulos
- Cada feature segue o padrão MVVM:
  - **view/**: Telas e interfaces de usuário
  - **view_model/**: Lógica de apresentação
  - **widgets/**: Componentes reutilizáveis

## Convenções de Nomenclatura

1. **Arquivos**:
   - Usar snake_case para nomes de arquivos
   - Sufixos específicos por tipo:
     - `_screen.dart` para telas
     - `_widget.dart` para widgets
     - `_view_model.dart` para ViewModels
     - `_repository.dart` para interfaces de repositório
     - `_repository_impl.dart` para implementações de repositório

2. **Classes**:
   - Usar PascalCase para nomes de classes
   - Sufixos específicos:
     - `Screen` para telas
     - `Widget` para widgets
     - `ViewModel` para ViewModels
     - `Repository` para interfaces
     - `RepositoryImpl` para implementações

## Benefícios desta Estrutura

1. **Separação de Responsabilidades**:
   - Cada camada tem uma responsabilidade bem definida
   - Facilita manutenção e testes

2. **Escalabilidade**:
   - Estrutura modular permite crescimento organizado
   - Fácil adição de novas features

3. **Testabilidade**:
   - Camadas bem definidas facilitam testes unitários
   - Dependency Injection permite mock de dependências

4. **Reusabilidade**:
   - Componentes isolados podem ser reutilizados
   - Widgets e utilitários compartilhados

5. **Manutenibilidade**:
   - Código organizado e previsível
   - Fácil localização de arquivos e funcionalidades

## Diretrizes de Desenvolvimento

1. **Respeitar as Camadas**:
   - Manter dependências fluindo de fora para dentro
   - Camada de domínio não deve depender de camadas externas

2. **Injeção de Dependência**:
   - Usar GetIt para gerenciamento de dependências
   - Registrar dependências no módulo de injeção apropriado

3. **Organização de Features**:
   - Cada feature em seu próprio diretório
   - Seguir padrão MVVM consistentemente

4. **Reutilização de Código**:
   - Criar widgets reutilizáveis quando possível
   - Utilizar mixins e utilitários do core

# DoeVida

Protótipo de aplicativo Flutter para apoiar a jornada de doadores de sangue em João Pessoa, Paraíba. O projeto reúne cadastro de perfil, informações de hemocentro, agendamento demonstrativo, histórico e exemplos de avisos.

## Objetivos

- Organizar informações úteis para quem deseja doar sangue.
- Exibir uma estimativa da próxima data de doação a partir do perfil.
- Demonstrar uma jornada de seleção de dia e horário.
- Apresentar informações do Hemocentro da Paraíba e exemplos de alertas.

## Funcionalidades demonstradas

- Tela de boas-vindas com acesso ao cadastro.
- Cadastro com nome, e-mail, senha, tipo sanguíneo, intervalo biológico, peso e cidade.
- Navegação inferior entre Início, Hemocentro, Agendar, Histórico e Perfil.
- Resumo do perfil e contador de dias até a próxima data calculada.
- Mapa ilustrativo e informações fixas do hemocentro.
- Seleção de dia e horário, confirmação visual e cancelamento de agendamento.
- Registro demonstrativo de uma doação e atualização do total e da última data.
- Visualização e edição do perfil.
- Telas de exemplo para avisos e lembretes.

## Tecnologias

- Flutter e Dart.
- Material 3 para componentes e tema base.
- `google_fonts` para as fontes Nunito e Fredoka.

## Requisitos

- Flutter SDK instalado e configurado no `PATH`.
- Um destino disponível: emulador Android, dispositivo conectado, Chrome ou Windows Desktop com os requisitos do Flutter para essa plataforma.

Confira a instalação e os dispositivos disponíveis:

```bash
flutter doctor
flutter devices
```

## Como executar

Na pasta raiz do projeto, rode:

```bash
flutter pub get
flutter run
```

Para escolher um destino específico:

```bash
flutter run -d chrome
```

Ou use o identificador mostrado por `flutter devices`, por exemplo:

```bash
flutter run -d <device-id>
```

## Jornada principal

1. A tela de boas-vindas apresenta a proposta do DoeVida.
2. **Começar** abre o formulário de cadastro.
3. Ao criar o perfil, os dados são atualizados na sessão em memória.
4. A tela de avisos explica os lembretes previstos e conduz à área principal.
5. A barra inferior permite abrir as cinco seções do aplicativo.

## Estrutura do projeto

```text
lib/
├── main.dart
├── theme.dart
├── models/
│   └── user_session.dart
├── screens/
│   ├── alert_screen.dart
│   ├── enable_alerts_screen.dart
│   ├── hemocenter_screen.dart
│   ├── history_screen.dart
│   ├── home_screen.dart
│   ├── main_shell.dart
│   ├── profile_screen.dart
│   ├── schedule_screen.dart
│   ├── signup_screen.dart
│   └── welcome_screen.dart
└── widgets/
    └── common.dart
```

### Arquivos principais

| Arquivo | Responsabilidade |
| --- | --- |
| `lib/main.dart` | Inicializa o Flutter, configura o tema e abre a tela de boas-vindas. |
| `lib/theme.dart` | Define cores, tipografia, dados fixos do hemocentro e função auxiliar de intervalo. |
| `lib/models/user_session.dart` | Define `UserProfile` e a sessão compartilhada `UserSession`, incluindo atualização de perfil e registro demonstrativo de doação. |
| `lib/widgets/common.dart` | Componentes reutilizáveis: `PrimaryButton`, `AppCard`, `InfoLine` e `IconBox`. |
| `lib/screens/main_shell.dart` | Mantém a navegação inferior e alterna entre as seções principais. |
| `lib/screens/home_screen.dart` | Exibe saudação, contador, progresso, orientações e atalhos. |
| `lib/screens/hemocenter_screen.dart` | Exibe mapa ilustrativo e informações fixas do hemocentro. |
| `lib/screens/schedule_screen.dart` | Demonstra seleção de data e horário, confirmação e cancelamento. |
| `lib/screens/history_screen.dart` | Exibe registros de exemplo e permite registrar uma doação demonstrativa. |
| `lib/screens/profile_screen.dart` | Exibe e edita os dados do perfil. |
| `lib/screens/welcome_screen.dart` | Apresenta a proposta e inicia o cadastro. |
| `lib/screens/signup_screen.dart` | Formulário de cadastro e atualização inicial da sessão. |
| `lib/screens/enable_alerts_screen.dart` | Explica os tipos de aviso previstos no conceito do app. |
| `lib/screens/alert_screen.dart` | Mostra exemplos visuais de alerta urgente e lembrete. |

# Roadmap e Checklist Sequencial — MVP Enxoval Baby

## 1️⃣ Configuração Inicial do Projeto
- [✅] Criar projeto Flutter (`enxoval_baby`)
- [✅] Configurar Firebase (Auth + Firestore) e gerar `firebase_options.dart`
- [✅] Configurar hospedagem do JSON genérico (quente/frio/tropical) na Vercel
- [✅] Implementar arquitetura base (MVVM + Commands + UseCases + Repository Pattern)
- [✅] Configurar injeção de dependência com GetIt
- [✅] Criar camadas `core`, `data`, `domain` e `presentation`

---

## 2️⃣ Autenticação e Controle de Acesso
- [✅] Implementar telas e fluxo de **Login**
- [✅] Implementar **Esqueci minha senha**
- [✅] Implementar tela e fluxo de **Registro**
- [✅] [Criar manutenção de sessão (Firebase Auth + Cache Local)]
- [✅] Criar coleção `users` no Firestore para armazenar dados do usuário
- [ ] Salvar dados de perfil base na coleção `users`
- [ ] Salvar foto de perfil na coleção `users`
- [✅] Implementar **Logout**
- [ ] Implementar **Login com Google** (widget dedicado)

---

## 3️⃣ Onboarding e Criação do Perfil do Enxoval
- [ ] Implementar fluxo de **onboarding** (telas introdutórias)
- [✅] Criar onboarding de perfil do enxoval (`layetteProfile`) com os campos:
  ```json
  {
    "sexBaby": null,
    "nameBaby": null,
    "dueDate": null,
    "climate": "quente",
    "familyProfile": null,
    "layetteDurationInMonths": 6,
  }
- [ ] Salvar perfil no SQLite
- [ ] Sincronizar perfil no Firestore
- [ ] Implementar validações e máscaras

---

## 4️⃣ Importação e Armazenamento da Lista Inicial
- [✅] [Baixar lista genérica da Vercel]
- [✅] Converter JSON em entidades
- [✅] Salvar dados no SQLite
- [✅] Salvar dados no Firestore
- [ ] Criar campo syncStatus para controle de sincronização
- [ ] Implementar merge e prevenção de duplicatas

---

## 5️⃣ Funcionalidades de Organização e Personalização
- [ ] Tela de listagem do enxoval (progresso e gastos)
- [ ] Tela de listagem por categoria
- [ ] Tela de visualização/edição de item
- [ ] Adicionar, editar e excluir itens
- [ ] Marcar item como comprado ou presente
- [ ] Atualizar quantidade e valor
- [ ] Adicionar notas e links de compra

---

## 6️⃣ Cálculos Automáticos
- [ ] Calcular progresso por categoria e global
- [ ] Calcular total planejado, gasto e comprado
- [ ] Recalcular valores automaticamente
- [ ] Mostrar indicadores visuais

---

## 7️⃣ Sincronização e Offline-First
- [ ] Garantir funcionamento completo offline
- [ ] Sincronização manual com Firestore
- [ ] Respeitar limite do plano free (1 sync/dia)
- [ ] Sincronização ilimitada no plano premium
- [ ] Notificar pendências de sincronização
- [ ] [Criar fila de alterações offline]

---

## 8️⃣ Limitações do Plano Free e Benefícios Premium
- [ ] Restringir free a 1 enxoval ativo
- [ ] Restringir free a 1 compartilhamento por enxoval
- [ ] Exibir anúncios no plano free
- [ ] Ativar recursos premium

---

## 9️⃣ Testes e Qualidade
- [ ] [Testes unitários (domain e data)]
- [ ] [Testes de integração (SQLite + Firestore)]
- [ ] [Testes de widget]
- [ ] [Revisão de performance e consumo de dados]
- [ ] [Revisão de acessibilidade]
- [ ] [Testes em dispositivos físicos e emuladores]

---

## 🔟 Entrega e Publicação
- [ ] [Entrega beta interna]
- [ ] [Publicação Google Play]
- [ ] [Publicação App Store]
- [ ] [Landing page de divulgação]

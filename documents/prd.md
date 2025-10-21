# Product Requirements Document (PRD) — Enxoval Baby MVP

## 1. Visão Geral
O **Enxoval Baby** é um aplicativo mobile que auxilia pais — especialmente os de primeira viagem — a organizar, personalizar e acompanhar o enxoval do bebê de forma prática.

O **MVP** terá como pilares:
- Lista inicial de enxoval adaptada ao clima.
- Controle de progresso e gastos.
- Funcionalidade **offline-first**, com sincronização manual e seletiva na nuvem.

O modelo de negócios será **freemium**, com recursos básicos gratuitos e funcionalidades avançadas no plano **premium**.

---

## 2. Objetivos do MVP
- **Organização inteligente**: fornecer listas adaptadas ao clima (quente, frio ou tropical).
- **Controle prático**: acompanhar compras, presentes e orçamento.
- **Uso sem internet**: funcionamento completo offline, com opção de sincronizar.
- **Base escalável**: preparar terreno para futuras integrações com IA e marketplace.

---

## 3. Funcionalidades

### 3.1 Lista Inicial
- Importação automática de lista genérica hospedada na Vercel (JSON).
- Adaptação baseada no clima informado.
- Armazenamento local em **SQLite**.

### 3.2 Organização de Conteúdo
- Estrutura em **Enxoval → Categorias → Itens**.
- Campos para cada item: nome, quantidade, valor, status (comprado/presente), notas, links de compra.

### 3.3 Personalização
- Adicionar, editar ou excluir itens e categorias.
- Ajustar quantidades e preços.
- Marcar itens como comprados ou recebidos como presente.

### 3.4 Cálculos Automáticos
- Progresso por categoria e total.
- Controle de gastos: total planejado, total gasto, total comprado.

### 3.5 Sincronização Offline-First
- Armazenamento primário no dispositivo.
- Sincronização manual seletiva com Firebase Firestore.
- Limite de 1 sincronização por dia no plano gratuito.

### 3.6 Limitações do Plano Free
- Apenas 1 enxoval ativo.
- 1 compartilhamento por enxoval.
- 1 sincronização manual/dia.
- Exibição de anúncios.
- Personalização limitada.

### 3.7 Benefícios do Plano Premium
- Múltiplos enxovais.
- Sincronização ilimitada.
- Relatórios financeiros detalhados.
- Personalização completa.
- Conteúdo exclusivo (dicas, vídeos, histórias bíblicas, orações).
- Sem anúncios.

---

## 4. Público-Alvo
Pais e mães que buscam praticidade e organização no planejamento do enxoval, com foco nos de primeira viagem.

---

## 5. Tecnologias
- **Frontend:** Flutter (Dart, Material Design).
- **Armazenamento Local:** SQLite (sqflite).
- **Backend:** Firebase Auth, Firestore, JSON hospedado na Vercel.
- **Arquitetura:** MVVM + Commands + UseCases + Repository Pattern + GetIt.

---

## 6. Métricas de Sucesso
- % de usuários que completam mais de 50% do enxoval.
- Taxa de sucesso das sincronizações.
- Retenção de usuários após 30 dias (D30).
- Taxa de conversão de free para premium.

---

## 7. Restrições
- Sem marketplace integrado (apenas links externos de compra).
- Sincronização apenas manual.
- Custos de nuvem controlados com sincronização seletiva.

---

## 8. Evoluções Futuras (Pós-MVP)
- Backend próprio (Java + Spring Boot).
- Geração automática de listas com IA.
- Integração com marketplace e recomendações personalizadas.
- IA treinada com dados reais (anonimizados) do MVP.

---

## 9. MVP Scope Table

| **Funcionalidade** | **Incluído no MVP** | **Fora do MVP** |
|--------------------|--------------------|-----------------|
| Lista inicial adaptada ao clima | ✅ | ❌ |
| Importação via JSON (Vercel) | ✅ | ❌ |
| Armazenamento local (SQLite) | ✅ | ❌ |
| Estrutura Enxoval → Categorias → Itens | ✅ | ❌ |
| Campos de item (nome, qtd, valor, status, notas, links) | ✅ | ❌ |
| Adicionar/editar/excluir itens | ✅ | ❌ |
| Ajustar quantidades e preços | ✅ | ❌ |
| Marcar como comprado/presente | ✅ | ❌ |
| Cálculo automático de progresso e gastos | ✅ | ❌ |
| Sincronização offline-first (manual) | ✅ | ❌ |
| Limitações do plano free (1 enxoval, 1 sync/dia, anúncios) | ✅ | ❌ |
| Benefícios premium (multi-enxovais, sync ilimitado, relatórios, personalização total, conteúdo exclusivo) | ✅ | ❌ |
| Login/registro (Firebase Auth) | ✅ | ❌ |
| Testes unitários e de integração | ✅ | ❌ |
| Marketplace integrado | ❌ | ✅ |
| Sincronização automática | ❌ | ✅ |
| IA para geração automática de listas | ❌ | ✅ |
| Backend próprio (Java + Spring Boot) | ❌ | ✅ |
| Integração com marketplace e recomendações personalizadas | ❌ | ✅ |

---

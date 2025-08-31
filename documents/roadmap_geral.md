# Roadmap Geral — Enxoval Baby

## 📌 MVP (Primeiro Lançamento)
- Lista inicial adaptada ao clima (quente, frio, tropical)
- Importação via JSON hospedado na Vercel
- Armazenamento local em SQLite (offline-first)
- Estrutura Enxoval → Categorias → Itens
- Campos de item: nome, quantidade, valor, status (comprado/presente), notas, links de compra
- Adicionar, editar e excluir itens/categorias
- Ajustar quantidades e preços
- Marcar itens como comprados ou presentes
- Cálculo automático de progresso e gastos
- Sincronização manual seletiva com Firebase Firestore
- Limitações do plano free:
  - 1 enxoval ativo
  - 1 sincronização manual/dia
  - 1 compartilhamento por enxoval
  - Personalização limitada
  - Exibição de anúncios
- Benefícios premium:
  - Múltiplos enxovais
  - Sincronização ilimitada
  - Relatórios financeiros detalhados
  - Personalização completa
  - Conteúdo exclusivo (dicas, vídeos, histórias bíblicas, orações)
  - Sem anúncios
- Login e registro via Firebase Auth
- Testes unitários e de integração

---

## 🚀 Pós-MVP (Próximas Versões)
- Backend próprio (Java + Spring Boot)
- Sincronização automática
- IA para geração automática de listas com base no perfil do usuário
- Personalização avançada com sugestões inteligentes
- Melhorias de UI/UX com animações e feedback visual
- Relatórios mais completos (comparação com média de outros usuários)

---

## 🌟 Longo Prazo
- Integração com marketplace (compra direta no app)
- Recomendação personalizada de produtos (baseada em IA)
- Sistema de troca e venda de itens usados entre usuários
- Gamificação (medalhas, conquistas por completar listas)
- Comunidade e fóruns de dicas entre pais
- Tradução e expansão internacional (multi-idiomas)

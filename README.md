# Medi Sync - Banco de Dados (PostgreSQL)

Este repositório contém o script inicial do banco de dados **Medi Sync**, responsável por gerenciar:
- Cadastro de usuários (pacientes);
- Cadastro de médicos;
- Agendamento de consultas;
- Feedback de consultas (avaliações);
- Recomendações básicas.

---

## Como usar o script SQL

### 1. Pré-requisitos
- PostgreSQL instalado (versão 13+ recomendada).
- pgAdmin ou terminal `psql` configurado.

### 2. Executando o script
1. Clone este repositório:
   ```bash
   git clone https://github.com/seu-usuario/medi-sync.git
   cd medi-sync
   ```

2. Acesse o terminal do PostgreSQL:
   ```bash
   psql -U postgres
   ```

3. Execute o script SQL para criar o banco e tabelas:
   ```bash
   \i medi_sync.sql
   ```

Isso criará automaticamente o banco medisync com as tabelas necessárias.

---

## Estrutura do Banco

- **usuarios** → pacientes cadastrados.
- **medicos** → profissionais de saúde.
- **consultas** → agenda de consultas (com status: agendada, realizada, cancelada).
- **feedback** → avaliações feitas pelos pacientes após consultas.

---

## Integração com Backend

Este banco pode ser integrado a um backend em **Node.js (Express + Sequelize)** ou **Python (Django/FastAPI)**.

### Exemplo de variáveis de ambiente (`.env`):

```env
DB_NAME=medisync
DB_USER=postgres
DB_PASS=sua_senha
DB_HOST=localhost
DB_PORT=5432
JWT_SECRET=chave_super_secreta
```

No backend, basta configurar o ORM (Sequelize, Django ORM ou SQLAlchemy) para usar essas credenciais.

---

## Próximos Passos

- Criar rotas de API para cadastro, login, agendamento e feedback.
- Implementar recomendações baseadas no histórico do paciente e nas avaliações dos médicos.
- Adicionar testes automatizados para validar as queries.

---

👩‍💻 Desenvolvido para o projeto Medi Sync - Sprint 2

-- Medi Sync - Estrutura Inicial do Banco (PostgreSQL)

-- Criar o banco
CREATE DATABASE medisync
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'pt_BR.UTF-8'
    LC_CTYPE = 'pt_BR.UTF-8'
    TEMPLATE template0;

\c medisync;

-- =========================================
-- TABELA USUÁRIOS (pacientes-RF-001, RN-001)
-- =========================================
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    cpf VARCHAR(11) UNIQUE NOT NULL,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(120) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    telefone VARCHAR(20),
    convenio VARCHAR(100),
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================================
-- TABELA MÉDICOS (Diretório básico, para agendamento)

-- =========================================
CREATE TABLE medicos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    especialidade VARCHAR(100) NOT NULL,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================================
-- TABELA CONSULTAS (RF-002, RF-004)
-- =========================================
CREATE TABLE consultas (
    id SERIAL PRIMARY KEY,
    paciente_id INT NOT NULL,
    medico_id INT NOT NULL,
    especialidade VARCHAR(100) NOT NULL,
    data_hora TIMESTAMP NOT NULL,
    status VARCHAR(20) DEFAULT 'agendada' CHECK (status IN ('agendada','realizada','cancelada')),
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_paciente FOREIGN KEY (paciente_id) REFERENCES usuarios (id) ON DELETE CASCADE,
    CONSTRAINT fk_medico FOREIGN KEY (medico_id) REFERENCES medicos (id) ON DELETE CASCADE
);

-- =========================================
-- TABELA FEEDBACK (avaliação das consultas)
-- =========================================
CREATE TABLE feedback (
    id SERIAL PRIMARY KEY,
    consulta_id INT NOT NULL,
    paciente_id INT NOT NULL,
    nota INT CHECK (nota BETWEEN 1 AND 5),
    comentario TEXT,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_consulta FOREIGN KEY (consulta_id) REFERENCES consultas (id) ON DELETE CASCADE,
    CONSTRAINT fk_paciente_feedback FOREIGN KEY (paciente_id) REFERENCES usuarios (id) ON DELETE CASCADE
);

-- =========================================
-- ÍNDICES PARA PERFORMANCE(ex: histórico RF-003)
-- =========================================
CREATE INDEX idx_usuario_cpf ON usuarios (cpf);
CREATE INDEX idx_consulta_data ON consultas (data_hora);
CREATE INDEX idx_medico_especialidade ON medicos (especialidade);

-- =========================================
-- DADOS INICIAIS 
-- =========================================
INSERT INTO medicos (nome, especialidade, crm, disponibilidade) VALUES
('Dr. Ana Silva', 'Cardiologia', 'CRM12345', '{"dias": ["seg", "qua"], "horarios": ["09:00", "14:00"]}'),
('Dr. João Santos', 'Endocrinologia', 'CRM67890', '{"dias": ["ter", "qui"], "horarios": ["10:00", "15:00"]}');
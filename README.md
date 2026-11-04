##Banco de Dados Rotior — Sistema Integrativo de Gestão Pessoal

O **Rotior** é um banco de dados relacional projetado para integrar o planejamento de rotinas, hábitos e tarefas com o controle e acompanhamento de finanças pessoais.

---

## 1. Domínio do Banco de Dados

O domínio do sistema abrange a **Gestão Pessoal Integrada**, cobrindo duas áreas cruciais do cotidiano:
1. **Produtividade e Hábitos:** Agrupamento de rotinas diárias/semanais, detalhamento de tarefas por prioridade, agendamento por dias da semana, alertas/lembretes de antecedência e histórico diário de execução.
2. **Controle Financeiro:** Gestão de contas bancárias em múltiplas instituições, categorização unificada de receitas e despesas, lançamentos financeiros vinculados ou não a tarefas, além do planejamento e depósitos em metas financeiras.

---

## 2. Contextualização

### A Empresa / Cenário
Usuários organizam suas rotinas e finanças utilizando múltiplos aplicativos isolados, planilhas eletrônicas desconectadas ou anotações físicas. 

### Problemas Enfrentados sem um SGBD Relacional
* **Redundância e Inconsistência:** O mesmo dado (ex: categoria "Alimentação") precisa ser recriado em diferentes lugares, gerando divergências de grafia e tipo.
* **Falta de Integridade Referencial:** Excluir uma conta bancária ou uma rotina deixa registros de lançamentos ou tarefas "órfãs" sem vínculo claro.
* **Perda de Histórico:** Dificuldade em rastrear se uma tarefa financeira (ex: "Pagar Aluguel") foi efetivamente cumprida e qual lançamento no extrato bancário corresponde a ela.
* **Ausência de Alertas e Métricas:** Impossibilidade de correlacionar o cumprimento de hábitos com os resultados de economia/investimentos das metas financeiras.

---

## 3. Proposta de Melhoria — Solução com SGBD Relacional

A implementação do **Rotior** em um SGBD Relacional (**MySQL 8.0**) resolve esses gargalos operacionais através de:
* **Centralização e Unicidade:** Tabelas de domínio unificadas (`categoria`, `instituicao`, `dia_semana`) para evitar duplicidade de dados.
* **Integridade Referencial Estrita:** Utilização de Chaves Estrangeiras (`FOREIGN KEY`) com regras automatizadas em cascata (`ON DELETE CASCADE`, `ON UPDATE CASCADE`) ou restritivas (`ON DELETE RESTRICT`).
* **Rastreabilidade Integrada:** Relacionamento opcional `0:1` entre a tabela `tarefa` e `lancamento`, permitindo saber exatamente se um compromisso da rotina gerou um impacto financeiro no saldo da conta.
* **Histórico Seguro:** Registro individualizado de execuções de tarefas (`execucao_tarefa`) e aportes em metas (`aporte_meta`).

---

## 4. Modelagem Lógica do Banco de Dados

### 📂 Estrutura de Arquivos da Solução

```
atividadeIII/
├── rotior_usuario.sql           # Cadastro principal de usuários
├── rotior_perfil_usuario.sql    # Informações complementares (Telefone, Renda)
├── rotior_instituicao.sql       # Instituições financeiras (Bancos/Corretoras)
├── rotior_conta.sql             # Contas bancárias dos usuários
├── rotior_dia_semana.sql        # Tabela domínio com os dias da semana
├── rotior_categoria.sql         # Categoria unificada (Tarefa, Receita, Despesa)
├── rotior_rotina.sql            # Rotinas vinculadas aos usuários
├── rotior_tarefa.sql            # Tarefas pertencentes a uma rotina
├── rotior_tarefa_dia.sql        # Associação de tarefas aos dias da semana (N:N)
├── rotior_lembrete.sql          # Alertas e notificações de antecedência
├── rotior_execucao_tarefa.sql   # Histórico diário e status de execução das tarefas
├── rotior_lancamento.sql        # Movimentações financeiras (Receitas/Despesas)
├── rotior_meta_financeira.sql   # Metas e objetivos financeiros
└── rotior_aporte_meta.sql       # Histórico de depósitos para metas
```

---

### 📐 Diagrama Entidade-Relacionamento (Mermaid)

```mermaid
erDiagram
    %% MÓDULO DE USUÁRIO E CONTA
    usuario ||--o| perfil_usuario : "possui (1:1)"
    usuario ||--o{ rotina : "possui (1:N)"
    usuario ||--o{ conta : "possui (1:N)"
    usuario ||--o{ meta_financeira : "define (1:N)"
    
    instituicao ||--o{ conta : "registra (1:N)"
    
    %% MÓDULO DE ROTINAS E TAREFAS
    rotina ||--o{ tarefa : "contém (1:N)"
    categoria ||--o{ tarefa : "classifica (1:N)"
    categoria ||--o{ lancamento : "classifica (1:N)"
    
    tarefa ||--o{ lembrete : "possui (1:N)"
    tarefa ||--o{ execucao_tarefa : "gera histórico (1:N)"
    tarefa ||--o{ tarefa_dia : "agenda em (N:N)"
    dia_semana ||--o{ tarefa_dia : "pertence a (N:N)"
    
    %% MÓDULO FINANCEIRO
    conta ||--o{ lancamento : "registra (1:N)"
    conta ||--o{ aporte_meta : "origina pagamento (1:N)"
    tarefa }|--o| lancamento : "vincula opcionalmente (0:1)"
    meta_financeira ||--o{ aporte_meta : "recebe (1:N)"

    usuario {
        int id_usuario PK
        string nome_usuario
        string email_usuario
        string senha_hash
        date data_nascimento
        datetime data_cadastro
    }

    perfil_usuario {
        int id_usuario PK, FK
        string telefone
        decimal renda_mensal
    }

    instituicao {
        int id_instituicao PK
        string nome_instituicao
        char codigo_compe
    }

    conta {
        int id_conta PK
        int id_usuario FK
        int id_instituicao FK
        string apelido_conta
        enum tipo_conta
        decimal saldo_inicial
    }

    rotina {
        int id_rotina PK
        int id_usuario FK
        string nome_rotina
        string descricao
        date data_inicio
        boolean ativa
    }

    categoria {
        int id_categoria PK
        string nome_categoria
        enum tipo_categoria
    }

    tarefa {
        int id_tarefa PK
        int id_rotina FK
        int id_categoria FK
        string titulo
        string descricao
        time horario_previsto
        int duracao_min
        enum prioridade
    }

    tarefa_dia {
        int id_tarefa PK, FK
        tinyint id_dia PK, FK
    }

    dia_semana {
        tinyint id_dia PK
        string nome_dia
    }

    lembrete {
        int id_lembrete PK
        int id_tarefa FK
        int antecedencia_min
    }

    execucao_tarefa {
        int id_execucao PK
        int id_tarefa FK
        date data_execucao
        enum status_execucao
        time hora_conclusao
        string observacao
    }

    lancamento {
        int id_lancamento PK
        int id_conta FK
        int id_categoria FK
        int id_tarefa FK
        string descricao
        decimal valor
        enum tipo_lancamento
        date data_vencimento
        date data_pagamento
        enum status_lancamento
    }

    meta_financeira {
        int id_meta PK
        int id_usuario FK
        string nome_meta
        decimal valor_alvo
        date data_limite
        enum status_meta
    }

    aporte_meta {
        int id_aporte PK
        int id_meta FK
        int id_conta FK
        decimal valor_aporte
        date data_aporte
    }
```

---

### 📚 Dicionário de Dados e Mapeamento de Cardinalidades

#### 1. Módulo de Usuários
| Tabela | Descrição | Cardinalidade / Relação | Principais Atributos e Chaves |
| :--- | :--- | :--- | :--- |
| **`usuario`** | Tabela principal de acesso e identificação | Base do sistema | `id_usuario` (PK), `nome_usuario`, `email_usuario` (UNIQUE), `senha_hash` |
| **`perfil_usuario`** | Informações complementares de perfil | **1:1** com `usuario` | `id_usuario` (PK, FK `usuario.id_usuario`), `telefone`, `renda_mensal` |

#### 2. Módulo de Rotinas e Hábitos
| Tabela | Descrição | Cardinalidade / Relação | Principais Atributos e Chaves |
| :--- | :--- | :--- | :--- |
| **`rotina`** | Agrupadores de hábitos por objetivo | **1:N** com `usuario` | `id_rotina` (PK), `id_usuario` (FK), `nome_rotina`, `ativa` (BOOLEAN) |
| **`categoria`** | Domínio unificado de tipos de atividades | Domínio independente | `id_categoria` (PK), `nome_categoria`, `tipo_categoria` (`TAREFA`, `RECEITA`, `DESPESA`) |
| **`tarefa`** | Ações específicas da rotina | **1:N** com `rotina` e `categoria` | `id_tarefa` (PK), `id_rotina` (FK), `id_categoria` (FK), `prioridade` (`BAIXA`, `MEDIA`, `ALTA`) |
| **`tarefa_dia`** | Agendamento semanal repetitivo | **N:N** entre `tarefa` e `dia_semana` | (`id_tarefa`, `id_dia`) (PK Composta), `id_tarefa` (FK), `id_dia` (FK) |
| **`dia_semana`** | Tabela estática dos dias da semana | Domínio independente | `id_dia` (PK), `nome_dia` (UNIQUE) |
| **`lembrete`** | Configurações de notificação | **1:N** com `tarefa` | `id_lembrete` (PK), `id_tarefa` (FK), `antecedencia_min` |
| **`execucao_tarefa`** | Registro diário de cumprimento | **1:N** com `tarefa` | `id_execucao` (PK), `id_tarefa` (FK), `status_execucao` (`PENDENTE`, `CONCLUIDA`, `ADIADA`, `CANCELADA`) |

#### 3. Módulo Financeiro
| Tabela | Descrição | Cardinalidade / Relação | Principais Atributos e Chaves |
| :--- | :--- | :--- | :--- |
| **`instituicao`** | Instituições financeiras e bancos | Domínio para contas | `id_instituicao` (PK), `nome_instituicao` (UNIQUE), `codigo_compe` |
| **`conta`** | Contas de depósito/investimento | **1:N** com `usuario` e `instituicao` | `id_conta` (PK), `id_usuario` (FK), `id_instituicao` (FK), `tipo_conta` (`CORRENTE`, `POUPANCA`, `CARTEIRA`, `INVESTIMENTO`) |
| **`lancamento`** | Entradas e saídas de valores | **1:N** com `conta`, `categoria` e **0:1** com `tarefa` | `id_lancamento` (PK), `id_conta` (FK), `id_categoria` (FK), `id_tarefa` (FK Opcional), `tipo_lancamento` (`RECEITA`, `DESPESA`), `status_lancamento` |
| **`meta_financeira`** | Objetivos de poupança/investimento | **1:N** com `usuario` | `id_meta` (PK), `id_usuario` (FK), `valor_alvo`, `data_limite`, `status_meta` |
| **`aporte_meta`** | Histórico de depósitos para a meta | **1:N** com `meta_financeira` e `conta` | `id_aporte` (PK), `id_meta` (FK), `id_conta` (FK), `valor_aporte`, `data_aporte` |

---

## 5. Aplicação das Formas Normais (1FN, 2FN, 3FN e 4FN)

A modelagem do **Rotior** seguiu um rigoroso processo de normalização para evitar anomalias de inserção, alteração e exclusão:

### Primeira Forma Normal (1FN)
* **Regra:** Todos os atributos devem ser atômicos (indivisíveis) e não devem existir colunas multivaloradas ou listas separadas por vírgula.
* **Aplicação no Rotior:** Em vez de armazenar os dias da semana em que uma tarefa ocorre em uma string (ex: `"Segunda, Quarta, Sexta"` na tabela `tarefa`), criou-se a tabela intermediária `tarefa_dia`. Da mesma forma, cada lembrete de antecedência em minutos é um registro individual na tabela `lembrete`.

### Segunda Forma Normal (2FN)
* **Regra:** Estar na 1FN e garantir que todos os atributos não-chave dependam de toda a chave primária (eliminar dependências parciais em tabelas de chave composta).
* **Aplicação no Rotior:** Na tabela de associação `tarefa_dia`, a chave primária é composta por `(id_tarefa, id_dia)`. Nenhum atributo descritivo como `nome_dia` foi mantido nessa tabela, pois `nome_dia` dependeria apenas de `id_dia`, pertencendo exclusivamente à tabela estática `dia_semana`.

### Terceira Forma Normal (3FN)
* **Regra:** Estar na 2FN e garantir que nenhum atributo não-chave dependa de outro atributo não-chave (eliminar dependências transitivas).
* **Aplicação no Rotior:** Na tabela `conta`, o banco de dados armazena apenas `id_instituicao` (FK). O nome e o código COMPE do banco pertencem à tabela `instituicao`. Se fossem armazenados diretamente em `conta`, haveria dependência transitiva (`id_conta` $\rightarrow$ `id_instituicao` $\rightarrow$ `nome_instituicao`). O mesmo principio se aplica entre `usuario` e `perfil_usuario`.

### Quarta Forma Normal (4FN)
* **Regra:** Estar na 3FN e garantir a ausência de dependências multivaloradas independentes no mesmo relacionamento.
* **Aplicação no Rotior:** Uma tarefa possui múltiplos dias de execução e também múltiplos lembretes de notificação. Se dias e lembretes fossem combinados em uma única tabela ligada à `tarefa`, teríamos o produto cartesiano das duas listas (anomalia de dependência multivalorada). A 4FN garante que `tarefa_dia` e `lembrete` sejam tabelas independentes ligadas diretamente à `tarefa`.

---

## 6. Informações Técnicas e Glossário

* **SGBD:** MySQL 8.0.46 (gerado via MySQL Workbench)
* **Nome do Banco de Dados:** `rotior`
* **Credenciais Padrão (Ambiente Local):** `root` / `root`

### Glossário Técnico Simplificado

* **Engine (`InnoDB`):** Mecanismo de armazenamento padrão do MySQL. Oferece suporte a Transações (ACID) e garante a integridade dos dados por meio de Chaves Estrangeiras (`FOREIGN KEY`).
* **Charset (`utf8mb4`):** Codificação de caracteres universais de 4 bytes. Suporta todos os caracteres da língua portuguesa (acentuação e cedilha) e símbolos/emojis.
* **Collation (`utf8mb4_0900_ai_ci`):** Regras de comparação de texto:
  * `ai` (*Accent Insensitive*): Ignora acentos na comparação (ex: `"saúde"` é igual a `"saude"`).
  * `ci` (*Case Insensitive*): Ignora diferença entre maiúsculas e minúsculas (ex: `"aluguel"` é igual a `"ALUGUEL"`).

---

## 7. Guia de Instalação, Execução e Passo a Passo do Dump

### 1. Criar a Base de Dados no MySQL

Conecte-se ao MySQL Server e execute:

```sql
CREATE DATABASE IF NOT EXISTS rotior
CHARACTER SET utf8mb4
COLLATE utf8mb4_0900_ai_ci;

USE rotior;
```

### 2. Ordem Sequencial de Importação (Dependência de FKs)

Devido às restrições de Chaves Estrangeiras, os arquivos SQL devem ser executados rigorosamente na seguinte ordem:

1. `rotior_usuario.sql`
2. `rotior_perfil_usuario.sql`
3. `rotior_instituicao.sql`
4. `rotior_conta.sql`
5. `rotior_dia_semana.sql`
6. `rotior_categoria.sql`
7. `rotior_rotina.sql`
8. `rotior_tarefa.sql`
9. `rotior_tarefa_dia.sql`
10. `rotior_lembrete.sql`
11. `rotior_execucao_tarefa.sql`
12. `rotior_lancamento.sql`
13. `rotior_meta_financeira.sql`
14. `rotior_aporte_meta.sql`

---

### 💡 Dica de Automação de Importação em Lote via Terminal

Para importar todos os scripts em uma única linha de comando sem erros:

* **Windows (PowerShell):**
  ```powershell
  Get-Content rotior_*.sql | mysql -u root -proot rotior
  ```

* **Linux / macOS (Bash):**
  ```bash
  cat rotior_*.sql | mysql -u root -proot rotior
  ```

---

### 📦 Passo a Passo para Gerar o Dump Completo (Estrutura e Dados)

Caso deseje gerar um novo dump único contendo toda a estrutura e dados atualizados do banco `rotior`:

#### Via MySQL Workbench (Interface Gráfica):
1. Abra o **MySQL Workbench** e conecte-se ao seu servidor local.
2. No menu superior, acesse **Server** $\rightarrow$ **Data Export**.
3. Selecione o schema **`rotior`** no painel esquerdo.
4. Escolha a opção **Dump Structure and Data**.
5. Selecione a opção **Export to Self-Contained File** e defina o caminho do arquivo (ex: `dump_rotior_completo.sql`).
6. Marque a opção **Include Create Schema** para incluir a instrução de criação do banco.
7. Clique no botão **Start Export**.

#### Via Linha de Comando (`mysqldump`):
Abra o terminal/prompt e execute o comando:
```bash
mysqldump -u root -proot --databases rotior --routines --triggers --events > dump_rotior_completo.sql
```

---

## 8. Orientações de Versionamento e Entrega

1. **Commit no Repositório Git:**
   * Inclua todos os arquivos `.sql` originais na pasta do projeto.
   * Certifique-se de que o arquivo `README.md` com esta documentação completa esteja na raiz.
   * Realize os comandos:
     ```bash
     git add .
     git commit -m "docs: adiciona documentacao completa e scripts SQL do banco Rotior"
     git push origin main
     ```
2. **Submissão no Classroom:**
   * Envie o link público do seu repositório Git.
   * Anexe o print visual da modelagem ER (gerado através do MySQL Workbench em *Database -> Reverse Engineer* ou a captura do diagrama Mermaid renderizado).nta_o_do_banco_de_dados_rotior (1).md…]()


### Link das documentações

[RotinOr_Documentacao.docx](https://github.com/user-attachments/files/34271432/RotinOr_Documentacao.docx)

[documenta_o_do_banco_de_dados_rotior.md](https://github.com/user-attachments/files/34271225/documenta_o_do_banco_de_dados_rotior.md)


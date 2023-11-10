-- Trigger para atualizar a quantidade de estoque do livro após a inserção de um empréstimo
DELIMITER //
CREATE TRIGGER atualiza_estoque
AFTER INSERT ON emprestimos
FOR EACH ROW
BEGIN
    UPDATE livros
    SET quantidade_estoque = quantidade_estoque - 1
    WHERE id_livro = NEW.id_livro;
END;
//
DELIMITER ;

-- Trigger para atualizar o saldo da conta após a inserção de uma transação
DELIMITER //
CREATE TRIGGER atualiza_saldo
AFTER INSERT ON transacoes
FOR EACH ROW
BEGIN
    DECLARE valor_transacao DECIMAL(10, 2);
    SET valor_transacao = NEW.valor;

    IF NEW.tipo = 'entrada' THEN
        UPDATE contas
        SET saldo = saldo + valor_transacao
        WHERE id_conta = NEW.id_conta;
    ELSE
        UPDATE contas
        SET saldo = saldo - valor_transacao
        WHERE id_conta = NEW.id_conta;
    END IF;
END;
//
DELIMITER ;

-- Trigger para verificar a data de admissão de funcionários
DELIMITER //
CREATE TRIGGER verifica_data_admissao
BEFORE INSERT ON funcionarios
FOR EACH ROW
BEGIN
    IF NEW.data_admissao <= CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A data de admissão deve ser maior que a data atual.';
    END IF;
END;
//
DELIMITER ;

-- Trigger para verificar a quantidade em estoque antes de inserir um item de venda
DELIMITER //
CREATE TRIGGER verifica_estoque
BEFORE INSERT ON itens_venda
FOR EACH ROW
BEGIN
    DECLARE estoque_atual INT;
    SELECT quantidade_estoque INTO estoque_atual
    FROM produtos
    WHERE id_produto = NEW.id_produto;

    IF NEW.quantidade > estoque_atual THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O produto está fora de estoque.';
    END IF;
END;
//
DELIMITER ;

-- Trigger para verificar a idade do aluno antes de inserir uma matrícula
DELIMITER //
CREATE TRIGGER verifica_idade_aluno
BEFORE INSERT ON matriculas
FOR EACH ROW
BEGIN
    DECLARE idade_aluno INT;
    SELECT YEAR(NEW.data_matricula) - YEAR((SELECT data_nascimento FROM alunos WHERE id_aluno = NEW.id_aluno)) INTO idade_aluno;

    IF idade_aluno < NEW.serie THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O aluno não atende aos requisitos de idade para a série.';
    END IF;
END;
//
DELIMITER ;

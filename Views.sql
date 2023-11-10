CREATE DATABASE exercicio;

-- Crie uma view chamada "relatorio_pedidos_cliente"
CREATE VIEW relatorio_pedidos_cliente AS
SELECT
    c.nome AS NomeCliente,
    COUNT(p.id_pedido) AS NumeroPedidos,
    SUM(p.valor_total) AS ValorTotalGasto
FROM clientes c
LEFT JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente;


-- Crie uma view chamada "estoque_critico"
CREATE VIEW estoque_critico AS
SELECT
    p.nome AS NomeProduto,
    e.quantidade AS QuantidadeEstoque
FROM produtos p
JOIN estoque e ON p.id_produto = e.id_produto
WHERE e.quantidade < limite_estabelecido_pela_empresa; -- Substitua 'limite_estabelecido_pela_empresa' pelo valor desejado.


-- Crie uma view chamada "relatorio_vendas_funcionario"
CREATE VIEW relatorio_vendas_funcionario AS
SELECT
    f.nome AS NomeFuncionario,
    COUNT(v.id_venda) AS NumeroVendas,
    SUM(v.valor_venda) AS ValorTotalVendas
FROM funcionarios f
LEFT JOIN vendas v ON f.id_funcionario = v.id_funcionario
GROUP BY f.id_funcionario;


-- Crie uma view chamada "relatorio_produtos_categoria"
CREATE VIEW relatorio_produtos_categoria AS
SELECT
    c.nome_categoria AS NomeCategoria,
    COUNT(p.id_produto) AS QuantidadeProdutos
FROM categorias c
LEFT JOIN produtos p ON c.id_categoria = p.id_categoria
GROUP BY c.id_categoria;


-- Crie uma view chamada "relatorio_pagamentos_cidade"
CREATE VIEW relatorio_pagamentos_cidade AS
SELECT
    c.cidade AS NomeCidade,
    SUM(pa.valor_pagamento) AS ValorTotalPagamentos
FROM clientes c
LEFT JOIN pagamentos pa ON c.id_cliente = pa.id_cliente
GROUP BY c.cidade;



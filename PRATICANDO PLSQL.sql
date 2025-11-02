*1.3 - Estruturas de Controle (IF/ELSE)
📖 Teoria
Use IF para tomar decisões no código. */


--select * from TABELA_DE_VENDEDORES;
SET SERVEROUTPUT ON;
DECLARE
        V_NOME VARCHAR(100);
        V_DE_FERIAS NUMBER;
BEGIN

        SELECT NOME, DE_FERIAS
        INTO V_NOME, V_DE_FERIAS
        FROM TABELA_DE_VENDEDORES
        WHERE MATRICULA = '00236';
        
        IF V_DE_FERIAS = 1 THEN
            DBMS_OUTPUT.PUT_LINE(UPPER(V_NOME) || ' ESTÁ DE FÉRIAS');
        ELSE
            DBMS_OUTPUT.PUT_LINE(UPPER(V_NOME) || ' ESTÁ DISPONÍVEL');
        END IF;

END;



--______________________________________________________________________________

-- Exercício 2: Classificar produto por preço

    SET SERVEROUTPUT ON;
    DECLARE 
        -- Seção de declaração de variáveis (OPCIONAL)
        -- Aqui você declara variáveis, cursores, tipos, etc.-- Aqui você declara variáveis, cursores, tipos, etc.
        V_NOME NVARCHAR2(100);
        V_IDADE NUMBER;
    BEGIN
        
        -- Seção de execução (OBRIGATÓRIA)
        -- Aqui fica a lógica do programa-- Aqui fica a lógica do programa
        SELECT NOME, IDADE
        INTO  V_NOME, V_IDADE
        FROM TABELA_DE_CLIENTES
        WHERE ROWNUM = 1;
        
        
        DBMS_OUTPUT.PUT_LINE('CLIENTE : ' || V_NOME || ' - IDADE : ' || V_IDADE);
        EXCEPTION
        -- Seção de tratamento de erros (OPCIONAL) -- Seção de tratamento de erros (OPCIONAL)
        -- Aqui você trata exceções-- Aqui você trata exceções
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('NENHUM CLIENTE ENCONTRADO');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERRO: ' || SQLERRM);
    
    
    END;



--_______________________________________________________________________________


--1.3 - Tipos de Dados e Variáveis

-- Tipos Básicos

SET SERVEROUTPUT ON
DECLARE 

        --STRING
        V_NOME NVARCHAR2(100) := 'JOAO SILVA';
        V_CPF  VARCHAR2(11) :=  11467892517;
        
        -- NUMERICOS
        V_IDADE NUMBER := 25;
        V_SALARIO NUMBER (10,2) := 5500.50;
        V_TAXA FLOAT := 3.75;
        
        --DATA E HORA
        V_DATA_NASCIMENTO DATE := TO_DATE('15/03/1998', 'DD/MM/YYYY');
        V_DATA_HORA TIMESTAMP := SYSTIMESTAMP;
        
        
        --BOOLEANO (APENAS EM PLSQL, NAO EXITE EM SQL PURO)
        V_ATIVO BOOLEAN := TRUE;
        V_DESCONTO_APLICADO BOOLEAN := FALSE;
        
    
BEGIN
        
        DBMS_OUTPUT.PUT_LINE('NOME: ' || V_NOME);
        DBMS_OUTPUT.PUT_LINE('IDADE ' || V_IDADE);
        DBMS_OUTPUT.PUT_LINE('SALARIO: R$' || V_SALARIO);
        
        
        
        IF V_ATIVO THEN
            DBMS_OUTPUT.PUT_LINE('CLIENTE ATIVO');
        END IF;
END;


--______________________________________________________________________________

-- Tipo Âncora (%TYPE)
-- O %TYPE copia o tipo de dado de uma coluna da tabela, garantindo compatibilidade:

SET SERVEROUTPUT ON
DECLARE
        V_NOME TABELA_DE_CLIENTES.NOME%TYPE;
        V_LIMITE TABELA_DE_CLIENTES.LIMITE_DE_CREDITO%TYPE;
        V_CPF TABELA_DE_CLIENTES.CPF%TYPE;

BEGIN
        SELECT NOME, LIMITE_DE_CREDITO, CPF
        INTO V_NOME, V_LIMITE, V_CPF
        FROM TABELA_DE_CLIENTES
        --WHERE ROWNUM = 1;
        WHERE limite_de_credito = 120000;
        
    
        DBMS_OUTPUT.PUT_LINE('CLIENTE: ' || V_NOME);
        DBMS_OUTPUT.PUT_LINE('CPF: ' || V_CPF);
        DBMS_OUTPUT.PUT_LINE('LIMITE R$' || V_LIMITE);

END;



SELECT * FROM TABELA_DE_CLIENTES;



--______________________________________________________________________________


SET SERVEROUTPUT ON
DECLARE 

    --CONSTANTES NAO PODEM SER ALTERADAS
    C_TAXA_DESCONTO CONSTANT NUMBER := 0.10;
    C_IVA CONSTANT NUMBER := 0.18;
    C_EMPRESA CONSTANT VARCHAR2(50) := 'MINHA EMPRESA LTDA';
    
    
    V_PRECO NUMBER := 100;
    V_PRECO_FINAL NUMBER;
BEGIN

    --USANDO CONSTATES
    V_PRECO_FINAL := V_PRECO * (1 - C_TAXA_DESCONTO);
    
    
    
    DBMS_OUTPUT.PUT_LINE('PRECO ORIGINAL: R$ ' || V_PRECO);
    DBMS_OUTPUT.PUT_LINE('DESCONTO:' || (C_TAXA_DESCONTO * 100) || '%');
    DBMS_OUTPUT.PUT_LINE('PRECO FINAL: R$' || V_PRECO_FINAL);

END;



--______________________________________________________________________________


--1.4 - Estruturas de Controle
--IF-THEN-ELSE

SET SERVEROUTPUT ON
DECLARE
    V_IDADE NUMBER;
    V_SEXO NVARCHAR2(1);
    V_CATEGORIA VARCHAR2(30);
    V_NOME NVARCHAR2(100);

BEGIN
    SELECT IDADE, SEXO, NOME
    INTO V_IDADE, V_SEXO, V_NOME
    FROM TABELA_DE_CLIENTES;
    --WHERE ROWNUM = 2;
    
    
    -- IF SIMPLES
    IF V_IDADE < 18 THEN
       V_CATEGORIA := 'MENOR DE IDADE';
    END IF;
    
    
    --IF ELSE
    IF V_SEXO = 'M' THEN
       DBMS_OUTPUT.PUT_LINE('CLIENTE DO SEXO MASCULINO');
    ELSE
       DBMS_OUTPUT.PUT_LINE('CLIENTE DO SEXO FEMININO');
    END IF;
    
    -- IF-ELSIF-ELSE(MULTIPLAS CONDICOES)
    IF V_IDADE < 18 THEN
       V_CATEGORIA  := 'MENOR IDADE';
    ELSIF V_IDADE >= 18 AND V_IDADE < 25 THEN
       V_CATEGORIA := 'JOVEM ADULTO';
    ELSIF V_IDADE >= 25 AND V_IDADE < 60 THEN
        V_CATEGORIA := 'ADULTO';
    ELSE
        V_CATEGORIA := 'IDOSO';
    END IF;
    
    
    DBMS_OUTPUT.PUT_LINE('IDADE: ' || V_IDADE);
    DBMS_OUTPUT.PUT_LINE('CATEGORIA: ' || V_CATEGORIA);
    DBMS_OUTPUT.PUT_LINE('NOME DO CLIENTE: ' || V_NOME);
END;
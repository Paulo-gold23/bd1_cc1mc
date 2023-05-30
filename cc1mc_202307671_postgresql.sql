--Banco de Dados, PSET 1

--Paulo Guilherme Goldner Ribeiro
--202307671
-- cc1mC
--pggrbr2@gmail.com
--Professor Abrantes Araújo Silva Filho




-- Apagando o banco de dados (se existir)

DROP DATABASE IF EXISTS uvv;

-- Apagando o usuario (se existir)
DROP SCHEMA IF EXISTS lojas;
DROP USER IF EXISTS paulo_gold;


-- Criação de usuario

CREATE USER paulo_gold WITH
        createdb 
        encrypted password 'jotinha'
        ;


-- Criação passo a passo do banco de dados uvv

CREATE DATABASE uvv
    OWNER=      paulo_gold
    ENCODING=   'UTF8'
    TEMPLATE=   template0
    LC_COLLATE= 'pt_BR.UTF-8'
    LC_CTYPE=   'pt_BR.UTF-8'
    allow_connections= TRUE;

-- Criação do esquema lojas

CREATE SCHEMA lojas AUTHORIZATION paulo_gold;

-- Confirgurando o esquema lojas como esquema padrão
SET SEARCH_PATH TO lojas, "$user", public;


-- Conexão com o banco de dados uvv

\c "host=localhost dbname=uvv user=paulo_gold password='jotinha'"

-- processo de criação das tabelas

-- Criando a tabela produtos

CREATE TABLE produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT pk_produto PRIMARY KEY (produto_id)
);
--Comentários sobre a tabela produtos

COMMENT ON TABLE  produtos                            IS  'A tabela que na qual armazenaremos informações sobre os produtos';
COMMENT ON COLUMN produtos.produto_id                 IS  'A PK da tabela contendo a identidificação dos produtos';      
COMMENT ON COLUMN produtos.nome                       IS  'Coluna contendo o nome de cada produto, nao pode ser nula';
COMMENT ON COLUMN produtos.preco_unitario             IS  'Coluna contendo o preço de cada unidade do produto';
COMMENT ON COLUMN produtos.detalhes                   IS  'Coluna contendo os detalhes dos produtos';
COMMENT ON COLUMN produtos.imagem                     IS  'Coluna que armazena as imagens dos produtos';
COMMENT ON COLUMN produtos.imagem_mime_type           IS  'Coluna que irá armazenar o mime type das imagens'; 
COMMENT ON COLUMN produtos.imagem_arquivo             IS  'coluna que armazena o arquivo das imagens'; 
COMMENT ON COLUMN produtos.imagem_charset             IS  'coluna que receberá o charset do arquivo das imagens do produto'; 
COMMENT ON COLUMN produtos.imagem_ultima_atualizacao  IS  'coluna que armazenará a data da ultima atulização das imagens dos produtos';

--Criando a tabela produtos

CREATE TABLE lojas (
                loja_id NUMERIC NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT pk_lojas PRIMARY KEY (loja_id)
);
 
--Comentários sobre a tabela lojas:

COMMENT ON TABLE  lojas                               IS 'Esta tabela que na qual armazenaremos informações sobre as lojas registradas.'; 
COMMENT ON COLUMN lojas.loja_id                       IS 'Esta PK desta tabela, contendo a identificação das lojas.';
COMMENT ON COLUMN lojas.nome                          IS 'Esta coluna que irá conter os nomes da loja, não pode ser nula.';
COMMENT ON COLUMN lojas.endereco_web                  IS 'Esta coluna que irá conter o endereço da web das lojas.';
COMMENT ON COLUMN lojas.endereco_fisico               IS 'Esta coluna que irá conter o endereço físico das lojas.';
COMMENT ON COLUMN lojas.latitude                      IS 'Esta coluna que irá conter a latitute das lojas.';
COMMENT ON COLUMN lojas.longitude                     IS 'Esta coluna que irá conter a longitude das lojas.';
COMMENT ON COLUMN lojas.logo                          IS 'Esta coluna que ira conter o logotipo das lojas.';
COMMENT ON COLUMN lojas.logo_mime_type                IS 'Cria  a coluna contendo o mime type dos logotipos.';
COMMENT ON COLUMN lojas.logo_arquivo                  IS 'Cria a coluna que armazenará o arquivo das logos.';
COMMENT ON COLUMN lojas.logo_charset                  IS 'Cria a coluna que armazenará o charset dos logos.';
COMMENT ON COLUMN lojas.logo_ultima_atualizacao       IS 'Cria a coluna que armazenará a data da ultima atualização referente aos logos das lojas,';


--Criando a tabela estoques

CREATE TABLE estoques (
                estoque_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                loja_id NUMERIC NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                CONSTRAINT pk_estoques PRIMARY KEY (estoque_id)
); 

--Comentários sobre a tabela estoques

COMMENT ON TABLE  estoques                          IS 'Criando a tabela que que armanezanrá informaçoes sobre os estoques.';  
COMMENT ON COLUMN estoques.estoque_id               IS 'Criando a coluna "estoque_id" que será a PK desta tabela.';
COMMENT ON COLUMN estoques.quantidade               IS 'Cria a coluna que ira listar a quantidade de determinado produto, esta coluna não pode ter valor nulo.';
COMMENT ON COLUMN estoques.loja_id                  IS 'Cria nesta tabela a coluna "lojas_id" que é a PK da tabela lojas.'; 
COMMENT ON COLUMN estoques.produto_id               IS 'Cria nesta tabela a coluna "produto_id" que é a PK da tabela produtos,';


-- Criando a tabela a tabela clientes 


CREATE TABLE clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT pk_clientes PRIMARY KEY (cliente_id)
);


--Comentários sobre a tabela clientes

COMMENT ON TABLE  clientes                          IS 'Cria a tabela clientes onde irá conter informações pessoais sobre os clientes.';
COMMENT ON COLUMN clientes.cliente_id              IS 'Cria a coluna que será a PK da tabela clientes contendo a identificação dos clientes.';
COMMENT ON COLUMN clientes.email                   IS 'Cria a coluna que armazenará o email dos clientes, esta coluna não pode ser nula.';
COMMENT ON COLUMN clientes.nome                    IS 'Cria a coluna que irá conter o nome dos clientes, esta coluna não pode ter valor nulo.';
COMMENT ON COLUMN clientes.telefone1               IS 'Cria a coluna que ira conter a opção 1 dos telefones.';
COMMENT ON COLUMN clientes.telefone2               IS 'Cria a coluna que ira conter a opção 2 dos telefones.';
COMMENT ON COLUMN clientes.telefone3               IS 'Cria a coluna que ira conter a opção 3 dos telefones.';  

-- Criando a tabela pedidos


CREATE TABLE pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                status VARCHAR(15) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC NOT NULL,
                CONSTRAINT pk_pedidos PRIMARY KEY (pedido_id)
); 


--Comentarios sobre a criação da tabela pedidos

COMMENT ON TABLE  pedidos                     IS 'Cria a tabela pedidos que irá conter informações relacionadas aos pedidos.'; 
COMMENT ON COLUMN pedidos.pedido_id           IS 'Cria a coluna que irá conter a identificação dos pedidos e será a PK desta tabela.';
COMMENT ON COLUMN pedidos.data_hora           IS 'Cria a coluna que irá conter a data e a hora que foi realizado o pedido.';
COMMENT ON COLUMN pedidos.status              IS 'Cria a coluna que irá conter o status do pedido.';
COMMENT ON COLUMN pedidos.cliente_id          IS 'Cria a coluna que irá conter a identificação do cliente, é a PK da tabela clientes.';
COMMENT ON COLUMN pedidos.loja_id             IS 'Cria a coluna que irá conter a identificação da loja que foi realizado o pedido e é a PK da tabela lojas.';

-- Criando a tabela envios

CREATE TABLE envios (
                envio_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC NOT NULL,
                CONSTRAINT pk_envios PRIMARY KEY (envio_id)
);
--Comentários sobre a criação da tabela envios 

COMMENT ON TABLE  envios                              IS 'Cria a tabela envios que irá conter infromações sobre os pedidos a serem enviados.';
COMMENT ON COLUMN envios.envio_id                     IS 'Cria a coluna que irá identificação dos pedidos enviados e será a PK desta tabela.';
COMMENT ON COLUMN envios.cliente_id                   IS 'Cria a coluna que irá conter a identificação dos clientes, é a PK da tabela clientes e não pode ter valor nulo.';
COMMENT ON COLUMN envios.endereco_entrega             IS 'Cria a coluna que irá conter o endereço de entrega do pedido realizado e não pode ter valor nulo.';
COMMENT ON COLUMN envios.status                       IS 'Cria a coluna que irá conter o status do envio.';
COMMENT ON COLUMN envios.loja_id                      IS 'Cria a coluna contendo a identificação da loja que realizou o pedido, é a PK da tabela lojas.';


--Criando a tabela pedidos_itens


CREATE TABLE pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha VARCHAR(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38) NOT NULL,
                CONSTRAINT pk_pedidos_itens PRIMARY KEY (pedido_id, produto_id)
);

--Comentrários sobre a criação da tabela pedidos_itens

COMMENT ON TABLE  pedidos_itens                       IS 'Cria a tabela com a PFK "pedidos_itens" e "produtto_id. Esta tabela possui um relacionamento identificado com a tabela "pedidos" e "produtos.';
COMMENT ON COLUMN pedidos_itens.pedido_id             IS 'Cria a coluna que faz a identificação dos pedidos. É a PK da tabela pedidos.';
COMMENT ON COLUMN pedidos_itens.produto_id            IS 'Cria a coluna que faz a identificação do produto. É a PK da tabela produtos.';
COMMENT ON COLUMN pedidos_itens.numero_da_linha       IS 'Cria a coluna que identidica o numero da linha do pedido.';
COMMENT ON COLUMN pedidos_itens.preco_unitario        IS 'Cria a columa que contém o preço unitario de cada produto.';
COMMENT ON COLUMN pedidos_itens.quantidade            IS 'Cria a coluna que contém a quantidade de cada pedido realizado.';
COMMENT ON COLUMN pedidos_itens.envio_id              IS 'Cria a coluna que irá conter a identificação dos pedidos. É a PK desta tabela.';


-- Criando a FK na tabela estoques

ALTER TABLE estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE; 

-- Criando um relacionamento com a FK produto_id na tabela pedidos_itens

ALTER TABLE pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Criando um relacionamento com a FK loja_id com a tabela envios

ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Criando um relacionamento com a FK loja_id com a tabela pedidos

ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Criando um relaciomento com a FK loja_id com a tabela estoques

ALTER TABLE estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Criando um relacionamento com a FK cliente_id com a tabela envios

ALTER TABLE envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Criando um relacionamento com a FK cliente_id com a tabela pedidos  


ALTER TABLE pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Criando um relacionamento com a FK pedido_id com a tabela pedidos_itens

ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Criando um relacionamento com a FK envio_id com a tabela pedidos_itens

ALTER TABLE pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;  

--Adicionando uma restrição nas colunas endereco_web e endereco_fisico da tabela lojas, que na qual permitirá a checagem de um endereço ou do outro

ALTER TABLE lojas
ADD CONSTRAINT check_endereco_preenchido
CHECK (endereco_web IS NOT NULL OR endereco_fisico IS NOT NULL);

--Adicionando uma a restrição na coluna preço unitário da tabela produtos para nao aceitar números negativos

ALTER TABLE produtos
ADD CONSTRAINT check_preco_unitario_positivo
CHECK (preco_unitario >= 0);  

--Adicionando uma a restrição na coluna quantidade da tabela estoques para nao aceitar números negativos

ALTER TABLE estoques
ADD CONSTRAINT check_quantidade_positivo
CHECK (quantidade >= 0); 

-- Adicionando uma restrição na coluna status da tabela pedidos para apenas estas opções descritas

ALTER TABLE pedidos  
ADD CONSTRAINT check_status
CHECK (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));
 
--Adicionando uma restrição ma coluna status da tabela envios para inserie apenas estas opções descritas

ALTER TABLE envios
ADD CONSTRAINT check_status
CHECK (status IN ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE')); 

-- Adicionando uma restrição na coluna preço_unitário da tabela pedidos itens para nao aceitar números n

ALTER TABLE pedidos_itens
ADD CONSTRAINT check_preco_unitario_positivo
CHECK (preco_unitario >= 0);  

--Adicionando uma restrição na coluna quantidade da tabela pedidos_itens para não aceitar numeros nega

ALTER TABLE pedidos_itens
ADD CONSTRAINT check_quantidade_positivo
CHECK (quantidade >= 0); 


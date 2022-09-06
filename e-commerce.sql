-- MySQL Script generated by MySQL Workbench
-- Mon Sep  5 22:45:30 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`fornecedor` (
  `idFornecedor` INT NOT NULL,
  `RazaoSocial` VARCHAR(45) NULL,
  `CNPJ` VARCHAR(45) NULL,
  PRIMARY KEY (`idFornecedor`),
  UNIQUE INDEX `CNPJ_UNIQUE` (`CNPJ` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`produto` (
  `idProduto` INT NOT NULL,
  `Categoria` VARCHAR(45) NOT NULL,
  `Descricao` VARCHAR(45) NOT NULL,
  `Valor` VARCHAR(45) NOT NULL,
  `Fornecedor_idFornecedor` INT NOT NULL,
  PRIMARY KEY (`idProduto`, `Fornecedor_idFornecedor`),
  INDEX `fk_Produto_Fornecedor1_idx` (`Fornecedor_idFornecedor` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_Fornecedor1`
    FOREIGN KEY (`Fornecedor_idFornecedor`)
    REFERENCES `mydb`.`fornecedor` (`idFornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tipo_pessoa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipo_pessoa` (
  `id_tpessoa` INT NOT NULL,
  `pessoa` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_tpessoa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cliente` (
  `idCliente` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `Identificacao` VARCHAR(45) NULL,
  `Endereco` VARCHAR(45) NULL,
  `TipoPessoa_idTipoPessoa` INT NOT NULL,
  PRIMARY KEY (`idCliente`, `TipoPessoa_idTipoPessoa`),
  INDEX `fk_Cliente_TipoPessoa1_idx` (`TipoPessoa_idTipoPessoa` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_TipoPessoa1`
    FOREIGN KEY (`TipoPessoa_idTipoPessoa`)
    REFERENCES `mydb`.`tipo_pessoa` (`id_tpessoa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`estoque` (
  `idEstoque` INT NOT NULL,
  `Local` VARCHAR(45) NULL,
  PRIMARY KEY (`idEstoque`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`entrega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`entrega` (
  `idEntrega` INT NOT NULL,
  `Responsavel` VARCHAR(45) NOT NULL,
  `Status` VARCHAR(45) NOT NULL,
  `Rastreio` VARCHAR(45) NULL,
  PRIMARY KEY (`idEntrega`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pedido` (
  `idPedido` INT NOT NULL,
  `StatusPedido` VARCHAR(45) NOT NULL,
  `Descricao` VARCHAR(45) NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Frete` FLOAT NOT NULL,
  `Entrega_idEntrega` INT NOT NULL,
  PRIMARY KEY (`idPedido`, `Cliente_idCliente`, `Entrega_idEntrega`),
  INDEX `fk_Pedido_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  INDEX `fk_Pedido_Entrega1_idx` (`Entrega_idEntrega` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_Entrega1`
    FOREIGN KEY (`Entrega_idEntrega`)
    REFERENCES `mydb`.`entrega` (`idEntrega`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`existe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`existe` (
  `Produto_idProduto` INT NOT NULL,
  `Estoque_idEstoque` INT NOT NULL,
  `Quantidade` INT NOT NULL,
  PRIMARY KEY (`Produto_idProduto`, `Estoque_idEstoque`),
  INDEX `fk_Produto_has_Estoque_Estoque1_idx` (`Estoque_idEstoque` ASC) VISIBLE,
  INDEX `fk_Produto_has_Estoque_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Estoque_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `mydb`.`produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Estoque_Estoque1`
    FOREIGN KEY (`Estoque_idEstoque`)
    REFERENCES `mydb`.`estoque` (`idEstoque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`contem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`contem` (
  `Pedido_idPedido` INT NOT NULL,
  `Pedido_Cliente_idCliente` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  `Quantidade` INT NOT NULL,
  PRIMARY KEY (`Pedido_idPedido`, `Pedido_Cliente_idCliente`, `Produto_idProduto`),
  INDEX `fk_Pedido_has_Produto_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  INDEX `fk_Pedido_has_Produto_Pedido1_idx` (`Pedido_idPedido` ASC, `Pedido_Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_has_Produto_Pedido1`
    FOREIGN KEY (`Pedido_idPedido` , `Pedido_Cliente_idCliente`)
    REFERENCES `mydb`.`pedido` (`idPedido` , `Cliente_idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_has_Produto_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `mydb`.`produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`vendedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`vendedor` (
  `idVendedor` INT NOT NULL,
  `RazaoSocial` VARCHAR(45) NOT NULL,
  `Local` VARCHAR(45) NOT NULL,
  `TipoVendedor` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idVendedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`vende`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`vende` (
  `Vendedor_idVendedor` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  `Quantidade` INT NOT NULL,
  PRIMARY KEY (`Vendedor_idVendedor`, `Produto_idProduto`),
  INDEX `fk_TerceiroVendedor_has_Produto_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  INDEX `fk_TerceiroVendedor_has_Produto_TerceiroVendedor1_idx` (`Vendedor_idVendedor` ASC) VISIBLE,
  CONSTRAINT `fk_TerceiroVendedor_has_Produto_TerceiroVendedor1`
    FOREIGN KEY (`Vendedor_idVendedor`)
    REFERENCES `mydb`.`vendedor` (`idVendedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TerceiroVendedor_has_Produto_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `mydb`.`produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`form_pagto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`form_pagto` (
  `idFormaPagamento` INT NOT NULL,
  `FormaPagamento` VARCHAR(45) NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  `Pedido_Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idFormaPagamento`, `Pedido_idPedido`, `Pedido_Cliente_idCliente`),
  INDEX `fk_FormaPagamento_Pedido1_idx` (`Pedido_idPedido` ASC, `Pedido_Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_FormaPagamento_Pedido1`
    FOREIGN KEY (`Pedido_idPedido` , `Pedido_Cliente_idCliente`)
    REFERENCES `mydb`.`pedido` (`idPedido` , `Cliente_idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

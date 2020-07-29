# Estendendo a classe MsNewGetdados

###### Class LbGetDados  -  Heran�a no Advpl. 

A heran�a � um princ�pio da POO que permite a cria��o de novas classes a partir de outras previamente criadas, neste exemplo abordarei um modelo de classe derivada <b>LbGetDados</b> que herda as caracter�sticas da <b>MsNewGetDados</b>.

![LbGetDados.gif](./resource/LbGetDados.gif)

 Novos m�todos foram implementados na classe derivada "Filha":

###### M�todos:

- [x] :New Permite omitir o container, adicionando uma dialog padr�o com EnchoiceBar.
- [x] :SetSizePerc Permite definir tamanho da dialog passando tamanho size em %.
- [x] :SetStyle Aplica um estilo pr�-definido, possui 6 op��es.
- [x] :SetLineColor Permite informar um valor RGB para ser atribuido � Getdados.


# Como utilizar?

```
1. Compilar o fonte do LbGetDados.prw do diret�rio /src. 
2. Executar a rotina de exemplo "U_Example()" dentro do ambiente. ERP
```


## Tecnologias

Projeto desenvolvido em:

- [Advpl](https://tdn.totvs.com/display/tec/AdvPL)


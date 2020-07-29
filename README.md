# Estendendo a classe MsNewGetdados

###### Class LbGetDados  -  Heran�a no Advpl. 

A heran�a � um princ�pio da POO que permite a cria��o de novas classes a partir de outras previamente criadas, neste exemplo abordarei um modelo de classe derivada <b>LbGetDados</b> que herda as caracter�sticas da <b>MsNewGetDados</b> permitindo a implementa��o de novas funcionalidades.

![LbGetDados.gif](./resource/LbGetDados.gif)

M�todos da classe derivada "Filha".

###### M�todos:

:heavy_check_mark: <b>LbGetDados():New() </b>  M�todo construtor da classe filha, segue com os mesmos par�metros da classe pai com a diferen�a de poder ignorar a passagem do par�metro "oWnd",  deixando que a classe se responsabilize pela cria��o da janela - Onwer "Dialog".

:heavy_check_mark: <b>LbGetDados():SetSizePerc()</b> Ajusta tamanho da janela recebendo valor em %.


:heavy_check_mark: <b>LbGetDados():SetStyle()</b> Aplica um estilo pr�-definido (6 op��es).


:heavy_check_mark: <b>LbGetDados():SetLineColor()</b> Permite informar um valor RGB para ser atribuido � Getdados.

:heavy_check_mark: <b>LbGetDados():SetbOk()</b> Define bloco de c�digo para bot�o Ok da EnchoiceBar.

:heavy_check_mark: <b>LbGetDados():SetbCancel()</b> Define bloco de codigo para bot�o Cancelar da EnchoiceBar.

:heavy_check_mark: <b>LbGetDados():SetButtons()</b> Insere bot�es adicionais na EnchoiceBar

:heavy_check_mark: <b>LbGetDados():ActiveDialog()</b> Ativa a janela da getdados caso tenha optado pela janela padr�o.





# Como utilizar?

```
1. Compilar o fonte do LbGetDados.prw do diret�rio /src. 
2. Executar a rotina de exemplo "U_Example()" dentro do ambiente. ERP
```


:warning:  
``` 
ATEN��O: A classe pai MsNewGetDados est� depreciada, e por conta disso, n�o recebe mais atualiza��es por�m o intuito deste exemplo � did�tico.
A Totvs recomenda a utiliza��o do MVC Protheus.

```


## Tecnologias

Projeto desenvolvido em:

- [Advpl](https://tdn.totvs.com/display/tec/AdvPL)


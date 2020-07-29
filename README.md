# Estendendo a classe MsNewGetdados

###### Class LbGetDados  -  Herança no Advpl. 

A herança é um princípio da POO que permite a criação de novas classes a partir de outras previamente criadas, neste exemplo abordarei um modelo de classe derivada <b>LbGetDados</b> que herda as características da <b>MsNewGetDados</b> permitindo a implementação de novas funcionalidades.

![LbGetDados.gif](./resource/LbGetDados.gif)

Métodos da classe derivada "Filha".

###### Métodos:

:heavy_check_mark: <b>LbGetDados():New() </b>  Método construtor da classe filha, segue com os mesmos parâmetros da classe pai com a diferença de poder ignorar a passagem do parãmetro "oWnd",  deixando que a classe se responsabilize pela criação da janela - Onwer "Dialog".

:heavy_check_mark: <b>LbGetDados():SetSizePerc()</b> Ajusta tamanho da janela recebendo valor em %.


:heavy_check_mark: <b>LbGetDados():SetStyle()</b> Aplica um estilo pré-definido (6 opções).


:heavy_check_mark: <b>LbGetDados():SetLineColor()</b> Permite informar um valor RGB para ser atribuido à Getdados.

:heavy_check_mark: <b>LbGetDados():SetbOk()</b> Define bloco de código para botão Ok da EnchoiceBar.

:heavy_check_mark: <b>LbGetDados():SetbCancel()</b> Define bloco de codigo para botão Cancelar da EnchoiceBar.

:heavy_check_mark: <b>LbGetDados():SetButtons()</b> Insere botões adicionais na EnchoiceBar

:heavy_check_mark: <b>LbGetDados():ActiveDialog()</b> Ativa a janela da getdados caso tenha optado pela janela padrão.





# Como utilizar?

```
1. Compilar o fonte do LbGetDados.prw do diretório /src. 
2. Executar a rotina de exemplo "U_Example()" dentro do ambiente. ERP
```


:warning:  
``` 
ATENÇÃO: A classe pai MsNewGetDados está depreciada, e por conta disso, não recebe mais atualizações porém o intuito deste exemplo é didático.
A Totvs recomenda a utilização do MVC Protheus.

```


## Tecnologias

Projeto desenvolvido em:

- [Advpl](https://tdn.totvs.com/display/tec/AdvPL)


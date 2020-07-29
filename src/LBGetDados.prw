#Include 'Protheus.ch'
#Include 'ParmType.ch'
#Include 'FwMVCDef.ch'
#Include 'tbiconn.ch'

Static nSel01		
Static nSel02


User Function LBGetDados() ; Return("Nome de Funcao reservada para classe LBGetDados")

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} LBGetDados 
@type			: Classe
@Sample			: LBGetDados():New(...) - Os mesmos parametros da MsNewGetDados
@description	: Exemplo de herança.

				  LBGetDados possui as mesmas funcionalidades da classe pai MsNewgetDados com adição 
				  das seguintes funcionalidades:
					1. Cria janela Dialog default caso não seja informada. Com ou sem Enchoicebar.
					2. Permite definir o tamanho da Dialog passando size em %.
					3. Permite a escolha entre 6 modelos de estilos (Cores).
					4. Permite informar um valor RGB para definição das cores, linhas.
@Param			: Os mesmos parametros da MsNewGetDados.
@return			: Objeto
@ --------------|----------------
@author			: Lucas.Brustolin
@since			: 28/07/2020
@version		: P12
/*/
//------------------------------------------------------------------------------------------
Class LBGetDados From MsNewgetDados

Data cClassName		As String 
Data lDlgDefault 	As Boolean

//-- Botoes da Enchoice
Data bOk 			As BLOCK
Data bCancel 		As BLOCK
Data aButtons 		As Array 
Data lButtonPress	As Boolean

Data nColorSel	 	As Integer 
Data nColorLin		As Integer  


//-- Grid GetDados
Method New(nTop,nLeft,nBottom,nRight,nStyle,cLinhaOk,cTudoOk,cIniCpos,aAlter,nFreeze,nMax,cFieldOk,cSuperDel,cDelOk,oWnd,aPartHeader,aParCols,uChange,cTela) Constructor

Method SetStyle(nOpc)						// Seta um determinado estilo Color Linha/Linha selecionada 
Method SetLineColor(nCor1,nCor2)			// Define COR RGB para linha/Linha selecionada
	
//-- EnchoiceBar - Botoes 
Method SetbOk( bOk )						// Define bloco de codigo para botão Ok EnchoiceBar
Method SetbCancel( bCancel )				// Define bloco de codigo para botão Cancelar EnchoiceBar
Method SetButtons( aButtons )				// Informa array de botoes adicionais ao EnchoiceBar

//--  MsDialog
Method SetSizePerc(nSizePerc)				// Aplica tamanho da janela passando um valor em %
Method ActiveDialog(bAction,lEnchoiceBar)	// Ativa janela 

End Class

// -------------------------------------------------------+
// METODO CONSTRUTOR - INICIALIZA AS PROPRIEDADES         |
// -------------------------------------------------------+
Method New(nTop,nLeft,nBottom,nRight,nStyle,cLinhaOk,cTudoOk,cIniCpos,aAlter,nFreeze,nMax,cFieldOk,cSuperDel,cDelOk,oWnd,aPartHeader,aParCols,uChange,cTela) Class LBGetDados

Local lCreate	:= .F.


ParamType 0	 Var  	nTop		As Numeric 		Optional	Default 0
ParamType 1	 Var  	nLeft		As Numeric 		Optional	Default 0
ParamType 2	 Var  	nBottom 	As Numeric 		Optional	Default 0
ParamType 3	 Var	nRight 		As Numeric 		Optional	Default 0
ParamType 4	 Var	nStyle 		As Numeric		Optional	Default (GD_INSERT+GD_UPDATE+GD_DELETE)
ParamType 5  Var	cLinhaOk	As Character 	Optional	Default "AllwaysTrue"	
ParamType 6  Var	cTudoOk		As Character	Optional	Default "Allwaystrue"
ParamType 7  Var	cIniCpos	As Character	Optional	Default "Allwaystrue"
ParamType 8  Var	aAlter		As Array		Optional	Default {}
ParamType 9	 Var	nFreeze		As Numeric 		Optional	Default 0
ParamType 10 Var	nMax		As Numeric 		Optional	Default 999999
ParamType 11 Var	cFieldOk	As Character	Optional	Default "Allwaystrue"
ParamType 12 Var	cSuperDel	As Character	Optional	Default "Allwaystrue"	
ParamType 13 Var	cDelOk		As Character	Optional	Default "Allwaystrue"
ParamType 14 Var  	oWnd		As Object		Optional 	Default CreateDlg(@lCreate)
ParamType 15 Var	aPartHeader	As Array 		Optional	Default {}
ParamType 16 Var	aParCols	As Array		Optional	Default {}
ParamType 17 Var	uChange		As BLOCK		Optional	Default {||}
ParamType 18 Var	cTela		As Character	Optional	

	//-- NECESSARIO EXECUTAR O CONSTRUTOR DA CLASSE PAI 
	//-- CONFORME SINTAX ABAIXO
	_Super:New(	nTop		,;
				nLeft		,;
				nBottom		,;
				nRight		,;
				nStyle		,;
				cLinhaOk	,;
				cTudoOk		,;
				cIniCpos	,;
				aAlter		,;
				nFreeze		,;
				nMax		,;
				cFieldOk	,;
				cSuperDel	,;
				cDelOk		,;
				oWnd		,;
				aPartHeader	,;
				aParCols	,;
				uChange		,;
				cTela		)
		 
	Self:cClassName		:= "LbGETDADOS"
	Self:lDlgDefault	:= lCreate

	//-- Define as cores default do linha
	Self:nColorSel := Rgb(102,205,170)
	Self:nColorLin := Rgb(202,225,255)
	
	Self:oBrowse:bChange:= {|| nSel01 := Self:oBrowse:nAt, Self:oBrowse:Refresh() } 
	Self:oBrowse:SetBlkBackColor({|| GETDCLR(Self) })
	
	// Se as coordenadas forem omitidas aplica tela cheia
	If ( nTop + nLeft + nBottom + nRight ) == 0 
		Self:oBrowse:Align := CONTROL_ALIGN_ALLCLIENT
	EndIf 

	//-- Caso tenha sido criado a Dialog default
	If ( Self:lDlgDefault )	
		Self:bOk		:= { | | Self:oWnd:End() }
		Self:bCancel 	:= { | | Self:oWnd:End() }
		Self:aButtons 	:= { }
		Self:oBrowse:Align 	:= CONTROL_ALIGN_ALLCLIENT 
		Self:oBrowse:Refresh()
	EndIf

Return(Self)

// ---------------------------------------------------+
// SETA BLOCO DE CODIGO PARA O BOTAO OK               |
// ---------------------------------------------------+
Method SetbOk( bOk ) Class LBGetDados
Return( ::bOk := bOk  )

// ---------------------------------------------------+
// SETA BLOCO DE CODIGO PARA BOTAO CANCELAR           |
// ---------------------------------------------------+
Method SetbCancel( bCancel ) Class LBGetDados
Return( ::bCancel := bCancel  )

// ---------------------------------------------------+
// SETA BOTOES ADICIONAIS DA ENCHOICEBAR              |
// ---------------------------------------------------+
Method SetButtons( aButtons ) Class LBGetDados
Return( ::aButtons := aButtons  )

// ---------------------------------------------------+
// SETA TAMANHO DA DIALOG PASSANDO VALOR EM %         |
// ---------------------------------------------------+
Method SetSizePerc( nSizePerc ) Class LBGetDados

Local aSize 	:= {}
Local nI 		:= 0

PARAMTYPE  0 VAR nSizePerc 	AS NUMERIC 	 DEFAULT 100

aSize := FWGetDialogSize(IIf( ::oWnd == Nil,oMainWnd,::oWnd))

If nSizePerc > 0

	For nI := 1 to 4
		aSize[nI] := (aSize[nI]	*  (nSizePerc / 100))
	Next nX

	::oWnd:nTop		:= aSize[1]
	::oWnd:nLeft 	:= aSize[2]
	::oWnd:nHeight 	:= aSize[3]
	::oWnd:nWidth   := aSize[4]


Endif

Return(aSize)

// ----------------------------------------------------+
// DEFINE COR RGB PARA A(S) LINHA(S) E LINHA SELECIONADA|
// -----------------------------------------------------+
Method SetLineColor(nCor1,nCor2) Class LBGetDados


ParamType 0	Var	nCor1	As Numeric 		Optional
ParamType 1	Var nCor2	As Numeric 		Optional

Do Case
	Case !Empty(nCor1) .And. !Empty(nCor2)
		::nColorLin :=  nCor1
		::nColorSel :=  nCor2
	Case  !Empty(nCor1) .And. Empty(nCor2)
		::nColorLin :=  nCor1
	Case  Empty(nCor1) .And. !Empty(nCor2)
		::nColorSel :=  nCor2	
EndCase 

::oBrowse:SetBlkBackColor({|| GETDCLR(Self) })
::oBrowse:Refresh()
::Refresh()

Return()

// ---------------------------------------------------+
// APLICA UM ESTILO DE COR A  GETDADOS                |
// ---------------------------------------------------+
Method SetStyle(nOpc) Class LBGetDados

Do Case

	Case nOpc == 1
	
		::nColorLin	:= CLR_WHITE
		::nColorSel	:= CLR_YELLOW	
	
	Case nOpc == 2

		::nColorLin	:= Rgb(128,128,128)	
		::nColorSel := Rgb(255,127,80)

	Case nOpc == 3
	
		::nColorLin	:= Rgb(102,205,170)	
		::nColorSel := Rgb(0,139,139)

	Case nOpc == 4

		::nColorLin	:= CLR_WHITE
		::nColorSel := Rgb(47,79,79)

	Case nOpc == 5
		
		::nColorLin := Rgb(202,225,255)
		::nColorSel := Rgb(102,205,170)

	Case nOpc == 6
		
		::nColorLin	:= Rgb(211,211,211)		
		::nColorSel := Rgb(72,209,204)

EndCase 

Return({ ::nColorLin, ::nColorSel  })

// ---------------------------------------------------+
// ATIVA EXIBIÇÃO DA JANELA                           |
// ---------------------------------------------------+
Method ActiveDialog(bAction, lEnchoiceBar) Class LBGetDados

Local lRet := .F.

ParamType 0 Var	bAction			As BLOCK 	Optional	Default {||.T.} 
ParamType 1 Var	lEnchoiceBar	As LOGICAL 	Optional	Default .T. 

// -------------------------------------------------------------------+
// ATIVA MSDIALOG QUANDO FOR INFORMADO  AHEADER E ACOLS P/ LBGetDados |
// -------------------------------------------------------------------+
If ::oWnd:ClassName() == "MSDIALOG" //.And. ::lOwner
	If Len(::aHeader) > 0 .And.  Len(::aCols) >= 1 
		If ( lRet := Eval( bAction ) )

			If ( lEnchoiceBar )  

				::oWnd:bInit := {|| EnchoiceBar(	::oWnd									, ; // Dialog onde irá criar a barra de botões.
													{|| Eval(Self:bOk		, Self:oWnd) }	, ; // Bloco de código a ser executado no botão Ok.
													{|| Eval(Self:bCancel	, Self:oWnd) }	, ; // Bloco de código a ser executado no botão Cancelar
													.F. /*lMsgDel*/	, ; // Exibe dialog para confirmar a exclusão.
													::aButtons		, ; // Array contendo botões adicionais.
													/*nRecno*/		, ; // Registro a ser posicionado após a execução do botão Ok.
													/*cAlias*/		, ; // Alias do registro a ser posicionado após a execução do botão Ok. Se o parâmetro nRecno for informado, o cAlias passa ser obrigatório.
													.F. /*lMashups*/, ; // Indica se o botão "Mashups" deve ser exibido.
													.F./*lImpCad*/	, ; // Indica se o botão "Imprime Cadastro" deve ser exibido.
													.T./*lPadrao*/	, ; // Indica se os botões padrões devem ser exibidos.
													.T./*lHasOk*/	, ; // Indica se o botão "OK" deve ser exibido.
													.F./*lWalkThru*/, ; // Indica se o botão "Walkthru" deve ser exibido.
													/*cProfileID*/	) } // ID para ser considerado na gravação de configuração no profile.


				::oWnd:lCentered := .T. 
				::oWnd:Activate()
			Else 
				::oWnd:Activate()
			EndIf 
		EndIf
	Else 
		UserException("aHeader \ Acols not found")
	EndIf
EndIf

Return(lRet)

// -------------------------------------------------------+
// CRIA JANELA CASO O OWNER CONTAINER NAO SEJA INFORMADO  |
// -------------------------------------------------------+
Static Function CreateDlg(lCreate)

Local aSize			:= FwGetDialogSize()
Local cTitulo  		:= 'LBGetDados' 
Local bCancel   	:= {|Self| Self:oWnd:End() }

//-- Cria Janela Dialog 
oDlg 					:= MSDialog():New()
oDlg:nTop 	   			:= aSize[1]
oDlg:nLeft 				:= aSize[2]
oDlg:nHeight 			:= aSize[3]
oDlg:nWidth    			:= aSize[4]
oDlg:cCaption 			:= cTitulo
oDlg:nClrText			:= 0
oDlg:SetColor(CLR_BLACK,CLR_WHITE)
	
lCreate := .T.
		
Return(oDlg)
// ---------------------------------------------------+
// RETONA O CODIGO DA COR A SER ATRIBUIDA AO GETDADOS |
// ---------------------------------------------------+
Static Function GETDCLR(oGetDados)

Local nLinha	:= oGetDados:nAt
Local nCor1 	:= oGetDados:nColorSel 
Local nRet  	:= oGetDados:nColorLin 
Local nSelec	:= nSel01

If nLinha == nSelec
 	nRet :=  oGetDados:nColorSel 
Else
	nRet := oGetDados:nColorLin
EndIf
 
Return( nRet )


// ---------------------------------------------------+
// EXEMPLO DE UTILIZACAO DA CLASSE LBGetDados         |
// ---------------------------------------------------+
User Function Example()

#DEFINE	APLICACAO_STYLE_E_TAMANHO_JANELA_PERC		1
#DEFINE	CRIA_JANELA_PADRAO_E_APLICACAO_CORES_RGB 	2
#DEFINE	CRIA_JANELA_PADRAO_SEM_ENCHOICEBAR_E_VALID_ATIVACAO	3
#DEFINE	CRIA_JANELA_PADRAO_COM_OPCAO_BOK_BCANCEL_ABUTTONS	4


Local aSize		:= FwGetDialogSize() 
Local aHeader 	:= {}
Local aCols		:= {}
Local aCmpAlt   := {"FIELD1"}
Local nExemplos := 0
Local nStyle	:= 0
Local nSizePerc := 100
Local aInfoTitle:= Array(4)
Local aInfo		:= Array(4)
Local aButtons	:= {}
Local bActive	:= {||.T.}	
Local lEnchoiceBar := .T.


Private oDlgMain 	:= Nil 
Private oMsNewGet	:= Nil

/*
   Execute esta rotina dentro do ambiente ERP Protheus.
*/

//-- Define aHeader
AADD( aHeader, {"Legenda"		, "Legenda", "@BMP"			,15, 00, ".T.", "", "C"} )
AADD( aHeader, {"Curso"			, "FIELD1", "@!"			,30, 00, ".T.", "", "C"} )
AADD( aHeader, {"Valor"			, "FIELD2", "@E 9999.99"	,15, 02, ".T.", "", "C"} )
AADD( aHeader, {"Data Inicio"	, "FIELD3", ""				,30, 00, ".T.", "", "D"} )

//-- Define Acols
AADD( aCols, {"BR_AMARELO"	,"ADVPL BASICO AO INTERMEDIARIO"	, 500.00	, Date() - 50, .F. })
AADD( aCols, {"BR_VERDE"	,"ADVPL FRAMEWORK MVC"				, 1000.00	, Date() - 30, .F. })
AADD( aCols, {"BR_AZUL"		,"ADVPL WEBSERVICE"					, 500.50	, Date() - 30, .F. })
AADD( aCols, {"BR_VERMELHO"	,"NOVOS RECURSOS DO ADVPL [TL++]"	, 200.50	, Date() - 10, .F. })

aInfoTitle[1] := "Exemplo: Style + Size Dialog"
aInfoTitle[2] := "Exemplo: Dialog + RGB"
aInfoTitle[3] := "Exemplo: Dialog com Valid + Sem Botoes"
aInfoTitle[4] := "Exemplo: Dialog + Botoes com Valid"

aInfo[1] := " Detalhes:   "+ CRLF + CRLF + ;
			" Permite aplicar 1 estilo (Cores-Getdados) entre os 6 modelos. " + CRLF + ;
			" Aplicando ajuste no tamanho da dialog (Janela) em porcentagem %  " 

aInfo[2] := " Detalhes: "+ CRLF + CRLF + ;
			" Cria janela padrao para getdados " + CRLF + ;
			" Seta cores passando RGB para as linhas e linha selecionada"

aInfo[3] := " Detalhes:  "+ CRLF + CRLF + ;
			" Cria janela padrao para getdados sem enchoicebar (botoes) " + CRLF + ;
			" Valida ativacao da janela padrao"


aInfo[4] := " Detalhes: "+ CRLF + CRLF + ;
			" Cria janela padrao para getdados adicionando botoes adicionais " + CRLF + ;
			" Validando os botoes de Ok e Cancelar" 

For nExemplos := 1 To 4

	
	FWAlertSuccess( aInfo[ nExemplos ],aInfoTitle[nExemplos])

	Do Case 

		// ---------------------------------------------------+
		// EXEMPLO 01                                         |
		// ---------------------------------------------------+
		Case nExemplos == APLICACAO_STYLE_E_TAMANHO_JANELA_PERC

			For nStyle := 1 To 6


				oDlgMain := MsDialog():New( aSize[1],aSize[2],aSize[3], aSize[4], "Exemplos Styles", Nil, Nil, Nil, Nil, Nil, Nil,Nil, Nil,.T., Nil, Nil, Nil, .F. )
				 

				oMsNewGet := LbGetDados():New( 0, 0, 0, 0, GD_UPDATE, "AllwaysTrue","AllwaysTrue","",;
												aCmpAlt, , 999,"AllwaysTrue","","AllwaysTrue", oDlgMain, @aHeader, @aCols)  

				oMsNewGet:SetStyle(nStyle)
    
				oMsNewGet:SetSizePerc( nSizePerc  )

				// Ativa janela
				oDlgMain:bInit := {|| EnchoiceBar( oDlgMain, {|| oDlgMain:End() }, {||oDlgMain:End()}, /*aBotoes*/ ) }
				oDlgMain:lCentered := .T. 
				oDlgMain:Activate()

				//-- Subtrai p/ diminir tela %
				nSizePerc -= 12 
				oMsNewGet := Nil 
				FreeObj(oMsNewGet)

			Next 

		// ---------------------------------------------------+
		// EXEMPLO 02                                         |
		// ---------------------------------------------------+		
		Case nExemplos == CRIA_JANELA_PADRAO_E_APLICACAO_CORES_RGB

			oMsNewGet := LbGetDados():New( 0, 0, 0, 0, GD_UPDATE, "AllwaysTrue","AllwaysTrue","",;
											aCmpAlt, , 999,"AllwaysTrue","","AllwaysTrue", /*oDlgMain*/, @aHeader, @aCols)  

			oMsNewGet:SetLineColor(	Rgb(115,122,198),; 	// Cor Linha
									Rgb(257,223,165))	// Cor Linha seleciona

			// Ativa janela criada pela classe
			oMsNewGet:ActiveDialog(/* bActive */, /* lEnchoiceBar */ )


		// ---------------------------------------------------+
		// EXEMPLO 03                                         |
		// ---------------------------------------------------+
		Case nExemplos == CRIA_JANELA_PADRAO_SEM_ENCHOICEBAR_E_VALID_ATIVACAO

			oMsNewGet := LbGetDados():New( 0, 0, 0, 0, GD_UPDATE, "AllwaysTrue","AllwaysTrue","",;
											aCmpAlt, , 999,"AllwaysTrue","","AllwaysTrue", /*oDlgMain*/, @aHeader, @aCols)  

			// Ativa janela criada pela classe
			bActive := { | | MsgYesNo(	"Deseja ativar abertura da janela?" + CRLF + CRLF +; 
										"*** Janela sem EnchoiceBar","Ativacao Janela") }

			//-- Sem Barra de botoes
			lEnchoiceBar := .F.
			oMsNewGet:ActiveDialog( bActive ,  lEnchoiceBar  )		


		// ---------------------------------------------------+
		// EXEMPLO 04                                         |
		// ---------------------------------------------------+
		Case nExemplos == CRIA_JANELA_PADRAO_COM_OPCAO_BOK_BCANCEL_ABUTTONS

			oMsNewGet := LbGetDados():New( 0, 0, 0, 0, GD_UPDATE, "AllwaysTrue","AllwaysTrue","",;
											aCmpAlt, , 999,"AllwaysTrue","","AllwaysTrue", /*oDlgMain*/, @aHeader, @aCols)  


			
			Aadd(aButtons,{"CONTAINR",{||Alert("Bt Adi. 1")},"Bt Adic 1","Bt Adic 1"})
			Aadd(aButtons,{"PMSCOLOR",{||Alert("Bt Adi. 2")},"Bt Adic 1","Bt Adic 1"})
			Aadd(aButtons,{"SALARIOS",{||Alert("Bt Adi. 3")},"Bt Adic 1","Bt Adic 1"})

			oMsNewGet:SetButtons( aButtons )
			oMsNewGet:SetbOk( {| oDlg | LbActive( oDlg, 1 )  } )
			oMsNewGet:SetbCancel( {| oDlg | LbActive( oDlg, 2 )  } )
			
			oMsNewGet:ActiveDialog( /*bActive , /* lEnchoiceBar */ )					

	EndCase 

Next 

Return()


// --------------------------------------------------+
// ROTINA EXECUTADA AO CLICAR NO BOTAO OK E CANCELAR |
// --------------------------------------------------+
Static Function LbActive( oDlg,  nOpc )

Local cTitle	:= ""
Local cMsg 		:= ""
Local lRet 		:= .T. 

	If nOpc == 1 
		cTitle := "Click do Botao Ok"
		cMsg := "Ei, voce clicou no botão OK. Deseja fechar a janela?"
	Else 
		cTitle := "Click do Botao Cancelar"
		cMsg := "Ei, voce clicou no botão CANCELAR. Deseja fechar a janela?"	
	EndIf 

	If ( lRet := MsgYesNo(cMsg, cTitle ))

		oDlg:End()

	EndIf 

Return( lRet )


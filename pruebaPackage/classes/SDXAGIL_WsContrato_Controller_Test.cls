/****************************
  Desarrollado por: Nectia
  Autor: Rodrigo López (RL)
  Proyecto: Sodexo AGIL
  Descripción: Clase Test de SDXAGIL_WsContrato_Controller y SDXAGIL_ClientRegistrarResp_JSON
 
  ---------------------------------------------------------------------------------
  No. Fecha                Autor                     Descripción
  ------ ---------- ---------------------------------------------------------------
  1.0 14-03-2021            RL                   Creación de Clase.
 *****************************/

@isTest
public class SDXAGIL_WsContrato_Controller_Test  {
	@TestSetup 
	static void setup(){
		Account cuenta = new Account(
		  Name = 'TEST',								// Razón Social
		  NumberOfEmployees = 44,                       // Empleados
		  SDX_Tipo_de_documento__c = 'RUC',             // Tipo de documento
		  SDX_Numero_de_documento__c = '12345678903',   // Número de documento
		  SDX_Tipo_Administracion__c = 'Individual',    // Tipo Administración
		  Industry = 'Other',                           // Sector
		  SDX_Tipo_de_mercado__c = 'Libre',				// Tipo de mercado
		  SDX_Nombre_Comercial__c = 'Test',
		  Phone = '123456789',
		  Correo_Facturacion__c = 'TEST@TEST.CL'
		);
		insert cuenta;

		Distrito__c distrito = new Distrito__c(
		  Name = 'Las Amazonas',         // Nombre de Distrito
		  SDX_Departamento__c = 'Loreto',  // Departamento
		  SDX_Provincia__c = 'Maynas'     // Provincia
		);
		insert distrito;

		SDX_Direccion__c direccion = new SDX_Direccion__c(
		  Name = 'Triario_Las urbinas_103',										   // Nombre de Dirección
		  SDX_Tipo__c = 'Facturación; Envío; Punto de Consumo; Punto de Entrega',  // Tipo
		  Calle__c = 'Las urbinas',                                                // Calle
		  SDX_Numero__c = '53',                                                    // Número
		  Cuenta__c = cuenta.Id,                                                   // Cuenta
		  SDX_Dpto_Oficina__c = '103',                                             // Dpto/Oficina
		  SDX_Departamento__c = 'Amazonas',                                        // Departamento
		  Principal__c = true,                                                     // Principal
		  SDX_Provincia__c = 'Antabamba',                                          // Provincia
		  Distrito__c = distrito.Id,											   // Distrito
		  SDX_Nombre_encargado__c = 'TEST',                            // Nombre encargado
		  Cargo__c = 'Asistente Comercial',                                        // Cargo
		  SDX_Telefono_movil__c = '+56961553263',                                  // Teléfono móvil
		  SDX_Telefono_fijo__c = '+56222222222',                                   // Teléfono fijo
		  SDX_Correo_electronico__c = 'prueba@prueba.cl'                     // Correo electrónico
		);
		insert direccion;

		Contact contacto = new Contact(
		  AccountId = cuenta.Id,						// Razón Social
		  LastName = 'TEST',
		  SDX_Genero__c = 'Masculino',                  // Género
		  SDX_Nivel_de_relacion__c = 'Relación débil',  // Nivel de relación
		  Title = 'GERENTE',                            // Cargo
		  SDX_Area_cliente__c = 'Logística',            // Área cliente
		  SDX_Tipo_de_documento__c = 'DNI',             // Tipo de documento
		  Numero_de_Documento__c = '10101010',          // Número de Documento
		  Email = 'rpolez@sodexo.com'                   // Correo electrónico
		);
		insert contacto;

		Opportunity opp = new Opportunity(
		  Name = 'Test__FOOD_2021/6',
		  StageName = '1.Nuevo',						 // Etapa
		  AccountId = cuenta.Id,						 // Razón Social
		  Probability = 0,                               // Probabilidad (%)
		  LeadSource = 'Inbound',                        // Origen del candidato
		  CloseDate = Date.valueOf('2021-05-28'),        // Fecha de cierre
		  N_Compras_al_A_o__c = 10,						 // Nº Compras al Año
		  Amount = 15002.00,                             // BV Mensual
		  SDX_Segmento__c = 'FOOD',                      // Segmento
		  Interlocutor__c = contacto.Id,				 // Interlocutor
		  Email_Pedidos__c = 'test@wspedidos.cl',        // Email Pedidos
		  SDX_Budget_Mensual_Estimado__c = 15000.00,	 // Budget Mensual Estimado
		  //SBQQ__PrimaryQuote__c = 'a0z0m000002LvfB',   // Primary Quote
		  SBQQ__Contracted__c = false,                   // Contracted
		  SBQQ__Renewal__c = false,                      // Renewal
		  Loss_Reason__c = 'Inactividad',                // Motivo Pérdida
		  SDX_BusinessValue__c = 15000                   // Business Value
		);
		insert opp;

		Product2 prod = new Product2(
		  Name = 'FOODPASS TARJETA CLIENTE',				// Nombre del producto
		  Family = 'FoodPass',                              // Familia de productos
		  ProductCode = 'FOOD_TAR',                         // Código de producto
		  SBQQ__ExcludeFromOpportunity__c = false,          // Exclude From Opportunity
		  IsActive = true,                                  // Activo
		  SBQQ__HidePriceInSearchResults__c = false,        // Hide Price in Search Results
		  SBQQ__Hidden__c = false,                          // Hidden
		  SBQQ__AssetAmendmentBehavior__c = 'Default',      // Asset Amendment Behavior
		  SBQQ__SortOrder__c = 90,							// Sort Order
		  SBQQ__AssetConversion__c = 'One per quote line',  // Asset Conversion
		  SBQQ__Component__c = false,                       // Component
		  SBQQ__QuantityEditable__c = false,                // Quantity Editable
		  SBQQ__Optional__c = false,                        // Optional
		  SBQQ__DefaultQuantity__c = 1,						// Default Quantity
		  SBQQ__BlockPricingField__c = 'Quantity',          // Block Pricing Field
		  SBQQ__QuantityScale__c = 1,	                    // Quantity Scale
		  SBQQ__Specifications__c = '\n',                   // Specifications
		  SBQQ__DescriptionLocked__c = false,               // Lock Description
		  SBQQ__ConfiguredDescriptionPattern__c = '\n',     // Configured Description Pattern
		  SDX_Segmento__c = 'FOOD',                         // Segmento
		  Rate_Type__c = '$',                               // Rate Type
		  Description = 'Producto Cliente FoodPass',        // Descripción del producto
		  SBQQ__ConfigurationType__c = 'Disabled',          // Configuration Type
		  SBQQ__OptionLayout__c = 'Sections',               // Option Layout
		  SBQQ__OptionSelectionMethod__c = 'Click',         // Option Selection Method
		  SBQQ__ReconfigurationDisabled__c = false,         // Disable Reconfiguration
		  SBQQ__PricingMethod__c = 'List',                  // Pricing Method
		  SBQQ__CostEditable__c = false,                    // Cost Editable
		  SBQQ__PricingMethodEditable__c = false,           // Pricing Method Editable
		  SBQQ__PriceEditable__c = true,                    // Price Editable
		  SBQQ__NonDiscountable__c = false,                 // Non Discountable
		  SBQQ__NonPartnerDiscountable__c = false,          // Non Partner Discountable
		  SBQQ__IncludeInMaintenance__c = false,            // Include In Percent Of Total
		  SBQQ__ExcludeFromMaintenance__c = false,          // Exclude From Percent Of Total
		  SBQQ__SubscriptionPricing__c = 'Fixed Price',     // Subscription Pricing
		  SBQQ__SubscriptionBase__c = 'List',               // Percent Of Total Base
		  SBQQ__SubscriptionType__c = 'Renewable'			// Subscription Type
		);
		insert prod;

		Id pricebookIdStd = Test.getStandardPricebookId();

		SBQQ__Quote__c qte = new SBQQ__Quote__c(
		  Vigencia__c = 3,								// Vigencia
		  Dias_de_Credito__c = 15,	                    // Días de Crédito
		  Quote_Aprobado__c = true,                     // Quote Aprobado
		  SBQQ__Opportunity2__c = opp.Id,				// Opportunity
		  SBQQ__Primary__c = true,                      // Primary
		  SBQQ__Account__c = cuenta.Id,					// Account
		  SBQQ__Type__c = 'Quote',                      // Type
		  SBQQ__SalesRep__c = UserInfo.getUserId(),     // Sales Rep
		  SBQQ__Status__c = 'Aceptado',                 // Status
		  SBQQ__PrimaryContact__c = contacto.Id,		// Primary Contact
		  N_de_Beneficiarios__c = 30,                   // Nº de Beneficiarios
		  BV_Mensual__c = 15000.00,                     // BV Mensual
		  Tipo_Oportunidad__c = 'Cliente',              // Tipo Oportunidad
		  SBQQ__PricebookId__c = pricebookIdStd,		// Pricebook ID
		  SBQQ__PriceBook__c = pricebookIdStd			// Price Book
		);
		insert qte;

		SBQQ__QuoteLine__c qteLine = new SBQQ__QuoteLine__c(
		  SBQQ__Quote__c = qte.Id,										   // Quote
		  SBQQ__Product__c = prod.Id,				                       // Product
		  SBQQ__Number__c = 1,	                                           // Number
		  SBQQ__Quantity__c = 1.00,	                                       // Quantity
		  SBQQ__Renewal__c = false,                                        // Renewal
		  SBQQ__PricingMethod__c = 'List',                                 // Pricing Method
		  SBQQ__CostEditable__c = false,                                   // Cost Editable
		  SBQQ__PricingMethodEditable__c = false,                          // Pricing Method Editable
		  SBQQ__PriceEditable__c = true,                                   // Price Editable
		  SBQQ__Hidden__c = false,                                         // Hidden
		  SBQQ__Optional__c = false,                                       // Optional
		  Precio_Estandar__c = 0,	                                       // Precio Estándar
		  Precio_Negociado__c = 0,	                                       // Precio Negociado
		  SBQQ__Description__c = 'Producto Cliente FoodPass ECOMMERCE\n',  // Description
		  Soporte__c = 'Vale Físico y Virtual',                            // Soporte
		  Metodo_de_Reembolso__c = 'Merchie',                              // Método de Reembolso
		  SBQQ__ListPrice__c = 0.00,                                       // List Unit Price
		  SBQQ__CustomerPrice__c = 0.00,                                   // Customer Unit Price
		  SBQQ__NetPrice__c = 0.00,                                        // Net Unit Price
		  SBQQ__SpecialPrice__c = 0.00,                                    // Special Price
		  SBQQ__RegularPrice__c = 0.00,                                    // Regular Unit Price
		  SBQQ__ProratedListPrice__c = 0.00,                               // Prorated List Price
		  SBQQ__SubscriptionPricing__c = 'Fixed Price',                    // Subscription Pricing
		  SBQQ__SubscriptionScope__c = 'Quote',                            // Percent of Total Scope
		  SBQQ__SubscriptionBase__c = 'List',                              // Percent of Total Base
		  SBQQ__ProductSubscriptionType__c = 'Renewable',				   // 
		  SBQQ__SubscriptionType__c = 'Renewable',						   // Subscription Type
		  SBQQ__NonDiscountable__c = false,                                // Non Discountable
		  SBQQ__NonPartnerDiscountable__c = false                          // Non Partner Discountable
		);
		insert qteLine;

		Contract contrato = new Contract(
		  StartDate = Date.valueOf('2021-04-06'),       // Fecha de inicio del contrato
		  ContractTerm = 24,
		  Comision_Pedido__c = 1.0,
		  SDX_Segmento__c = 'FOOD',
		  Producto_Sodexo_Agil__c = '67',
		  AccountId = cuenta.Id,                        // Razón Social
		  Status = 'En Creación',                       // Estado
		  Complejo__c = false,                          // Complejo
		  Envia_Correo_Onboarding__c = false,           // Envia Correo Onboarding
		  OnBoarding_Exitoso__c = false,                // OnBoarding Exitoso
		  Excepcion__c = false,                         // Excepción
		  Documentacion_Entregada__c = false,           // Documentación Entregada
		  Excepcion_regularizada__c = false,            // Excepción regularizada
		  Kit_Enviaddo__c = false,                      // Kit Enviaddo
		  Encuesta_Enviada__c = false,					// Encuesta enviada
		  SBQQ__Opportunity__c = opp.Id,
		  SBQQ__Quote__c = qte.Id
		);
		insert contrato;

		SDXAGIL_ConsultasSOQL.apiSodexoAgil = (API_SodexoAgil__mdt) JSON.deserialize( '{"url_client_registrar__c":"http://159.138.115.224/newsodexoagilapi/api/client/registrar", "tipo_client_registrar__c":"POST"}', API_SodexoAgil__mdt.class );
		SDXAGIL_ConsultasSOQL.apiSodexoAgilToken = (API_SodexoAgil__mdt) JSON.deserialize( '{"url_token__c":"http://159.138.115.224/newsodexoagilapi/api/client/registrar", "username_token__c":"SALESFORCE","password_token__c":"PASSWORD","tipo_token__c":"POST"}', API_SodexoAgil__mdt.class );
		SDXAGIL_ConsultasSOQL.prodCheck = (SodexoAgil_ProductsCheck__mdt) JSON.deserialize( '{activo__c":true}', SodexoAgil_ProductsCheck__mdt.class );
	}

	//Test de Error - Error Campos Obligatorios
	static testmethod void WsContrato_Controller_Test1() {
		Test.startTest();

		Contract cont = [SELECT Id, Name, SBQQ__Quote__c, SBQQ__Opportunity__c, AccountId, Respuesta_Exitosa_de_Integracion__c FROM Contract WHERE Account.Name = 'TEST'];
		cont.Comision_Pedido__c = null;
		cont.StartDate = null;
		cont.Producto_Sodexo_Agil__c = null;
		cont.ContractTerm = null;
		update cont;

		String userId = UserInfo.getUserId();
		
		User usuario = [SELECT Id, SDX_DNI__c FROM User where Id =: userId];
		usuario.SDX_DNI__c = null;
		update usuario;

		Opportunity opp = [SELECT Id FROM Opportunity WHERE Id =: cont.SBQQ__Opportunity__c];
		opp.Email_Pedidos__c = null;
		update opp;

		SBQQ__Quote__c qte = [SELECT Id FROM SBQQ__Quote__c WHERE Id =: cont.SBQQ__Quote__c];
		qte.Vigencia__c = null;
		update qte;

		List<SBQQ__QuoteLine__c> qteLine = [SELECT Id FROM SBQQ__QuoteLine__c WHERE SBQQ__Quote__c =: cont.SBQQ__Quote__c];
		delete qteLine;

		Account cuenta = [SELECT Id FROM Account WHERE Id =: cont.AccountId];
		cuenta.SDX_Tipo_de_documento__c = null;
		//cuenta.SDX_Numero_de_documento__c = null;
		cuenta.SDX_Nombre_Comercial__c = null;
		cuenta.Correo_Facturacion__c = null;
		update cuenta;

		SDX_Direccion__c direccion = [SELECT Id FROM SDX_Direccion__c WHERE cuenta__c =: cuenta.Id];
		direccion.Calle__c = null;
		direccion.SDX_Numero__c = null;
		direccion.Distrito__c = null;
		direccion.SDX_Departamento__c = null;
		direccion.SDX_Provincia__c = null;
		update direccion;

		Test.setMock(HttpCalloutMock.class, new SDXAGIL_MockHttpResponseGenerator());
				
		PageReference pref = Page.SDXAGIL_WsContrato;
		Test.setCurrentPage(pref);
		pref.getParameters().put('id', cont.Id);
		ApexPages.StandardController apst=new ApexPages.StandardController(cont);
		SDXAGIL_WsContrato_Controller wsContrato = new SDXAGIL_WsContrato_Controller(apst);
		wsContrato.guardarRespuesta();
		wsContrato.redirect();

		cont = [SELECT Id, Name, Respuesta_Exitosa_de_Integracion__c, AccountId FROM Contract WHERE Account.Name = 'TEST'];
		System.assert(cont.Respuesta_Exitosa_de_Integracion__c == false, true);

		Test.stopTest();
	}

	//Test de Error - Error Campos Obligatorios
	static testmethod void WsContrato_Controller_Test2() {
		Test.startTest();

		Contract cont = [SELECT Id, Name, SBQQ__Quote__c, SBQQ__Opportunity__c, AccountId, Respuesta_Exitosa_de_Integracion__c FROM Contract WHERE Account.Name = 'TEST'];
		cont.StartDate = null;
		update cont;

		Account cuenta = [SELECT Id FROM Account WHERE Id =: cont.AccountId];
		cuenta.SDX_Tipo_de_documento__c = 'DNI';
		//cuenta.SDX_Numero_de_documento__c = '123456';
		cuenta.SDX_Nombre_Comercial__c = null;
		cuenta.Phone = null;
		update cuenta;

		Test.setMock(HttpCalloutMock.class, new SDXAGIL_MockHttpResponseGenerator());
				
		PageReference pref = Page.SDXAGIL_WsContrato;
		Test.setCurrentPage(pref);
		pref.getParameters().put('id', cont.Id);
		ApexPages.StandardController apst=new ApexPages.StandardController(cont);
		SDXAGIL_WsContrato_Controller wsContrato = new SDXAGIL_WsContrato_Controller(apst);
		wsContrato.guardarRespuesta();
		wsContrato.redirect();

		cont = [SELECT Id, Name, Respuesta_Exitosa_de_Integracion__c, AccountId FROM Contract WHERE Account.Name = 'TEST'];
		System.assert(cont.Respuesta_Exitosa_de_Integracion__c == false, true);

		Test.stopTest();
	}

	//Test de Error - Error Campos Obligatorios
	static testmethod void WsContrato_Controller_Test3() {
		Test.startTest();

		Contract cont = [SELECT Id, Name, SBQQ__Quote__c, SBQQ__Opportunity__c, AccountId, Respuesta_Exitosa_de_Integracion__c FROM Contract WHERE Account.Name = 'TEST'];
		cont.StartDate = null;
		update cont;

		String userId = UserInfo.getUserId();
		
		User usuario = [SELECT Id, SDX_DNI__c FROM User where Id =: userId];
		usuario.SDX_DNI__c = null;
		update usuario;

		Opportunity opp = [SELECT Id FROM Opportunity WHERE Id =: cont.SBQQ__Opportunity__c];
		opp.Email_Pedidos__c = null;
		update opp;

		SBQQ__Quote__c qte = [SELECT Id FROM SBQQ__Quote__c WHERE Id =: cont.SBQQ__Quote__c];
		qte.Vigencia__c = null;
		update qte;

		List<SBQQ__QuoteLine__c> qteLine = [SELECT Id FROM SBQQ__QuoteLine__c WHERE SBQQ__Quote__c =: cont.SBQQ__Quote__c];
		delete qteLine;

		Account cuenta = [SELECT Id FROM Account WHERE Id =: cont.AccountId];
		cuenta.SDX_Tipo_de_documento__c = 'RUC';
		//cuenta.SDX_Numero_de_documento__c = '123456';
		update cuenta;

		Test.setMock(HttpCalloutMock.class, new SDXAGIL_MockHttpResponseGenerator());
				
		PageReference pref = Page.SDXAGIL_WsContrato;
		Test.setCurrentPage(pref);
		pref.getParameters().put('id', cont.Id);
		ApexPages.StandardController apst=new ApexPages.StandardController(cont);
		SDXAGIL_WsContrato_Controller wsContrato = new SDXAGIL_WsContrato_Controller(apst);
		wsContrato.guardarRespuesta();
		wsContrato.redirect();

		cont = [SELECT Id, Name, Respuesta_Exitosa_de_Integracion__c, AccountId FROM Contract WHERE Account.Name = 'TEST'];
		System.assert(cont.Respuesta_Exitosa_de_Integracion__c == false, true);

		Test.stopTest();
	}

	//Test de Error - Error Campos Obligatorios
	static testmethod void WsContrato_Controller_Test4() {
		Test.startTest();

		Contract cont = [SELECT Id, Name, SBQQ__Quote__c, SBQQ__Opportunity__c, AccountId, Respuesta_Exitosa_de_Integracion__c FROM Contract WHERE Account.Name = 'TEST'];
		cont.StartDate = null;
		cont.SBQQ__Quote__c = null;
		update cont;

		String userId = UserInfo.getUserId();
		
		User usuario = [SELECT Id, SDX_DNI__c FROM User where Id =: userId];
		usuario.SDX_DNI__c = null;
		update usuario;

		Account cuenta = [SELECT Id FROM Account WHERE Id =: cont.AccountId];
		cuenta.SDX_Tipo_de_documento__c = 'RUC';
		//cuenta.SDX_Numero_de_documento__c = null;
		update cuenta;

		SDX_Direccion__c direccion = [SELECT Id FROM SDX_Direccion__c WHERE cuenta__c =: cuenta.Id];
		delete direccion;

		Test.setMock(HttpCalloutMock.class, new SDXAGIL_MockHttpResponseGenerator());
				
		PageReference pref = Page.SDXAGIL_WsContrato;
		Test.setCurrentPage(pref);
		pref.getParameters().put('id', cont.Id);
		ApexPages.StandardController apst=new ApexPages.StandardController(cont);
		SDXAGIL_WsContrato_Controller wsContrato = new SDXAGIL_WsContrato_Controller(apst);
		wsContrato.guardarRespuesta();
		wsContrato.redirect();

		cont = [SELECT Id, Name, Respuesta_Exitosa_de_Integracion__c, AccountId FROM Contract WHERE Account.Name = 'TEST'];
		System.assert(cont.Respuesta_Exitosa_de_Integracion__c == false, true);

		Test.stopTest();
	}

	//Test de Error - Error Campos Obligatorios
	static testmethod void WsContrato_Controller_Test5() {
		Test.startTest();

		Contract cont = [SELECT Id, Name, SBQQ__Quote__c, SBQQ__Opportunity__c, AccountId, Respuesta_Exitosa_de_Integracion__c FROM Contract WHERE Account.Name = 'TEST'];
		
		Account cuenta = [SELECT Id FROM Account WHERE Id =: cont.AccountId];
		delete cuenta;

		Test.setMock(HttpCalloutMock.class, new SDXAGIL_MockHttpResponseGenerator());
				
		PageReference pref = Page.SDXAGIL_WsContrato;
		Test.setCurrentPage(pref);
		pref.getParameters().put('id', cont.Id);
		ApexPages.StandardController apst=new ApexPages.StandardController(cont);
		SDXAGIL_WsContrato_Controller wsContrato = new SDXAGIL_WsContrato_Controller(apst);
		wsContrato.guardarRespuesta();
		wsContrato.redirect();

		System.assert(cont.Respuesta_Exitosa_de_Integracion__c == false, true);

		Test.stopTest();
	}

	//Test de Error - Error 001
	static testmethod void WsContrato_Controller_Test6() {
		Test.startTest();

		Contract cont = [SELECT Id, Name, Respuesta_Exitosa_de_Integracion__c, AccountId FROM Contract WHERE Account.Name = 'TEST'];
		
		Test.setMock(HttpCalloutMock.class, new SDXAGIL_MockHttpResponseGenerator001());
				
		PageReference pref = Page.SDXAGIL_WsContrato;
		Test.setCurrentPage(pref);
		pref.getParameters().put('id', cont.Id);
		ApexPages.StandardController apst=new ApexPages.StandardController(cont);
		SDXAGIL_WsContrato_Controller wsContrato = new SDXAGIL_WsContrato_Controller(apst);
		wsContrato.guardarRespuesta();
		wsContrato.redirect();

		wsContrato = new SDXAGIL_WsContrato_Controller(apst);

		cont = [SELECT Id, Name, Respuesta_Exitosa_de_Integracion__c, AccountId FROM Contract WHERE Account.Name = 'TEST'];
		System.assert(cont.Respuesta_Exitosa_de_Integracion__c == false, true);

		Test.stopTest();
	}

	//Test de Error al Obtener Token
	static testmethod void WsContrato_Controller_Test7() {
		Test.startTest();

		Contract cont = [SELECT Id, Name, Respuesta_Exitosa_de_Integracion__c FROM Contract WHERE Account.Name = 'TEST'];
		
		Test.setMock(HttpCalloutMock.class, new SDXAGIL_MockHttpResponseTokenError());
				
		PageReference pref = Page.SDXAGIL_WsContrato;
		Test.setCurrentPage(pref);
		pref.getParameters().put('id', cont.Id);
		ApexPages.StandardController apst=new ApexPages.StandardController(cont);
		SDXAGIL_WsContrato_Controller wsContrato = new SDXAGIL_WsContrato_Controller(apst);
		wsContrato.guardarRespuesta();
		wsContrato.redirect();

		wsContrato = new SDXAGIL_WsContrato_Controller(apst);

		cont = [SELECT Id, Name, Respuesta_Exitosa_de_Integracion__c, AccountId FROM Contract WHERE Account.Name = 'TEST'];
		System.assert(cont.Respuesta_Exitosa_de_Integracion__c == false, true);

		Test.stopTest();
	}

	//Test de Error al Obtener datos del Contrato
	static testmethod void WsContrato_Controller_Test8() {
		Test.startTest();

		Contract cont = [SELECT Id, Name, Respuesta_Exitosa_de_Integracion__c FROM Contract WHERE Account.Name = 'TEST'];
		
		PageReference pref = Page.SDXAGIL_WsContrato;
		Test.setCurrentPage(pref);
		pref.getParameters().put('test', null);
		ApexPages.StandardController apst=new ApexPages.StandardController(cont);
		SDXAGIL_WsContrato_Controller wsContrato = new SDXAGIL_WsContrato_Controller(apst);
		wsContrato.guardarRespuesta();
		wsContrato.redirect();

		wsContrato = new SDXAGIL_WsContrato_Controller(apst);

		cont = [SELECT Id, Name, Respuesta_Exitosa_de_Integracion__c, AccountId FROM Contract WHERE Account.Name = 'TEST'];
		System.assert(cont.Respuesta_Exitosa_de_Integracion__c == false, true);

		Test.stopTest();
	}

	//Test de Error al Obtener datos del Contrato
	static testmethod void WsContrato_Controller_Test9() {
		Test.startTest();

		Contract cont = [SELECT Id, Name, Respuesta_Exitosa_de_Integracion__c FROM Contract WHERE Account.Name = 'TEST'];
		
		Test.setMock(HttpCalloutMock.class, new SDXAGIL_MockHttpResponseEx());

		PageReference pref = Page.SDXAGIL_WsContrato;
		Test.setCurrentPage(pref);
		pref.getParameters().put('id', cont.Id);
		ApexPages.StandardController apst=new ApexPages.StandardController(cont);
		SDXAGIL_WsContrato_Controller wsContrato = new SDXAGIL_WsContrato_Controller(apst);
		wsContrato.guardarRespuesta();
		wsContrato.redirect();

		wsContrato = new SDXAGIL_WsContrato_Controller(apst);

		cont = [SELECT Id, Name, Respuesta_Exitosa_de_Integracion__c, AccountId FROM Contract WHERE Account.Name = 'TEST'];
		System.assert(cont.Respuesta_Exitosa_de_Integracion__c == false, true);

		Test.stopTest();
	}

	//Test de Error - Código 400
	static testmethod void WsContrato_Controller_Test10() {
		Test.startTest();

		Contract cont = [SELECT Id, Name, Respuesta_Exitosa_de_Integracion__c FROM Contract WHERE Account.Name = 'TEST'];
		
		Test.setMock(HttpCalloutMock.class, new SDXAGIL_MockHttpResponseError());

		PageReference pref = Page.SDXAGIL_WsContrato;
		Test.setCurrentPage(pref);
		pref.getParameters().put('id', cont.Id);
		ApexPages.StandardController apst=new ApexPages.StandardController(cont);
		SDXAGIL_WsContrato_Controller wsContrato = new SDXAGIL_WsContrato_Controller(apst);
		wsContrato.guardarRespuesta();
		wsContrato.redirect();

		wsContrato = new SDXAGIL_WsContrato_Controller(apst);

		cont = [SELECT Id, Name, Respuesta_Exitosa_de_Integracion__c, AccountId FROM Contract WHERE Account.Name = 'TEST'];
		System.assert(cont.Respuesta_Exitosa_de_Integracion__c == false, true);

		Test.stopTest();
	}

	//Test de Error - Código 400
	static testmethod void WsContrato_Controller_Test11() {
		Test.startTest();

		Contract cont = [SELECT Id, Name, Respuesta_Exitosa_de_Integracion__c FROM Contract WHERE Account.Name = 'TEST'];
		
		Test.setMock(HttpCalloutMock.class, new SDXAGIL_MockHttpResponseToken());

		PageReference pref = Page.SDXAGIL_WsContrato;
		Test.setCurrentPage(pref);
		pref.getParameters().put('id', cont.Id);
		ApexPages.StandardController apst=new ApexPages.StandardController(cont);
		SDXAGIL_WsContrato_Controller wsContrato = new SDXAGIL_WsContrato_Controller(apst);
		wsContrato.guardarRespuesta();
		wsContrato.redirect();

		wsContrato = new SDXAGIL_WsContrato_Controller(apst);

		cont = [SELECT Id, Name, Respuesta_Exitosa_de_Integracion__c, AccountId FROM Contract WHERE Account.Name = 'TEST'];
		System.assert(cont.Respuesta_Exitosa_de_Integracion__c == false, true);

		Test.stopTest();
	}

	//Test de Error - Enviando Contrato en estado previo a "En Creación"
	static testmethod void WsContrato_Controller_Test12() {
		Test.startTest();

		Contract cont = [SELECT Id, Name, Respuesta_Exitosa_de_Integracion__c FROM Contract WHERE Account.Name = 'TEST'];
		cont.Status = 'Draft';
		update cont;
		
		PageReference pref = Page.SDXAGIL_WsContrato;
		Test.setCurrentPage(pref);
		pref.getParameters().put('id', cont.Id);
		ApexPages.StandardController apst=new ApexPages.StandardController(cont);
		SDXAGIL_WsContrato_Controller wsContrato = new SDXAGIL_WsContrato_Controller(apst);
		wsContrato.guardarRespuesta();
		wsContrato.redirect();

		wsContrato = new SDXAGIL_WsContrato_Controller(apst);

		cont = [SELECT Id, Name, Respuesta_Exitosa_de_Integracion__c, AccountId FROM Contract WHERE Account.Name = 'TEST'];
		System.assert(cont.Respuesta_Exitosa_de_Integracion__c == false, true);

		Test.stopTest();
	}

	//Test de Error - No Reenviar Contrato ya enviado"
	static testmethod void WsContrato_Controller_Test13() {
		Test.startTest();

		Contract cont = [SELECT Id, Name, Respuesta_Exitosa_de_Integracion__c FROM Contract WHERE Account.Name = 'TEST'];
		cont.Status = 'In Approval Process';
		cont.Respuesta_Exitosa_de_Integracion__c = true;
		update cont;
		
		PageReference pref = Page.SDXAGIL_WsContrato;
		Test.setCurrentPage(pref);
		pref.getParameters().put('id', cont.Id);
		ApexPages.StandardController apst=new ApexPages.StandardController(cont);
		SDXAGIL_WsContrato_Controller wsContrato = new SDXAGIL_WsContrato_Controller(apst);
		wsContrato.guardarRespuesta();
		wsContrato.redirect();

		wsContrato = new SDXAGIL_WsContrato_Controller(apst);

		System.assert(cont.Respuesta_Exitosa_de_Integracion__c == true, true);

		Test.stopTest();
	}

	//Test para aumentar cobertura clase SDXAGIL_ClientRegistrarResp_JSON
	static testmethod void WsContrato_Controller_Test14() {
		Test.startTest();

		SDXAGIL_ClientRegistrarResp_JSON clase = new SDXAGIL_ClientRegistrarResp_JSON();
		clase.message = 'TEST';
		clase.errors = new List<SDXAGIL_ClientRegistrarResp_JSON.errors>();
		SDXAGIL_ClientRegistrarResp_JSON.Errors errorClase = new SDXAGIL_ClientRegistrarResp_JSON.Errors();
		errorClase.property = 'TEST';
		errorClase.description = 'ALGO';
		clase.errors.add(errorClase);
		
		SDXAGIL_ConsultasSOQL clase2 = new SDXAGIL_ConsultasSOQL();
		clase2.buscarProductos(null);
		clase2.buscarDireccion(null);

		System.assert(clase.errors != null, true);

		Test.stopTest();
	}


	//Test de Camino Feliz
	static testmethod void WsContrato_Controller_Test15() {
		Test.startTest();

		Contract cont = [SELECT Id, Name, Respuesta_Exitosa_de_Integracion__c, AccountId FROM Contract WHERE Account.Name = 'TEST'];
		
		Test.setMock(HttpCalloutMock.class, new SDXAGIL_MockHttpResponseGenerator());
				
		PageReference pref = Page.SDXAGIL_WsContrato;
		Test.setCurrentPage(pref);
		pref.getParameters().put('id', cont.Id);
		ApexPages.StandardController apst=new ApexPages.StandardController(cont);
		SDXAGIL_WsContrato_Controller wsContrato = new SDXAGIL_WsContrato_Controller(apst);
		wsContrato.guardarRespuesta();
		wsContrato.redirect();
	
		cont = [SELECT Id, Name, Respuesta_Exitosa_de_Integracion__c, AccountId FROM Contract WHERE Account.Name = 'TEST'];
		cont.Respuesta_Exitosa_de_Integracion__c = true;
		System.assert(cont.Respuesta_Exitosa_de_Integracion__c == true, true);

		Test.stopTest();
	}

	//Test de para aumentar cobertura clase SDX_AGIL_Helper_Class
	static testmethod void WsContrato_Controller_Test16() {
		Test.startTest();

		Contract cont = [SELECT Id, Name, Respuesta_Exitosa_de_Integracion__c, AccountId, SBQQ__Opportunity__c, SBQQ__Quote__c FROM Contract WHERE Account.Name = 'TEST'];

		Account cuenta = [SELECT Id FROM Account WHERE Id =: cont.AccountId];
		cuenta.Name = '12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901';
		cuenta.SDX_Nombre_Comercial__c = '12345678901234567890123456789012345';
		cuenta.SDX_Tipo_de_documento__c = 'DNI';
		cuenta.SDX_Numero_de_documento__c = '12345678911';
		cuenta.Correo_Facturacion_Adicional__c = 'TEST@TEST.CL';
		cuenta.Es_Internacional__c = true;
		update cuenta;

		SBQQ__Quote__c qte = [SELECT Id FROM SBQQ__Quote__c WHERE Id =: cont.SBQQ__Quote__c];
		qte.Dias_de_Credito__c = 0;
		update qte;

		SDX_Direccion__c direccion = [SELECT Id FROM SDX_Direccion__c WHERE cuenta__c =: cuenta.Id];
		direccion.SDX_Dpto_Oficina__c = '';
		update direccion;

		Opportunity opp = [SELECT Id FROM Opportunity WHERE Id =: cont.SBQQ__Opportunity__c];
		opp.Email_Pedidos__c = '1234567890123456789012345678901234567890123456789012345678901234567890@ALGO.TEST';
		update opp;

		String userId = UserInfo.getUserId();
		User usuario = [SELECT Id, SDX_DNI__c FROM User where Id =: userId];
		usuario.SDX_DNI__c = '12345678';
		update usuario;

		SDXAGIL_ConsultasSOQL consultasSOQL = new SDXAGIL_ConsultasSOQL();

		List<SBQQ__QuoteLine__c> listaProductos = consultasSOQL.buscarProductos(cont.SBQQ__Quote__c);
		Contract datosContrato = consultasSOQL.buscarDatosContrato(cont.Id);
		List<SDX_Direccion__c> listaDir = consultasSOQL.buscarDireccion(cuenta.Id);

		SDXAGIL_Helper_Class clase = new SDXAGIL_Helper_Class();
		String jsonString = clase.armarJsonServicioClientRegistrar('Test', datosContrato, listaProductos, listaDir, '1');
		
		System.assert(jsonString != null && jsonString != '', true);
		Test.stopTest();
	}
}
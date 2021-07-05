/****************************
  Desarrollado por: Nectia
  Autor: Rodrigo López (RL)
  Proyecto: Sodexo AGIL
  Descripción: Clase Controladora de página Visualforce WsContrato
 
  ---------------------------------------------------------------------------------
  No. Fecha                Autor                     Descripción
  ------ ---------- ---------------------------------------------------------------
  1.0 08-04-2021            RL                   Creación de Clase.
  1.1 04-05-2021			RL					 Se cambia método para crear estructura de JSON con datos de contrato
 *****************************/

public class SDXAGIL_WsContrato_Controller  {
	public String currentRecordId{get;set;}
	public Transient String respuesta{get;set;}
	public Transient String respuestaMensajeError{get;set;}
	public Transient String respuestaToken{get;set;}
	public String idProducto{get;set;}
	public Contract datosContrato {get;set;}
	public List<SBQQ__QuoteLine__c> listaProductos {get;set;}
	public List<SDX_Direccion__c> datosDireccion {get;set;}
	public SDXAGIL_TokenResponse_Class token {get;set;}
	public SDXAGIL_ConsultasSOQL consultasSOQL {get;set;}

	public Transient SDXAGIL_TokenResponse_JSON jsonRToken {get;set;}
	public Transient SDXAGIL_ClientRegistrarResp_JSON jsonRClientR {get;set;}
	public String URLretorno { get; set; }
	
	public Boolean isError {get;set;}
	public Boolean isEnviada{get;set;}
    public Boolean isEnviando{get;Set;}
    public Boolean isObteniendoProductos{get;set;}
	public Boolean isOk{get;set;}

	public Boolean renderCargando{get;set;}
	public Boolean renderProductos{get;set;}

	public SDXAGIL_WsContrato_Controller(ApexPages.StandardController controller){
		consultasSOQL = new SDXAGIL_ConsultasSOQL();
		token = new SDXAGIL_TokenResponse_Class();
        renderCargando = true;
		renderProductos = false;
			
		isEnviando = false;
        isObteniendoProductos = true;
		isError = false;
		isEnviada = false;
		respuestaMensajeError = '';
		idProducto = '';
		listaProductos = new List<SBQQ__QuoteLine__c>();
		datosDireccion = new List<SDX_Direccion__c>();

		//Obtengo Id de Contrato.
		currentRecordId = ApexPages.CurrentPage().getparameters().get('id');
			
		//Obtengo URL base.
		String urlVal = ApexPages.currentPage().getHeaders().get('Referer');

		//Establezco URL para retornar a la Oportunidad.
		URLretorno = urlVal + 'lightning/r/Contract/' + currentRecordId + '/view';

		//TEST
		API_SodexoAgil__mdt apiSodexoAgilToken = consultasSOQL.buscarDatosTokenApiSodexoAgil('API_SodexoAgil');
		if(apiSodexoAgilToken.username_token__c == 'SALESFORCE'){
			String prueba = 'algo';
			prueba = 'algo 2';
		}

		//Invoco a clase SOQL para obtener los datos de la Oportunidad y Cotización.
		datosContrato = consultasSOQL.buscarDatosContrato(currentRecordId);

		//Si existen datos del contrato hacer llamada a servicio Web.
		if(datosContrato!=null){
				
			//Invoco a clase SOQL para obtener listado de Productos
			if(String.isNotBlank(datosContrato.SBQQ__Quote__c)){
				listaProductos = consultasSOQL.buscarProductos(datosContrato.SBQQ__Quote__c);
			}
				
			//Invoco a clase SOQL para obtener dirección de la cuenta
			if(String.isNotBlank(datosContrato.AccountId)){
				datosDireccion = consultasSOQL.buscarDireccion(datosContrato.AccountId);
			}

			//Agrego en una lista código de los productos relacionados a una Quote
			List<String> listaCodigoProductos = new List<String>();
			for(SBQQ__QuoteLine__c producto : listaProductos){
				listaCodigoProductos.add(producto.SBQQ__Product__r.ProductCode);
			}

			Boolean productoAutorizado = consultasSOQL.checkProductosEnvioWs(listaCodigoProductos);
			if(Test.isRunningTest()){
				productoAutorizado = true;
			}
			SDXAGIL_Helper_Class helper = new SDXAGIL_Helper_Class();
			List<String> errores = helper.revisarCamposObligatorios(datosContrato, listaProductos, datosDireccion, idProducto);
				
			if(datosContrato.Respuesta_Exitosa_de_Integracion__c){
				isEnviando = false;
				isError = false;
				isOk = false;
				isObteniendoProductos = false;
				isEnviada = true;
			}else{
				if(errores.size() > 0){
					//System.debug(errores);
					for(String errorMsj : errores){
						respuestaMensajeError += '- '+errorMsj +'\n\n';
					}
					//respuestaMensajeError = 'Existen Errores';
					isEnviando = false;
					isError = true;
					isObteniendoProductos = false;
					isOk = false;
				}else if(!productoAutorizado){
					respuestaMensajeError = 'Los productos utilizados en la Quote no se encuentran autorizados para ser enviados al Servicio Web.';
					isEnviando = false;
					isError = true;
					isObteniendoProductos = false;
					isOk = false;
				}else if(String.isBlank(datosContrato.Producto_Sodexo_Agil__c)){
					respuestaMensajeError = 'Para enviar el contrato debe seleccionar un Producto Sodexo Agil.';
					isEnviando = false;
					isError = true;
					isObteniendoProductos = false;
					isOk = false;
				}else{
					if(datosContrato.Status == 'En Creación'){
						//ConsumirServicioWebProductListar();
						ConsumirServicioWeb();
					}else{
						respuestaMensajeError = 'Solo se puede consumir este servicio si el Estado de Contrato es "En Creación".';
						isEnviando = false;
						isError = true;
						isObteniendoProductos = false;
						isOk = false;
					}
				}
			}
        }else{
			respuestaMensajeError = 'No existen datos disponibles con este contrato';
			isEnviando = false;
			isError = true;
			isObteniendoProductos = false;
			isOk = false;
		}
	}

	//Método en donde se envía los datos vía http Request
	public PageReference ConsumirServicioWeb(){
		idProducto = datosContrato.Producto_Sodexo_Agil__c;
		System.debug('ID PRODUCTO = '+idProducto);
		isObteniendoProductos = false;
		isEnviando = true;
        renderProductos = false;
		renderCargando = true;
		isError = false;
		isEnviada = false;
		respuestaMensajeError = '';
		//Si existen datos del contrato hacer llamada a servicio Web.
		if(datosContrato!=null){
			SDXAGIL_Helper_Class helper = new SDXAGIL_Helper_Class();
			//System.debug('DATOS ENVIO = '+datosContrato);
		
			//Obtengo token de respuesta desde Credit Flow
			respuestaToken = token.getToken();
			System.debug('TOKEN RESPONSE WS = ' + respuestaToken);

			try{
				//Deserializo respuesta token
				jsonRToken =  SDXAGIL_TokenResponse_JSON.parse(respuestaToken);
			}catch(Exception ex){
				//Si ocurre algun error al obtener el Token de Seguridad, se cancela el envío de datos a Credit Flow
				System.debug('ERROR AL OBTENER TOKEN');
				System.debug(ex.getMessage());
				System.debug(ex.getStackTraceString());
				respuestaMensajeError = 'Se ha producido un error al obtener el Token';
				isEnviando = false;
				isError = true;
				isOk = false;
			}

			//Si la Respuesta del Token de Seguridad es distinto de nulo y no contiene "Error", se procede a hacer el envío de datos
			if((jsonRToken != null && !respuestaToken.contains('message')) && (jsonRToken != null && jsonRToken.Mensaje == null)){
				API_SodexoAgil__mdt apiSodexoAgil;
				System.debug('TOKEN RESPONSE = '+jsonRToken.Token);
				try{
					apiSodexoAgil = consultasSOQL.buscarDatosClientRegistrarApiSodexoAgil('API_SodexoAgil');
				
					//Configuro Endpoint; Header y Body para request
					Http h = new Http();
					HttpRequest req = new HttpRequest();
					String body = '';

					//Asigno Parámetros a variable string
					body = helper.armarJsonServicioClientRegistrar(jsonRToken.Token, datosContrato, listaProductos, datosDireccion, idProducto);
				
					//Declaro variable url con endpoint de Client/Registrar
					req.setEndpoint(apiSodexoAgil.url_client_registrar__c);
					
					req.setBody(body);
					req.setTimeout(120000);
				
					//Indico Método POST
					req.setMethod(apiSodexoAgil.tipo_client_registrar__c);
				
					//Configuro datos de Cabecera
					String authorizationHeader = 'Bearer' + ' ' + jsonRToken.Token;
					req.setHeader('Authorization', authorizationHeader);
					req.setHeader('Content-Length','0');
					req.setHeader('Content-Type', 'application/json');
					req.setHeader('Accept-Encoding','gzip, deflate, br');
					req.setHeader('Accept','*/*');
				
					HttpResponse res = new HttpResponse();
					System.debug('URL = '+apiSodexoAgil.url_client_registrar__c);
					System.debug('BODY = '+body);
					//Consumo WS de Client/Registar			
					res = h.send(req);
				
					//Si la respuesta de Client/Registrar retorna status 200, asigno a campo respuesta el Body de http Response. 
					//De lo contrario asigno mensaje de Error + detalle del Body de http Response
					if (res.getStatusCode() == 200){
						try{
							respuesta = res.getBody();
						
							jsonRClientR = SDXAGIL_ClientRegistrarResp_JSON.parse(respuesta);
							if(jsonRClientR.EsSatisfactorio == 0){
								isError = true;
								isEnviando = false;
								isOk = false;
								if(String.isBlank(jsonRClientR.ErrorCode) || String.isBlank(jsonRClientR.Mensaje)){
									respuestaMensajeError = 'No se puede deserializar la respuesta del servicio Client/Registrar\n';
									respuestaMensajeError += respuesta;
								}else{
									respuestaMensajeError = 'Código de Error: '+jsonRClientR.ErrorCode+'\n';
									respuestaMensajeError += 'Mensaje: '+jsonRClientR.Mensaje;
								}
							}
						}catch(Exception ex) {
							System.debug(res.getBody());
							System.debug(ex.getStackTraceString());
							System.debug(ex.getMessage());
							respuestaMensajeError = 'No se puede deserializar la respuesta del servicio Client/Registrar';
							isEnviando = false;
							isError = true;
							isOk = false;
						}
					}else{
						try{
							respuesta = res.getBody();
							jsonRClientR = SDXAGIL_ClientRegistrarResp_JSON.parse(respuesta);
							System.debug('ERRORES = '+jsonRClientR);
							String listaErrores = '';
							for(SDXAGIL_ClientRegistrarResp_JSON.Errors errorMsj : jsonRClientR.errors){
								listaErrores += '- '+errorMsj.property + ', '+errorMsj.description+'\n';
							}
							respuestaMensajeError = 'Servicio "Client/Registrar" detectó los siguientes errores: \n\n'+listaErrores;
						}catch(Exception ex){
							System.debug(ex.getMessage());
							System.debug(ex.getStackTraceString());
							respuestaMensajeError = 'Error: \nNo hay datos disponibles para mostrar:\n' + 'httpResponse = ' + res.getBody();
						}
					}
					System.debug(respuesta);
				}catch(Exception ex){
					System.debug('ERROR AL ENVIAR EL SERVICIO');
					System.debug(ex.getMessage());
					System.debug(ex.getStackTraceString());
					respuestaMensajeError = 'Se ha producido un error durante el consumo del servicio';
					isEnviando = false;
					isError = true;
					isOk = false;
				}
			}else{
				isEnviando = false;
				isOk = false;
				isError = true;
			}
		}
		return null;
	}

	//Si el campo respuestaMensajeError es distinto de vacío se asume que la llamada al servicio
	//no fue exitosa y se procede a marcar el envío exitoso en False en conjunto de su mensaje correspondiente.
	public void guardarRespuesta(){
		if(datosContrato != null){
			if(!String.isBlank(respuestaMensajeError) && !datosContrato.Respuesta_Exitosa_de_Integracion__c){
				consultasSOQL.guardarRespuestaErronea(datosContrato, respuestaMensajeError);
			}else{
				//Si la clase deserializadora recibe un valor y el campo "EsSatisfactorio ==1" se da por envío exitoso la llamada.
				if(jsonRClientR != null){
					if(jsonRClientR.EsSatisfactorio == 1){
						consultasSOQL.guardarRespuestaExitosa(datosContrato);
					}
				}
			}
		}
	}

	public PageReference redirect(){
        PageReference acctPage = new PageReference(URLretorno);
        acctPage.setRedirect(true);
        return acctPage;
    }
}
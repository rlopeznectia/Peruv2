/****************************
  Desarrollado por: Nectia
  Autor: Rodrigo López (RL)
  Proyecto: Sodexo AGIL
  Descripción: Clase para consumo servicio "Token" de API Sodexo Agil
 
  ---------------------------------------------------------------------------------
  No. Fecha                Autor                     Descripción
  ------ ---------- ---------------------------------------------------------------
  1.0 08-04-2021            RL                   Creación de Clase.
 *****************************/
 
 public class SDXAGIL_TokenResponse_Class  {
	public String respuestaToken { get; set; }

	public SDXAGIL_TokenResponse_Class(){
		
	}

	public String getToken(){
		//Obtengo credenciales de acceso desde la metadata configurada en Salesforce
		API_SodexoAgil__mdt apiSodexoAgil;
		SDXAGIL_ConsultasSOQL consultasSOQL = new SDXAGIL_ConsultasSOQL();
		SDXAGIL_Helper_Class helper = new SDXAGIL_Helper_Class();

		try{
			//Consulto por los datos de la metadata para obtener Token
			apiSodexoAgil =  consultasSOQL.buscarDatosTokenApiSodexoAgil('API_SodexoAgil');
			
			//Configuro Endpoint, Header y Body para request
			Http h = new Http();
			HttpRequest req = new HttpRequest();
			
			String body = '';
			//Armo estructura JSON para consumo de Token
			body = helper.armarJsonToken(apiSodexoAgil.username_token__c, apiSodexoAgil.password_token__c);
			
			//Declaro variable url
			req.setEndpoint(apiSodexoAgil.url_token__c);
			
			//Asigno estructura JSON en Body
			req.setBody(body);
			req.setTimeout(120000);

			//Indico Método POST
			req.setMethod(apiSodexoAgil.tipo_token__c);

			//Configuro datos de Cabecera
			req.setHeader('Content-Length','0');
			req.setHeader('Content-Type', 'application/json');
			HttpResponse res = new HttpResponse();

			//Consumo WS de Token
			res = h.send(req);
			
			//Si la respuesta de Token retorna status 200, asigno a campo respuesta el Body de http Response. 
			//De lo contrario asigno mensaje de Error + detalle del Body de http Response
			if (res.getStatusCode() == 200) {
				respuestaToken = res.getBody();
				return respuestaToken;
			}else{
				respuestaToken = 'Error: \nSin datos disponibles para mostrar:</br>' + 'httpResponse = ' + res.getBody();
			}
		}
		catch(Exception ex){
			respuestaToken = 'Error: \nSin datos disponibles para mostrar:</br> ' + ex.getMessage();
			System.debug(ex.getStackTraceString());
			System.debug(ex.getMessage());
		}
		System.debug('RESPUESTA = \n'+respuestaToken);
		return respuestaToken;
	}
}
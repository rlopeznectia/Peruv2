/****************************
  Desarrollado por: Nectia
  Autor: Rodrigo López (RL)
  Proyecto: Sodexo AGIL
  Descripción: Clase Mock para pruebas de Servicio Web
 
  ---------------------------------------------------------------------------------
  No. Fecha                Autor                     Descripción
  ------ ---------- ---------------------------------------------------------------
  1.0 13-04-2021            RL                   Creación de Clase.
 *****************************/

@isTest
global class SDXAGIL_MockHttpResponseTokenError implements HTTPCalloutMock {
	global HTTPResponse respond (HTTPRequest req) {
		HttpResponse res = new HttpResponse();
		String body;
		body = 'Error';
		res.setStatusCode(400);
		res.setBody(body);
	
		return res;
        
	}
}
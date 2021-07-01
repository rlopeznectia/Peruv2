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
global class SDXAGIL_MockHttpResponseGenerator001 implements HTTPCalloutMock {
	global HTTPResponse respond (HTTPRequest req) {
        HttpResponse res = new HttpResponse();

        String body;
		if(req.getEndpoint() == 'http://159.138.115.224/newsodexoagilapi/api/authenticate/login'){
			body = '{"UserId": null,"Token": "_1ieWuNZ-OeudEwEgyfNLxz1PhloZXmTIvsYOZT0EQQ=","Mensaje": null}';
			res.setStatusCode(200);
			res.setBody(body);
        }

		//Condición para Error 001
		if(req.getEndpoint() == 'http://159.138.115.224/newsodexoagilapi/api/client/registrar'){
			body = '{"EsSatisfactorio": 0,"ErrorCode": "001","Mensaje": "El número de RUC ya existe."}';
			res.setStatusCode(200);
			res.setBody(body);
        }

		return res;
    }
}
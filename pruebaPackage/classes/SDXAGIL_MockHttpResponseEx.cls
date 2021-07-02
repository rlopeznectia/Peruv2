/****************************
  Desarrollado por: Nectia
  Autor: Rodrigo López (RL)
  Proyecto: Sodexo AGIL
  Descripción: Clase Mock para pruebas de Servicio Web
 
  ---------------------------------------------------------------------------------
  No. Fecha                Autor                     Descripción
  ------ ---------- ---------------------------------------------------------------
  1.0 15-04-2021            RL                   Creación de Clase.
 *****************************/

@isTest
global class SDXAGIL_MockHttpResponseEx implements HTTPCalloutMock {
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
			body = 'Test';
			res.setStatusCode(200);
			res.setBody(body);
        }

		//if(req.getEndpoint().contains('Error2')){
			//body = '{"IdProposta":0, "message":"Error 011 - There is an open proposal for this client"}';
			//res.setStatusCode(200);
			//res.setBody(body);
        //}

		//if(req.getEndpoint().contains('Error3')){
			//body = 'Error';
			//res.setStatusCode(400);
			//res.setBody(body);
        //}

		//if(req.getEndpoint().contains('NombreOportunidad=GenerFlex+-+Agrosuper+-+Prueba+Agosto+Test')){
			//body = '{"IdProposta":139,"message":"Sucesso"}';
			//res.setStatusCode(200);
			//res.setBody(body);
		//}
		return res;
        
    }
}
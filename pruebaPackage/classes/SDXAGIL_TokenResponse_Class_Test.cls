/****************************
  Desarrollado por: Nectia
  Autor: Rodrigo López (RL)
  Proyecto: Sodexo AGIL
  Descripción: Clase Test de SDXAGIL_TokenResponse_Class y SDXAGIL_TokenResponse_JSON
 
  ---------------------------------------------------------------------------------
  No. Fecha                Autor                     Descripción
  ------ ---------- ---------------------------------------------------------------
  1.0 13-04-2021            RL                   Creación de Clase.
 *****************************/

@isTest
public class SDXAGIL_TokenResponse_Class_Test  {
	
	//Método para subir % de cobertura de clase Deserializadora
    static testmethod void test_TokenResponse_Class_Test1() {
		Test.startTest();
        SDXAGIL_TokenResponse_JSON jsonR = new SDXAGIL_TokenResponse_JSON();
        jsonR.UserId = 'TEST';
		jsonR.Token = 'TEST';
		jsonR.Mensaje = 'TEST';

		System.assert(jsonR.Token == 'TEST',true);

		Test.stopTest();      
    }

	//Método para subir % para clase SDXAGIL_TokenResponse_Class - Test de Camino Feliz
	static testmethod void test_TokenResponse_Class_Test2() {
		Test.startTest();
		
		Test.setMock(HttpCalloutMock.class, new SDXAGIL_MockHttpResponseGenerator());
		
		SDXAGIL_TokenResponse_Class tokenRClass = new SDXAGIL_TokenResponse_Class();

		String respuesta = tokenRClass.getToken();

		SDXAGIL_TokenResponse_JSON jsonR = SDXAGIL_TokenResponse_JSON.parse(respuesta);
		
		System.assert(jsonR.Token != null, true);

		Test.stopTest();
	}

	//Método para subir % para clase SDXAGIL_TokenResponse_Class - Test de Error
	static testmethod void test_TokenResponse_Class_Test3() {
		Test.startTest();
		
		Test.setMock(HttpCalloutMock.class, new SDXAGIL_MockHttpResponseTokenError());
		
		SDXAGIL_TokenResponse_Class tokenRClass = new SDXAGIL_TokenResponse_Class();

		String respuesta = tokenRClass.getToken();
		
		System.assert(respuesta.contains('Error'), true);

		Test.stopTest();
	}

	//Método para subir % para clase SDXAGIL_TokenResponse_Class - Test de Error
	static testmethod void test_TokenResponse_Class_Test4() {
		Test.startTest();
	
		SDXAGIL_TokenResponse_Class tokenRClass = new SDXAGIL_TokenResponse_Class();

		String respuesta = tokenRClass.getToken();
		
		System.assert(respuesta.contains('Error'), true);

		Test.stopTest();
	}
}
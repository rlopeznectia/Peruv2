/****************************
  Desarrollado por: Nectia
  Autor: Rodrigo López (RL)
  Proyecto: Sodexo AGIL
  Descripción: Clase Modelo para ejecución de consultas SOQL y operaciones DML
 
  ---------------------------------------------------------------------------------
  No. Fecha                Autor                     Descripción
  ------ ---------- ---------------------------------------------------------------
  1.0 08-04-2021            RL                   Creación de Clase.
  1.1 03-05-2021			RL					 Se modifica SOQL Query de método buscarDatosContrato y se agrega método para listar productos
  1.2 24-05-2021			RL					 Se agrega a SOQL Query campo relacionado SBQQ__Product__r.Name en base al último mapeo de datos para método "buscarProductos"
 *****************************/

public class SDXAGIL_ConsultasSOQL  {
	
	public SDXAGIL_ConsultasSOQL(){
	}

	//public static API_SodexoAgil__mdt apiSodexoAgil { 
		//get {
			//if ( apiSodexoAgil == null )
				//apiSodexoAgil = [SELECT url_client_registrar__c, tipo_client_registrar__c 
									//FROM API_SodexoAgil__mdt WHERE MasterLabel = 'API_SodexoAgil']; 
			//return apiSodexoAgil;
		//} set; }

	//public static API_SodexoAgil__mdt apiSodexoAgilToken { 
		//get {
			//if ( apiSodexoAgilToken == null )
				//apiSodexoAgilToken = [SELECT url_token__c, username_token__c, 
									  //password_token__c, tipo_token__c 
									  //FROM API_SodexoAgil__mdt WHERE MasterLabel = 'API_SodexoAgil']; 
			//return apiSodexoAgilToken;
		//} set; }

	//public static SodexoAgil_ProductsCheck__mdt prodCheck { 
		//get {
			//if ( prodCheck == null )
				//prodCheck = [SELECT activo__c 
							 //FROM SodexoAgil_ProductsCheck__mdt WHERE MasterLabel = 'FOOD_TAR']; 
			//return prodCheck;
		//} set; }

	//SOQL Query para buscar los datos de Contrato
	public Contract buscarDatosContrato(String idContrato){
		try{
			System.debug('ID Contrato = '+idContrato);
			Contract datosContrato2 = [SELECT Id, Name, 
									  Account.SDX_Tipo_de_documento__c, Account.SDX_Numero_de_documento__c,
									  Account.Name, Account.SDX_Nombre_Comercial__c,
									  Account.Parent.Name, Account.Phone,
									  SBQQ__Opportunity__r.Email_Pedidos__c,  Account.Correo_Facturacion__c,
									  Account.Correo_Facturacion_Adicional__c, Owner.SDX_DNI__c,
									  CustomerSignedDate, Account.Owner.Name,
									  SBQQ__Opportunity__c, SBQQ__Quote__c,
									  Account.Es_Internacional__c, SBQQ__Opportunity__r.Owner.Name,
									  SBQQ__Quote__r.Vigencia__c,
									  Status, Respuesta_Exitosa_de_Integracion__c,
									  AccountId, Producto_Sodexo_Agil__c,
									  SBQQ__Quote__r.Dias_de_Credito__c, Comision_Pedido__c,
									  StartDate, EndDate
									  FROM Contract];
			System.debug('Contrato Result 1 '+datosContrato2);
			//if(idContrato == null){
				//idContrato = String.valueOf(contractId);
			//}
			Contract datosContrato = [SELECT Id, Name, 
									  Account.SDX_Tipo_de_documento__c, Account.SDX_Numero_de_documento__c,
									  Account.Name, Account.SDX_Nombre_Comercial__c,
									  Account.Parent.Name, Account.Phone,
									  SBQQ__Opportunity__r.Email_Pedidos__c,  Account.Correo_Facturacion__c,
									  Account.Correo_Facturacion_Adicional__c, Owner.SDX_DNI__c,
									  CustomerSignedDate, Account.Owner.Name,
									  SBQQ__Opportunity__c, SBQQ__Quote__c,
									  Account.Es_Internacional__c, SBQQ__Opportunity__r.Owner.Name,
									  SBQQ__Quote__r.Vigencia__c,
									  Status, Respuesta_Exitosa_de_Integracion__c,
									  AccountId, Producto_Sodexo_Agil__c,
									  SBQQ__Quote__r.Dias_de_Credito__c, Comision_Pedido__c,
									  StartDate, EndDate
									  FROM Contract
									  WHERE Id = :idContrato];
			System.debug('Contrato Result 2 '+datosContrato2);
			return datosContrato;
		}catch(Exception ex){
			System.debug('ERROR AL EJECUTAR SOQL');
			System.debug(ex.getMessage());
			System.debug(ex.getStackTraceString());
			return null;
		}
	}

	//SOQL Query para buscar los datos de Contrato
	public List<SBQQ__QuoteLine__c> buscarProductos(String idQuote){
		//try{
		List<SBQQ__QuoteLine__c> datosProductos = [SELECT Id, Name,
													SBQQ__ProductCode__c, SBQQ__NetTotal__c, 
													Precio_Negociado__c, SBQQ__Product__r.Name,
													SBQQ__Product__r.ProductCode
													FROM SBQQ__QuoteLine__c
												 	WHERE SBQQ__Quote__c = :idQuote];
													//AND SBQQ__Product__r.SBQQ__Component__c = false];
		return datosProductos;
		//}catch(Exception ex){
			//return null;
		//}
	}

	//SOQL Query para buscar dirección/es de la cuenta que sean del tipo principal
	public List<SDX_Direccion__c> buscarDireccion(String idCuenta){
		//try{
		List<SDX_Direccion__c> datosDireccion = [SELECT Id, Name,
													SDX_Departamento__c, SDX_Provincia__c,
													Calle__c, SDX_Numero__c,
													SDX_Dpto_Oficina__c, Distrito__r.Name 
													FROM SDX_Direccion__c
													WHERE Cuenta__c =: idCuenta
													AND Principal__c = true];
		return datosDireccion;
		//}catch(Exception ex){
			//return null;
		//}
	}

	//Retorna datos del Endpoint, Usuario, Password y Tipo para el consumo de datos del Token
	Public API_SodexoAgil__mdt buscarDatosTokenApiSodexoAgil(String nombreMdt){
		API_SodexoAgil__mdt apiSodexoAgilToken;
		apiSodexoAgilToken = [SELECT url_token__c, username_token__c, 
						password_token__c, tipo_token__c 
						FROM API_SodexoAgil__mdt 
						WHERE DeveloperName =: nombreMdt];
		return apiSodexoAgilToken;
	}

	//Retorna datos del Endpoint y Tipo para el servicio Client/Registrar
	public API_SodexoAgil__mdt buscarDatosClientRegistrarApiSodexoAgil(String nombreMdt){
		API_SodexoAgil__mdt apiSodexoAgil;
		apiSodexoAgil = [SELECT url_client_registrar__c, tipo_client_registrar__c 
						FROM API_SodexoAgil__mdt 
						WHERE DeveloperName =: nombreMdt];
		return apiSodexoAgil;
	}

    //Retorna lista de productos autorizados para consumir en WS Client/Registrar
	public Boolean checkProductosEnvioWs(List<String> productos){
		List<SodexoAgil_ProductsCheck__mdt> prodCheck;
		Boolean productoAutorizado = false;

		prodCheck = [SELECT Id, activo__c
					 FROM SodexoAgil_ProductsCheck__mdt 
					 WHERE label in : productos
					 AND activo__c = true];

		if(prodCheck.size() > 0){
			productoAutorizado = true;
		}
		
		return productoAutorizado;
	}

	//Actualiza registro de Contrato indicando que no hubo respuesta exitosa del servicio.
	//Se agrega también el error de la llamada
	public void guardarRespuestaErronea(Contract datosContrato, String mensaje){
		System.debug('Mensaje = '+ mensaje);
		datosContrato.Respuesta_Exitosa_de_Integracion__c = false;
		datosContrato.Mensaje_de_Integracion__c = mensaje;
		update datosContrato;
	}

	//Actualiza registro de Contrato indicando que la respuesta fue exitosa.
	public void guardarRespuestaExitosa(Contract datosContrato){
		datosContrato.Respuesta_Exitosa_de_Integracion__c = true;
		datosContrato.Fecha_y_hora_ingreso_SodexoAgil__c = Datetime.now();
		datosContrato.Status = 'In Approval Process';
		datosContrato.Mensaje_de_Integracion__c = '';
		update datosContrato;
	}
}
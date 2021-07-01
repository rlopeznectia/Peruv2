/****************************
  Desarrollado por: Nectia
  Autor: Rodrigo López (RL)
  Proyecto: Sodexo AGIL
  Descripción: Clase para "Helper" para apoyo a Clases de Integración
 
  ---------------------------------------------------------------------------------
  No. Fecha                Autor                     Descripción
  ------ ---------- ---------------------------------------------------------------
  1.0 08-04-2021            RL                   Creación de Clase.
  1.1 24-05-2021			RL					 Se modifica método para crear estructura JSON en sección Acuerdos
 *****************************/

public class SDXAGIL_Helper_Class  {

	public SDXAGIL_Helper_Class(){
	}

	//Método para armar estructura JSON de consumo de servicio login
	public String armarJsonToken(String username, String password){
		String jsonString = '';
		jsonString = '{\n';
		jsonString += '	"Username": "'+username+'",\n';
		jsonString += '	"Password": "'+password+'"\n';
		jsonString += '}';
		return jsonString;
	}

	//Método para armar estructura JSON de consumo de servicio Client/Registrar
	public String armarJsonServicioClientRegistrar(String token, Contract datosContrato, List<SBQQ__QuoteLine__c> listaProductos, List<SDX_Direccion__c> datosDireccion, String idProducto){
		String jsonString = '';
		String esInternacional = '';
		String lineaCredito = '';
		String calle = '';
		String distrito = '';
		SDX_Direccion__c direccion = new SDX_Direccion__c();

		if(datosContrato.Account.Es_Internacional__c){
			esInternacional = 'S';
		}else{
			esInternacional = 'N';
		}

		if(datosContrato.SBQQ__Quote__r.Dias_de_Credito__c > 0){
			lineaCredito = 'S';
		}else{
			lineaCredito = 'N';
		}

		//Si se da el caso de existir más de una dirección principal para una Cuenta 
		//Se fuerza a usar el primer registro con break;
		for(SDX_Direccion__c dir : datosDireccion){
			direccion.Id = dir.Id;
			direccion.Name = dir.Name;
			direccion.SDX_Departamento__c = dir.SDX_Departamento__c;
			direccion.SDX_Provincia__c = dir.SDX_Provincia__c;
			direccion.Calle__c = dir.Calle__c; 
			direccion.SDX_Numero__c = dir.SDX_Numero__c;
			direccion.SDX_Dpto_Oficina__c =  dir.SDX_Dpto_Oficina__c;
			distrito = dir.Distrito__r.Name;
			if(String.isBlank(direccion.SDX_Dpto_Oficina__c)){
				calle = direccion.Calle__c + ' ' + direccion.SDX_Numero__c;
			}else{
				calle = direccion.Calle__c + ' ' + direccion.SDX_Numero__c + ', Dpto/Oficina ' +direccion.SDX_Dpto_Oficina__c;
			}
			break;
		}
		
		jsonString = '{\n';
		jsonString += '   "TipoDocumento":"'+datosContrato.Account.SDX_Tipo_de_documento__c+'",\n';
		
		if(datosContrato.Account.SDX_Tipo_de_documento__c == 'RUC'){
			if(datosContrato.Account.SDX_Numero_de_documento__c.length() > 11){
				jsonString += '   "NumeroDocumento":"'+datosContrato.Account.SDX_Numero_de_documento__c.substring(0,11)+'",\n';
			}else{
				jsonString += '   "NumeroDocumento":"'+datosContrato.Account.SDX_Numero_de_documento__c+'",\n';
			}
		}else{
			if(datosContrato.Account.SDX_Numero_de_documento__c.length() > 8){
				jsonString += '   "NumeroDocumento":"'+datosContrato.Account.SDX_Numero_de_documento__c.substring(0,8)+'",\n';
			}else{
				jsonString += '   "NumeroDocumento":"'+datosContrato.Account.SDX_Numero_de_documento__c+'",\n';
			}
		}

		if(datosContrato.Account.Name.length() > 100){
			jsonString += '   "RazonSocial":"'+datosContrato.Account.Name.substring(0,100)+'",\n';
		}else{
			jsonString += '   "RazonSocial":"'+datosContrato.Account.Name+'",\n';
		}
		if(datosContrato.Account.SDX_Nombre_Comercial__c.length() > 23){
			jsonString += '   "NombreComercial":"'+datosContrato.Account.SDX_Nombre_Comercial__c.substring(0,23)+'",\n';
		}else{
			jsonString += '   "NombreComercial":"'+datosContrato.Account.SDX_Nombre_Comercial__c+'",\n';
		}
		
		if(String.isBlank(datosContrato.Account.Parent.Name) || datosContrato.Account.Parent.Name == null){
			jsonString += '   "GrupoEmpresarial":null,\n';
		}else{
			if(datosContrato.Account.Parent.Name.length() > 23){
				jsonString += '   "GrupoEmpresarial":"'+datosContrato.Account.Parent.Name.substring(0,23)+'",\n';
			}else{
				jsonString += '   "GrupoEmpresarial":"'+datosContrato.Account.Parent.Name+'",\n';
			}
		}

		jsonString += '   "Telefono":"'+datosContrato.Account.Phone+'",\n';
		
		jsonString += '   "Correo":{\n';
		jsonString += '      "Pedido":"'+datosContrato.SBQQ__Opportunity__r.Email_Pedidos__c+'",\n';

		jsonString += '      "Facturacion":"'+datosContrato.Account.Correo_Facturacion__c+'",\n';
		
		if(String.isBlank(datosContrato.Account.Correo_Facturacion_Adicional__c) || datosContrato.Account.Correo_Facturacion_Adicional__c == null){
			jsonString += '      "FacturacionAlterno":null\n';	
		}else{
			jsonString += '      "FacturacionAlterno":"'+datosContrato.Account.Correo_Facturacion_Adicional__c+'"\n';
		}
		jsonString += '   },\n';
	
		jsonString += '   "Ubicacion":{\n';
		jsonString += '      "Departamento":"'+direccion.SDX_Departamento__c+'",\n';
		jsonString += '      "Provincia":"'+direccion.SDX_Provincia__c+'",\n';
				
		jsonString += '      "Distrito":"'+distrito+'",\n';
		
		if(calle.length() > 200){
			jsonString += '      "Direccion":"'+calle.substring(0,200)+'"\n';
		}else{
			jsonString += '      "Direccion":"'+calle+'"\n';
		}
		jsonString += '   },\n';
		
		jsonString += '   "EsInternacional":"'+esInternacional+'",\n';
		if(datosContrato.Owner.SDX_DNI__c.length() > 8){
			jsonString += '   "EjecutivoComercialDNI":"'+datosContrato.Owner.SDX_DNI__c.subString(0,8)+'",\n';
		}else{
			jsonString += '   "EjecutivoComercialDNI":"'+datosContrato.Owner.SDX_DNI__c+'",\n';
		}
		
		jsonString += '   "Contratos":[\n';
		jsonString += '		{\n';
		jsonString += '			"IdProducto":'+datosContrato.Producto_Sodexo_Agil__c+',\n';
		jsonString += '			"LineaCredito":"'+lineaCredito+'",\n';
		jsonString += '			"MesesVigenciaPlastico":'+datosContrato.SBQQ__Quote__r.Vigencia__c+',\n';
		//String fechaFirma = Datetime.newInstance(datosContrato.CustomerSignedDate.year(), datosContrato.CustomerSignedDate.month(), datosContrato.CustomerSignedDate.day()).format('dd-MM-yyyy').replace('-','/');
		String fechaInicio = Datetime.newInstance(datosContrato.StartDate.year(),datosContrato.StartDate.month(), datosContrato.StartDate.day()).format('dd-MM-yyyy').replace('-','/');
		String fechaTermino = Datetime.newInstance(datosContrato.EndDate.year(),datosContrato.EndDate.month(), datosContrato.EndDate.day()).format('dd-MM-yyyy').replace('-','/');
		//jsonString += '			"FechaFirma":"'+fechaFirma+'",\n';
		//jsonString += '			"FechaFirma":null,\n';
		jsonString += '			"FechaInicioContrato":"'+fechaInicio+'",\n';
		jsonString += '			"FechaFinContrato":"'+fechaTermino+'",\n';
		jsonString += '			"Acuerdos":{\n';
		String jsonAcuerdos = '';

		Boolean existeComisionCliente = false;
		Boolean existePrecioEmision = false;
		Boolean existePuntoEntregaLima = false;
		Boolean existeEntregaProvincia = false;
		Boolean existeCostoReposicion = false;
		Boolean existeEnvioReposicionLima = false;
		Boolean existeEnvioReposicionProvincia = false;
		Boolean existeCostoMaterializacion = false;

		for(SBQQ__QuoteLine__c producto : listaProductos){
			if(producto.SBQQ__Product__r.Name == 'COMISIÓN CLIENTE'){
				jsonAcuerdos += '			   "ComisionPedido":'+producto.Precio_Negociado__c+',\n';
				existeComisionCliente = true;
			}

			//jsonString += '			   "ComisionContrato":'+datosContrato.Comision_Pedido__c+',\n';
			
			if(producto.SBQQ__Product__r.Name == 'PRECIO DE EMISIÓN'){
				jsonAcuerdos += '			   "CostoEmision":'+producto.SBQQ__NetTotal__c+',\n';
				existePrecioEmision = true;
			}

				//jsonString += '			   "CostoAdicionales": 0,\n';
			
			if(producto.SBQQ__Product__r.Name == 'PUNTO DE ENTREGA EN LIMA'){
				jsonAcuerdos += '			   "CostoEnvioPedidoLima":'+producto.SBQQ__NetTotal__c+',\n';
				existePuntoEntregaLima = true;
			}

			if(producto.SBQQ__Product__r.Name == 'PUNTO DE ENTREGA EN PROVINCIA'){
				jsonAcuerdos += '			   "CostoEnvioPedidoProvincia":'+producto.SBQQ__NetTotal__c+',\n';
				existeEntregaProvincia = true;
			}

				//jsonString += '			   "CostoRenovacion": 0,\n';
			
				//jsonString += '			   "CostoTrasladoSaldo": 0,\n';
			
			if(producto.SBQQ__Product__r.Name == 'COSTO POR REPOSICIÓN'){
				jsonAcuerdos += '			   "CostoReposicion":'+producto.SBQQ__NetTotal__c+',\n';
				existeCostoReposicion = true;
			}

			if(producto.SBQQ__Product__r.Name == 'ENVIO REPOSICIÓN LIMA'){
				jsonAcuerdos += '			   "CostoEnvioReposicionLima":'+producto.SBQQ__NetTotal__c+',\n';
				existeEnvioReposicionLima = true;
			}

			if(producto.SBQQ__Product__r.Name == 'ENVIO REPOSICIÓN PROVINCIA'){
				jsonAcuerdos += '			   "CostoEnvioReposicionProvincia":'+producto.SBQQ__NetTotal__c+',\n';
				existeEnvioReposicionProvincia = true;
			}
			
			if(producto.SBQQ__Product__r.Name == 'COSTO DE MATERIALIZACIÓN'){
				jsonAcuerdos += '			   "CostoMaterializacion":'+producto.SBQQ__NetTotal__c+',\n';
				existeCostoMaterializacion = true;
			}
		}
		if(!existeComisionCliente){
			jsonAcuerdos += '			   "ComisionPedido":0,\n';
		}
		
		if(!existePrecioEmision){
			jsonAcuerdos += '			   "CostoEmision":0,\n';
		}
		
		if(!existePuntoEntregaLima){
			jsonAcuerdos += '			   "CostoEnvioPedidoLima":0,\n';
		}
		
		if(!existeEntregaProvincia){
			jsonAcuerdos += '			   "CostoEnvioPedidoProvincia":0,\n';
		}
		
		if(!existeCostoReposicion){
			jsonAcuerdos += '			   "CostoReposicion":0,\n';
		}
		
		if(!existeEnvioReposicionLima){
			jsonAcuerdos += '			   "CostoEnvioReposicionLima":0,\n';
		}
		
		if(!existeEnvioReposicionProvincia){
			jsonAcuerdos += '			   "CostoEnvioReposicionProvincia":0,\n';
		}
		
		if(!existeCostoMaterializacion){
			jsonAcuerdos += '			   "CostoMaterializacion":0,\n';
		}

		jsonString += +jsonAcuerdos;
		jsonString += '			   "ComisionContrato":'+datosContrato.Comision_Pedido__c+',\n';
		jsonString += '			   "CostoAdicionales": 0,\n';
		jsonString += '			   "CostoRenovacion": 0,\n';
		jsonString += '			   "CostoTrasladoSaldo": 0\n';
		

		jsonString += '			}\n';
		jsonString += '		}\n';
		jsonString += '   ],\n';
		jsonString += '   "NombreUsuario":"'+datosContrato.SBQQ__Opportunity__r.Owner.Name+'"\n';
		jsonString += '}\n';

		return jsonString;
	}

	//Método para revisar que todos los campos necesarios existan antes de armar estructura JSON
	public List<String> revisarCamposObligatorios(Contract datosContrato, List<SBQQ__QuoteLine__c> listaProductos, List<SDX_Direccion__c> datosDireccion, String idProducto){
		String errorMsj = '';
		List<String> listaErrores = new List<String>();
		String calle = '';
		String distrito = '';
		SDX_Direccion__c direccion = new SDX_Direccion__c();

		//Validar que la cuenta tenga al menos 1 dirección marcada como principal
		if(datosDireccion.size() == 0 || datosDireccion == null){
			errorMsj = 'La Cuenta a utilizar debe tener al menos una Dirección Principal relacionada.';
			listaErrores.add(errorMsj);
		}else{
			//Si se da el caso de existir más de una dirección principal para una Cuenta 
			//Se fuerza a usar el primer registro con break;
			for(SDX_Direccion__c dir : datosDireccion){
				direccion.Id = dir.Id;
				direccion.Name = dir.Name;
				direccion.SDX_Departamento__c = dir.SDX_Departamento__c;
				direccion.SDX_Provincia__c = dir.SDX_Provincia__c;
				direccion.Calle__c = dir.Calle__c; 
				direccion.SDX_Numero__c = dir.SDX_Numero__c;
				direccion.SDX_Dpto_Oficina__c =  dir.SDX_Dpto_Oficina__c;
				distrito = dir.Distrito__r.Name;
				break;
			}

			if(direccion.Calle__c == '' || String.isBlank(direccion.Calle__c)){
				errorMsj = 'La Dirección a utilizar debe tener un Nombre de Calle.';
				listaErrores.add(errorMsj);
			}

			if(direccion.SDX_Numero__c == '' || String.isBlank(direccion.SDX_Numero__c)){
				errorMsj = 'La Dirección a utilizar debe tener un N° de Calle.';
				listaErrores.add(errorMsj);
			}

			if(distrito == '' || String.isBlank(distrito)){
				errorMsj = 'La Dirección a utilizar debe tener un Distrito asociado.';
				listaErrores.add(errorMsj);
			}
		}
		
		
		if(datosContrato.Account.SDX_Tipo_de_documento__c == null || String.isBlank(datosContrato.Account.SDX_Tipo_de_documento__c)){
			errorMsj = 'La Cuenta a utilizar debe indicar el Tipo de Documento.';
			listaErrores.add(errorMsj);
		}
		
		if(datosContrato.Account.SDX_Tipo_de_documento__c == 'RUC'){
			if(datosContrato.Account.SDX_Numero_de_documento__c == null || String.isBlank(datosContrato.Account.SDX_Numero_de_documento__c)){
				errorMsj = 'La Cuenta a utilizar debe tener un registrado un RUC.';
				listaErrores.add(errorMsj);
			}else{
				if(datosContrato.Account.SDX_Numero_de_documento__c.length() < 11){
					errorMsj = 'El RUC de la Cuenta asociada debe tener 11 caracteres.';
					listaErrores.add(errorMsj);
				}
			}
		}else{
			if(datosContrato.Account.SDX_Numero_de_documento__c == null || String.isBlank(datosContrato.Account.SDX_Numero_de_documento__c)){
				errorMsj = 'La Cuenta a utilizar debe tener un registrado un Número de Documento.';
				listaErrores.add(errorMsj);
			}else{
				if(datosContrato.Account.SDX_Numero_de_documento__c.length() < 8){
					errorMsj = 'El Número de Documento asociado a la Cuenta debe 8 caracteres.';
					listaErrores.add(errorMsj);
				}
			}
		}

		if(datosContrato.Account.Name == null || String.isBlank(datosContrato.Account.Name)){
			errorMsj = 'La Cuenta a utilizar debe tener un registrado un nombre de Razón Social.';
			listaErrores.add(errorMsj);
		}

		if(datosContrato.Account.SDX_Nombre_Comercial__c == null || String.isBlank(datosContrato.Account.SDX_Nombre_Comercial__c)){
			errorMsj = 'La Cuenta a utilizar debe tener un registrado un Nombre Comercial.';
			listaErrores.add(errorMsj);
		}
		
		if(datosContrato.Account.Phone == null || String.isBlank(datosContrato.Account.Phone)){
			errorMsj = 'La Cuenta a utilizar debe tener un registrado un Teléfono.';
			listaErrores.add(errorMsj);
		}
		
		if(datosContrato.SBQQ__Opportunity__r.Email_Pedidos__c == null || String.isBlank(datosContrato.SBQQ__Opportunity__r.Email_Pedidos__c)){
			errorMsj = 'Debe ingresar un Correo de Pedidos en la Oportunidad.';
			listaErrores.add(errorMsj);
		}
		
		if(datosContrato.Account.Correo_Facturacion__c == null || String.isBlank(datosContrato.Account.Correo_Facturacion__c)){
			errorMsj = 'Debe ingresar un Correo de Facturación en la Cuenta asociada.';
			listaErrores.add(errorMsj);
		}
		
		if(direccion.SDX_Departamento__c == null || String.isBlank(direccion.SDX_Departamento__c)){
			errorMsj = 'Debe ingresar un Departamento en la Dirección Principal relacionada a la Cuenta.';
			listaErrores.add(errorMsj);
		}

		if(direccion.SDX_Provincia__c == null || String.isBlank(direccion.SDX_Provincia__c)){
			errorMsj = 'Debe ingresar una Provincia en la Dirección Principal relacionada a la Cuenta.';
			listaErrores.add(errorMsj);
		}
		
		if(datosContrato.Owner.SDX_DNI__c == null || String.isBlank(datosContrato.Owner.SDX_DNI__c)){
			errorMsj = 'El Ejecutivo Comercial (Owner) debe tener registrado un DNI.';
			listaErrores.add(errorMsj);
		}
		
		if(datosContrato.Producto_Sodexo_Agil__c == null || String.isBlank(datosContrato.Producto_Sodexo_Agil__c)){
			errorMsj = 'Debe seleccionar un Producto Sodexo Agil dentro del Contrato.';
			listaErrores.add(errorMsj);
		}

		if(datosContrato.StartDate == null || String.isBlank(String.valueOf(datosContrato.StartDate))){
			errorMsj = 'Debe indicar Fecha de inicio del Contrato.';
			listaErrores.add(errorMsj);
		}

		if(datosContrato.EndDate == null || String.isBlank(String.valueOf(datosContrato.EndDate))){
			errorMsj = 'Debe indicar Fecha de término dentro del Contrato.';
			listaErrores.add(errorMsj);
		}

		if(datosContrato.Comision_Pedido__c == null || datosContrato.Comision_Pedido__c < 0){
			errorMsj = 'Debe indicar Comisión Pedido dentro del Contrato.';
			listaErrores.add(errorMsj);
		}

		if(datosContrato.SBQQ__Opportunity__r.Owner.Name == null || String.isBlank(datosContrato.SBQQ__Opportunity__r.Owner.Name)){
			errorMsj = 'El Usuario (Owner) debe tener un nombre registrado.';
			listaErrores.add(errorMsj);
		}
		
		if(datosContrato.SBQQ__Quote__c == null || String.isBlank(datosContrato.SBQQ__Quote__c)){
			errorMsj = 'El contrato debe tener una Quote Relacionada.';
			listaErrores.add(errorMsj);
		}else{
			if(datosContrato.SBQQ__Quote__r.Vigencia__c == null || datosContrato.SBQQ__Quote__r.Vigencia__c <= 0){
				errorMsj = 'Debe indicar la Vigencia dentro de la Quote relacionada.';
				listaErrores.add(errorMsj);
			}
			
			if(listaProductos == null || listaProductos.size() == 0){
				errorMsj = 'La Quote relacionada no posee productos relacionados.';
				listaErrores.add(errorMsj);
			}
		}

		return listaErrores;
	}
}
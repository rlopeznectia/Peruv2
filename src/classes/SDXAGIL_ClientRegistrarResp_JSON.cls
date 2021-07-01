public class SDXAGIL_ClientRegistrarResp_JSON {

	public Integer EsSatisfactorio{get;set;}
	public String ErrorCode{get;set;}
	public String Mensaje{get;set;}

	public String message{get;set;}
	public List<Errors> errors{get;set;}

	public class Errors {
		public String property{get;set;}
		public String description{get;set;}
	}
	
	public static SDXAGIL_ClientRegistrarResp_JSON parse(String json) {
		return (SDXAGIL_ClientRegistrarResp_JSON) System.JSON.deserialize(json, SDXAGIL_ClientRegistrarResp_JSON.class);
	}
}
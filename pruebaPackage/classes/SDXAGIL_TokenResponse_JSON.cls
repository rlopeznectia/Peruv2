public class SDXAGIL_TokenResponse_JSON {

	public String UserId{get;set;}
	public String Token{get;set;}
	public String Mensaje{get;set;}
	
	public static SDXAGIL_TokenResponse_JSON parse(String json) {
		return (SDXAGIL_TokenResponse_JSON) System.JSON.deserialize(json, SDXAGIL_TokenResponse_JSON.class);
	}
}
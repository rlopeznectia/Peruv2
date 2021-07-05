public class SDXAGIL_MetadataCoverage  {
	@TestVisible static private Map<String, List<SObject>> MetadataCoverageRecordsMap = new Map<String, List<SObject>>();

	public List<SObject> getMetadataCoverageRecords(String query){
		if(!MetadataCoverageRecordsMap.containsKey(query)){
			MetadataCoverageRecordsMap.put(query, Database.query(query));
		}
		return MetadataCoverageRecordsMap.get(query);
	}
}
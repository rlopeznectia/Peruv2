@isTest 
public class SDXAGIL_MetadataCoverage_Test {

	static testMethod void testMetadataCoverageMethod1() {
		List<SObject> metadataCoverageRecords;

		Test.startTest();
			metadataCoverageRecords = new SDXAGIL_MetadataCoverage().getMetadataCoverageRecords('SELECT MasterLabel FROM API_SodexoAgil__mdt');
		Test.stopTest();

		System.assertEquals([SELECT MasterLabel FROM API_SodexoAgil__mdt].size(), metadataCoverageRecords.size(), 'Ambos Size deben coincidir');
	}

	static testMethod void testMetadataCoverageMethod2() {
		List<SObject> metadataCoverageRecords;

		Test.startTest();
			metadataCoverageRecords = new SDXAGIL_MetadataCoverage().getMetadataCoverageRecords('SELECT MasterLabel FROM SodexoAgil_ProductsCheck__mdt');
		Test.stopTest();

		System.assertEquals([SELECT MasterLabel FROM SodexoAgil_ProductsCheck__mdt].size(), metadataCoverageRecords.size(), 'Ambos Size deben coincidir');
	}

	//Utiity Method
	public static void setMetadata(String query, List<SObject> records){
		SDXAGIL_MetadataCoverage.MetadataCoverageRecordsMap.put(query, records);
	}
}
/*
Este archivo se ha generado y no es el código fuente actual para esta
clase global gestionada.
Este archivo de solo lectura muestra los métodos, las variables, las propiedades
y los constructores globales de la clase.
Para permitir al código compilar, todos los métodos devuelven nulo.
*/
global class ProductConfigurationController {
    global ProductConfigurationController() {

    }
    @RemoteAction
    global static String loadConfiguredProduct(String quoteJSON, Id productId, Integer lineItemKey, List<String> featureOptionalSKUs, String existingConfigJSON, String parentProductJSON) {
        return null;
    }
    global static String loadConfiguredProduct(String quoteJSON, Id productId, List<String> featureOptionalSKUs) {
        return null;
    }
    global static String loadConfiguredProducts(String quoteJSON, List<Id> productIds) {
        return null;
    }
    global static String loadOptionData(String quoteJSON, List<Id> optionIds) {
        return null;
    }
    @RemoteAction
    global static String loadOptionData(String quoteJSON, List<String> featureOptionIds, String fieldSetName) {
        return null;
    }
    global static String loadSearchModelFiltered(String quoteJSON, List<String> filtersJSON) {
        return null;
    }
    @RemoteAction
    global static String loadSearchModelFiltered(String quoteJSON, List<String> filtersJSON, String filterFieldSet) {
        return null;
    }
    @RemoteAction
    global static String saveConfiguration(String quoteJSON, String configJSON, String upgradedAssetId) {
        return null;
    }
    global static String searchLookup(String quoteJSON, String filterValuesJSON) {
        return null;
    }
    global static String searchLookupWithFilters(String quoteJSON, String filterValuesJSON, List<String> filtersJSON) {
        return null;
    }
    global static String searchLookup(String quoteJSON, String filterValuesJSON, List<String> filtersJSON) {
        return null;
    }
    @RemoteAction
    global static String searchLookup(String quoteJSON, String filterFieldSet, String filterValuesJSON, List<String> filtersJSON) {
        return null;
    }
    @RemoteAction
    global static String updateConfiguration(String quoteJSON, String configJSON, String upgradedAssetId) {
        return null;
    }
}

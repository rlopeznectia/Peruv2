/*
Este archivo se ha generado y no es el código fuente actual para esta
clase global gestionada.
Este archivo de solo lectura muestra los métodos, las variables, las propiedades
y los constructores globales de la clase.
Para permitir al código compilar, todos los métodos devuelven nulo.
*/
global interface ProductSearchPlugin {
    String getAdditionalSearchFilters(SObject param0, Map<String,Object> param1);
    String getAdditionalSuggestFilters(SObject param0, Map<String,Object> param1);
    Object getFilterDefaultValue(SObject param0, String param1);
    Object getInputDefaultValue(SObject param0, String param1);
    Boolean isFilterHidden(SObject param0, String param1);
    Boolean isInputHidden(SObject param0, String param1);
    Boolean isSearchCustom(SObject param0, Map<String,Object> param1);
    Boolean isSuggestCustom(SObject param0, Map<String,Object> param1);
    List<PricebookEntry> search(SObject param0, Map<String,Object> param1);
    List<PricebookEntry> suggest(SObject param0, Map<String,Object> param1);
}

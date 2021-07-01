/*
Este archivo se ha generado y no es el código fuente actual para esta
clase global gestionada.
Este archivo de solo lectura muestra los métodos, las variables, las propiedades
y los constructores globales de la clase.
Para permitir al código compilar, todos los métodos devuelven nulo.
*/
global class FieldValueUpdater implements Database.Batchable<SObject> {
    global Schema.SObjectType entityToBeUpdated;
    global List<Schema.SObjectField> fieldsToBeUpdated;
    global String queryToBeUpdated;
    global Map<Schema.SObjectField,String> valuesToBeUpdated;
    global FieldValueUpdater(List<Schema.SObjectField> fieldsToBeUpdated, Schema.SObjectType entityToBeUpdated, Map<Schema.SObjectField,String> valuesToBeUpdated) {

    }
    global void execute(Database.BatchableContext BC, List<SObject> sObjects) {

    }
    global void finish(Database.BatchableContext BC) {

    }
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return null;
    }
}

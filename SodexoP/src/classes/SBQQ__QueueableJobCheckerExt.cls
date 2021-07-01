/*
Este archivo se ha generado y no es el código fuente actual para esta
clase global gestionada.
Este archivo de solo lectura muestra los métodos, las variables, las propiedades
y los constructores globales de la clase.
Para permitir al código compilar, todos los métodos devuelven nulo.
*/
global class QueueableJobCheckerExt {
    global QueueableJobCheckerExt(ApexPages.StandardController controller) {

    }
    global QueueableJobCheckerExt(ApexPages.StandardSetController controller) {

    }
    global static AsyncApexJob checkJobStatus(String recordId, String jobId) {
        return null;
    }
    global static String checkJobStatus(String jobId) {
        return null;
    }
    global Boolean getAutoRefresh() {
        return null;
    }
    global String getClassPrefix() {
        return null;
    }
    global String getJobDetails() {
        return null;
    }
    global String getJobStatus() {
        return null;
    }
    global String getJobStatus(String jobId) {
        return null;
    }
    global static Map<String,Object> getJobStatus(String recordId, String jobId) {
        return null;
    }
    @RemoteAction
    global static Map<String,Object> getJobStatus(String recordId, String jobType, String jobId) {
        return null;
    }
    global String getJobType() {
        return null;
    }
    @RemoteAction
    global static Map<String,Object> getJobsStatuses(List<String> recordIds, String jobType, String asyncJobId) {
        return null;
    }
    global String getQueueableJobId() {
        return null;
    }
    @RemoteAction
    global static Boolean getUncalculatedWithSetting(Id quoteId) {
        return null;
    }
}

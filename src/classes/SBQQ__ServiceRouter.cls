/*
Este archivo se ha generado y no es el código fuente actual para esta
clase global gestionada.
Este archivo de solo lectura muestra los métodos, las variables, las propiedades
y los constructores globales de la clase.
Para permitir al código compilar, todos los métodos devuelven nulo.
*/
@RestResource(urlMapping='/ServiceRouter/*')
global class ServiceRouter {
    @HttpPatch
    global static String load(String context) {
        return null;
    }
    global static String load(String loader, String uid, String context) {
        return null;
    }
    @RemoteAction
    global static String load(String loader, String uid, String context, Boolean includeSPT) {
        return null;
    }
    @HttpGet
    global static String read() {
        return null;
    }
    global static String read(String reader, String uid) {
        return null;
    }
    @RemoteAction
    global static String read(String reader, String uid, Boolean includeSPT) {
        return null;
    }
    @HttpPost
    global static String save(String saver, String model) {
        return null;
    }
    @RemoteAction
    global static String save(String saver, String model, Boolean includeSPT) {
        return null;
    }
}

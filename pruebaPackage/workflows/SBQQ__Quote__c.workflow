<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Estado_Pendiente_de_Aprobaci_n</fullName>
        <description>Cambia la Cotizacion a estado Pendiente de Aprobación</description>
        <field>SBQQ__Status__c</field>
        <literalValue>Sales_approval_pending</literalValue>
        <name>Estado Pendiente de Aprobación</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Estado_a_Aprobada</fullName>
        <field>SBQQ__Status__c</field>
        <literalValue>Sales_Aproved</literalValue>
        <name>Estado a Aprobada</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Estado_a_Pendiente_Aprobaci_n</fullName>
        <field>SBQQ__Status__c</field>
        <literalValue>Sales_approval_pending</literalValue>
        <name>Estado a Pendiente Aprobación</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Estado_a_Rechazado</fullName>
        <field>SBQQ__Status__c</field>
        <literalValue>Sales_Denied</literalValue>
        <name>Estado a Rechazado</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Quote_Aprobado</fullName>
        <field>Quote_Aprobado__c</field>
        <literalValue>1</literalValue>
        <name>Quote Aprobado</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
</Workflow>

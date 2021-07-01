#Get the private key from the environment variable
echo "Logging into Salesforce Org"
echo "Authenticating org"
# DODORIA 
#echo "Conectar DODORIA"
#sfdx auth:jwt:grant --clientid 3MVG9Ccwq.TeycMai5QnOzXW5fUZzNLJyLbXgpcAlGHInayKphJPiC11LbCdYViBppKSSO5Ee3xOiLqRkBjEE --jwtkeyfile JWT/server.key --username consultor_force+amicar@nectia.com.sbxdodoria --instanceurl https://test.salesforce.com
#sfdx auth:jwt:grant --clientid $SFDC_DESA_CLIENTID --jwtkeyfile JWT/server.key --username $SFDC_DESA_USER --instanceurl https://test.salesforce.com
#PRUEBACI
echo "Conectar Sodexo"
sfdx alias:set my-hub-orgUAT2=consultor_force@nectia.com.peru.prod.uat2
sfdx auth:jwt:grant --clientid $SFDC_UAT_CLIENTID --jwtkeyfile JWT/server.key --username $SFDC_UAT_USER --instanceurl https://test.salesforce.com
sfdx alias:set my-hub-Prod=consultor_force@nectia.com.peru.prod
sfdx auth:jwt:grant --clientid $SFDC_PROD_CLIENTID --jwtkeyfile JWT/server.key --username $SFDC_PROD_USER --instanceurl https://login.salesforce.com/

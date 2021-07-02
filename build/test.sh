#sfdx force:auth:web:login -a $SFDC_UAT_USER -r https://test.salesforce.com/ -s
#sfdx force:source:push -u ${CIRCLE_BRANCH}
echo "Conectar Sodexo"
sfdx alias:set my-hub-orgUAT2=consultor_force@nectia.com.peru.prod.uat2
sfdx auth:jwt:grant --clientid $SFDC_UAT_CLIENTID --jwtkeyfile JWT/server.key --username $SFDC_UAT_USER --instanceurl https://test.salesforce.com
sfdx force:org:list
sfdx force:apex:test:run -c -d pruebaPackage -u my-hub-orgUAT2 -w 10 -l RunLocalTests -w 33 --verbose --loglevel fatal
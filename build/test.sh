#sfdx force:auth:web:login -a $SFDC_UAT_USER -r https://test.salesforce.com/ -s
#sfdx force:source:push -u ${CIRCLE_BRANCH}
echo "Conectar Sodexo"
sfdx force:org:list
sfdx force: mdapi:convert -d deploy_prod -r pruebaPackage
sfdx config:set defaultusername=consultor_force@nectia.com.peru.prod.uat2
sfdx force:mdapi:deploy -c -d pruebaPackage -u my-hub-orgUAT2 -w 10 -l RunLocalTests -w 33 --verbose --loglevel fatal

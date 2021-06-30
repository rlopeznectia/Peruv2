# Get the private key from the environment variable
echo "Setting up DevHub Connection..."
echo "Authenticating org"
echo "Conectar UAT2"
sfdx auth:jwt:grant --clientid $SFDC_UAT_CLIENTID --jwtkeyfile JWT/server.key --username $SFDC_UAT_USER --instanceurl https://test.salesforce.com

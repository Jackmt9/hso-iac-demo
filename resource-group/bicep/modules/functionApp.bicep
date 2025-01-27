// import all parameters here
param functionApp object

// Create storage account

module modStorageAccount 'br/public:avm/res/storage/storage-account:0.9.1' = {
  name: 'St-${uniqueString(deployment().name)}'
  params: {
    name: functionApp.storageAccount.name
    allowSharedKeyAccess: false
    publicNetworkAccess: 'Disabled'
    // create a default blob container here
    skuName: 'Standard_LRS'
  }
}

// Create function app

module modFunctionApp '<reference function app in avm module here>' = {
  name: 'Func-${uniqueString(deployment().name)}'
  params: {
    name: functionApp.name
    kind: 'functionapp'
    publicNetworkAccess: 'Enabled'
    serverFarmResourceId: resourceId('Microsoft.Web/serverfarms', functionApp.appServicePlan.name)
    appInsightResourceId: resourceId('Microsoft.Insights/components', applicationInsights.name)
    managedIdentities: {
      systemAssigned: true
    }
    siteConfig: {
      alwaysOn: true
      netFrameworkVersion: 'v6.0'
      use32BitWorkerProcess: true
      cors: {
        allowedOrigins: [
          'https://portal.azure.com'
        ]
        supportCredentials: false
      }
      virtualApplications: [
        {
          virtualPath: '/'
          physicalPath: 'site\\wwwroot'
          preloadEnabled: false
        }
      ]
    }
    clientCertMode: 'Required'
    appSettingsKeyValuePairs: {
      AzureKeyVaultUri: 'https://${keyVault.name}${environment().suffixes.keyvaultDns}/'
      AzureWebJobsStorage__accountname: '${functionApp.storageAccount.name}'
      AzureWebJobsStorage__blobServiceUri: 'https://${functionApp.storageAccount.name}.blob.${environment().suffixes.storage}'
      AzureWebJobsStorage__queueServiceUri: 'https://${functionApp.storageAccount.name}.queue.${environment().suffixes.storage}'
      AzureWebJobsStorage__tableServiceUri: 'https://${functionApp.storageAccount.name}.table.${environment().suffixes.storage}'
      
    }
  }
  // insert depends on statement here (storage account needs to be created first)
}


// Role assignments on storage account for function app: 'Storage Queue Data Contributor', 'Storage Table Data Contributor', 'Storage Account Contributor', 'Storage Blob Data Owner'
module modStorageRoleAssignment '../resources/storage/storage-account/role-assignments/main.hso.bicep' = {
  name: 'St-Role-${uniqueString(deployment().name)}'
  params: {
    name: 
    roleAssignments: [
      {
        roleDefinitionIdOrName: 
        principalId: //prinicpal of function app - use output of modFUnctionApp (modFunctionApp.output....)
      }
    ]
  }
}

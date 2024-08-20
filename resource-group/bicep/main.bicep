// reference all parameters coming from parameter file
param functionApp object
param logAnalytics object
param keyVault object
param appServicePlan object
param applicationInsights object

// Reference all 'modules' from folder below (may need dependsOn Statement)
module modAppServicePlan './modules/appServicePlan.bicep' = {
  name: 'main-asp'
  params: {
    appServicePlan: appServicePlan
  }
}

module modFunctionApp './modules/functionApp.bicep' = {
  name: 'main-func'
  params: { functionApp: functionApp, applicationInsights: applicationInsights, keyVault: keyVault }
  dependsOn: [modKeyVault, modApplicationInsights]
}

module modKeyVault './modules/keyVault.bicep' = {
  name: 'main-kv'
  params: { keyVault: keyVault }
}

module modLogAnalytics './modules/logAnalytics.bicep' = {
  name: 'main-log'
  params: {
    logAnalytics: logAnalytics
  }
}

module modApplicationInsights './modules/appInsights.bicep' = {
  name: 'main-appi'
  params: {
    applicationInsights: applicationInsights
    logAnalytics: logAnalytics
  }
}

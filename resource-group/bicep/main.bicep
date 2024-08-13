// reference all parameters coming from parameter file
param functionApp object


// Reference all 'modules' from folder below (may need dependsOn Statement)
module modKeyVault './modules/key-vault.bicep' = {
  name: 'kv-main-${uniqueString(deployment().name)}'
  params: {
    keyVault: keyVault
  }
}

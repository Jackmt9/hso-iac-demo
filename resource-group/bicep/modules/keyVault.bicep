// import parameters

// Create key vault
module modKeyVault 'referencing avm module' = {
  name: 'Kv-${uniqueString(deployment().name)}'
  params: {
    name: keyVault.name
    sku: keyVault.?sku
    publicNetworkAccess: 'Enabled'
    roleAssignments: // Assign role to function app to read secrets (key vault secret reader)
  }
}

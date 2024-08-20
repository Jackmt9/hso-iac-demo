// import parameters
param keyVault object

// Create key vault
module modKeyVault 'br/public:avm/res/key-vault/vault:0.7.1' = {
  name: 'Kv-${uniqueString(deployment().name)}'
  params: {
    name: keyVault.name
    sku: 'standard'
    publicNetworkAccess: 'Enabled'
  }
}

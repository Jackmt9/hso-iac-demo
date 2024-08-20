param appServicePlan object

module modAppServicePlans 'br/public:avm/res/web/serverfarm:0.2.2' = {
  name: 'asp'
  params: { name: appServicePlan.name, skuCapacity: 1, skuName: 'B1' }
}

// Basic sku

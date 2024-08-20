// import parameters
param applicationInsights object
param logAnalytics object
// Create app insights

module modAppInsights 'br/public:avm/res/insights/component:0.4.0' = {
  name: 'Appi'
  params: {
    name: applicationInsights.name
    workspaceResourceId: resourceId('Microsoft.OperationalInsights/workspaces', logAnalytics.name)
  }
}

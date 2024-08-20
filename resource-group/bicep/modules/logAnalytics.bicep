// import parameters
param logAnalytics object

// Create log analytics workspace
module modLogAnalytics 'br/public:avm/res/operational-insights/workspace:0.5.0' = {
  name: 'log'
  params: { name: logAnalytics.name }
}

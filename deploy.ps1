function Deploy-AzureResources {
    Param (
        [Parameter(Mandatory = $true)]
        [string]$tenantId,
        [Parameter(Mandatory = $true)]
        [string]$subscription,
        [Parameter(Mandatory = $true)]
        [string]$resourceGroup,
        [Parameter(Mandatory = $true)]
        [string]$templateFile,
        [Parameter(Mandatory = $true)]
        [string]$parameterFile
    )

    # Log in to the specified tenant
    Write-Host "Logging in to tenant..."
    az login --tenant $tenantId

    # Set the Azure subscription
    az account set --subscription $subscription

    # Display the current account information
    az account show

    # Create the deployment
    az deployment group create -f $templateFile -g $resourceGroup --parameters $parameterFile
}


$tenantId = '<tenant'
$subscription = '<sub>'
$resourceGroup = '<rg>'
$templateFile = '....main.bicep'
$parameterFile = '...main.parameters-dev.json'

Deploy-AzureResources -tenantId $tenantId -subscription $subscription -resourceGroup $resourceGroup -templateFile $templateFile -parameterFile $parameterFile

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


$tenantId = 'd2a857ff-6cf1-4889-978d-db5ef44bf6fb'
$subscription = '50a11edb-ee9d-49b5-94fc-235600aac576'
$resourceGroup = 'rg-hso-iac-demo'
$templateFile = 'resource-group\bicep\main.bicep'
$parameterFile = 'resource-group\bicep\parameters\main.parameters-dev.json'

Deploy-AzureResources -tenantId $tenantId -subscription $subscription -resourceGroup $resourceGroup -templateFile $templateFile -parameterFile $parameterFile

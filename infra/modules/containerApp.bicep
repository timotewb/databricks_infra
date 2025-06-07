param location string
param project string
param tags {
  *: string
}

param acrName string
param acaEnvironmentName string
param acaMsiName string
@allowed([ '0.25', '0.5', '0.75', '1.0', '1.25', '1.5', '1.75', '2.0' ])
param containerCpu string = '0.25'
@allowed([ '0.5Gi', '1.0Gi', '1.5Gi', '2.0Gi', '2.5Gi', '3.0Gi', '3.5Gi', '4.0Gi' ])
param containerMemory string = '0.5Gi'
param imageTag string

param gitHubAppId string
param gitHubAppInstallationId string
param gitHubAppKeySecretUri string
param gitHubOrganization string

resource acr 'Microsoft.ContainerRegistry/registries@2023-07-01' existing = {
  name: acrName
}

resource acaEnv 'Microsoft.App/managedEnvironments@2023-05-01' existing = {
  name: acaEnvironmentName
}

resource acaMsi 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' existing = {
  name: acaMsiName
}

resource acaApp 'Microsoft.App/containerApps@2023-05-01' = {
  name: 'ca-${project}'
  location: location
  tags: tags
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${acaMsi.id}': {}
    }
  }
  properties: {
    managedEnvironmentId: acaEnv.id
    configuration: {
      activeRevisionsMode: 'Single'
      registries: [
        {
          server: acr.properties.loginServer
          identity: acaMsi.id
        }
      ]
      secrets: [
        {
          name: 'github-app-key'
          keyVaultUrl: gitHubAppKeySecretUri
          identity: acaMsi.id
        }
      ]
    }
    template: {
      containers: [
        {
          name: 'github-runner'
          image: '${acr.properties.loginServer}/runners/github/linux:${imageTag}'
          resources: {
            cpu: json(containerCpu)
            memory: containerMemory
          }
          env: [
            {
              name: 'APP_ID'
              value: gitHubAppId
            }
            {
              name: 'APP_PRIVATE_KEY'
              secretRef: 'github-app-key'
            }
            {
              name: 'RUNNER_SCOPE'
              value: 'org'
            }
            {
              name: 'ORG_NAME'
              value: gitHubOrganization
            }
            {
              // Remove this once https://github.com/microsoft/azure-container-apps/issues/502 is fixed
              name: 'APPSETTING_WEBSITE_SITE_NAME'
              value: 'az-cli-workaround'
            }
            {
              name: 'MSI_CLIENT_ID'
              value: acaMsi.properties.clientId
            }
            {
              name: 'EPHEMERAL'
              value: '1'
            }
            {
              name: 'RUNNER_NAME_PREFIX'
              value: project
            }
          ]
        }
      ]
      scale: {
        rules: [
          {
            name: 'github-runner-scaling-rule'
            custom: {
              type: 'github-runner'
              auth: [
                {
                  triggerParameter: 'appKey'
                  secretRef: 'github-app-key'
                }
              ]
              metadata: {
                owner: gitHubOrganization
                runnerScope: 'org'
                applicationID: gitHubAppId
                installationID: gitHubAppInstallationId
              }
            }
          }
        ]
      }
    }
  }
}

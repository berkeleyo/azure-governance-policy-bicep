
@description('Name for the policy definition')
param policyName string = 'Deny-Public-IP'
@description('Display name for the policy')
param displayName string = 'Deny Public IP on NICs'
@description('Description for the policy')
param description string = 'Prevents NICs from having public IPs attached. Enforces private networking by default.'

resource policy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: policyName
  properties: {
    policyType: 'Custom'
    mode: 'All'
    displayName: displayName
    description: description
    metadata: {
      version: '1.0.0'
      category: 'Network'
    }
    policyRule: {
      if: {
        allOf: [
          { field: 'type', equals: 'Microsoft.Network/networkInterfaces' }
          { field: 'Microsoft.Network/networkInterfaces/ipconfigurations[*].publicIpAddress.id', exists: true }
        ]
      }
      then: { effect: 'deny' }
    }
  }
}

output policyDefinitionId string = policy.id

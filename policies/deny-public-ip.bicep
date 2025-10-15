param policyName string = 'Deny-Public-IP'
@description('Deny public IP on NICs')
resource policy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: policyName
  properties: {
    policyType: 'Custom'
    mode: 'All'
    displayName: 'Deny Public IP on NICs'
    description: 'Prevents NICs from having public IPs attached.'
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

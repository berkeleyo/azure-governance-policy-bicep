targetScope = 'subscription'
resource policy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'deny-public-ip'
  properties:{
    displayName: 'Deny Public IP on NICs'
    mode: 'All'
    policyRule: {
      if: {
        field: 'type'
        equals: 'Microsoft.Network/networkInterfaces'
      }
      then: {
        effect: 'deny'
      }
    }
  }
}

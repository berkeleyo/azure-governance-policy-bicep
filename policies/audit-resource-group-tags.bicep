
@description('Audits required tags at resource group level.')
param requiredTags array = [ 'Owner', 'CostCenter', 'Environment' ]

resource policy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'Audit-Required-RG-Tags'
  properties: {
    policyType: 'Custom'
    mode: 'All'
    displayName: 'Audit required tags on resource groups'
    description: 'Audits Owner/CostCenter/Environment tags on resource groups.'
    metadata: { version: '1.0.0', category: 'Tags' }
    policyRule: {
      if: {
        allOf: [
          { field: 'type', equals: 'Microsoft.Resources/subscriptions/resourceGroups' }
          {
            anyOf: [ for tagName in requiredTags: {
              field: concat('tags[', tagName, ']') 
              exists: false
            } ]
          }
        ]
      }
      then: { effect: 'audit' }
    }
  }
}

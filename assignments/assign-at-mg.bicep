
@description('Management group ID (not display name).')
param managementGroupId string
@description('Policy definition resource ID to assign.')
param policyDefinitionId string
@description('Optional exclusion of resource groups (array of IDs).')
param excludedScopes array = []
@description('Assignment display name.')
param assignmentDisplayName string = 'Deny Public IP on NICs'

resource assignment 'Microsoft.Authorization/policyAssignments@2022-06-01' = {
  name: 'denyPublicIpAssignment'
  scope: tenantResourceId('Microsoft.Management/managementGroups', managementGroupId)
  properties: {
    displayName: assignmentDisplayName
    policyDefinitionId: policyDefinitionId
    enforcementMode: 'Default'
    parameters: {}
    nonComplianceMessages: [
      {
        message: 'Public IPs on NICs are not permitted in this environment.'
      }
    ]
    overrides: []
    scope: null
    notScopes: excludedScopes
  }
}

param managementGroupId string
param policyDefinitionId string
module assignment 'br/public:policyAssignments@1.0.0' = {
  name: 'assign-deny-public-ip'
  params: {
    targetScope: 'managementGroup'
    targetId: managementGroupId
    policyDefinitionId: policyDefinitionId
    parameters: {}
  }
}

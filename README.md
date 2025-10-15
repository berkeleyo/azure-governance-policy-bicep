
# Azure Governance: Policy-as-Code (Bicep)

This repo demonstrates Policy-as-Code with Bicep: 
- A **deny** policy that blocks Public IP attachment to NICs
- An **audit** policy for required **resource group tags**
- An **assignment** module for Management Group scope
- A CI workflow that validates all Bicep files

## Why
Enforce cloud guardrails (least exposure, consistent tagging) early to reduce cost, risk, and drift.

## Prerequisites
- Azure CLI (`az`) and Bicep (`az bicep install`)
- Permissions: Policy Contributor + Resource Policy Contributor at target scope

## Deploy
```bash
# Deploy deny policy at tenant (outputs the policy ID)
az deployment tenant create -l uksouth -f policies/deny-public-ip.bicep -o json > out.json
POLICY_ID=$(jq -r '.properties.outputs.policyDefinitionId.value' out.json)

# Assign to a management group (update MG_ID)
MG_ID="gll-root"
az deployment tenant create -l uksouth -f assignments/assign-at-mg.bicep   -p managementGroupId=$MG_ID policyDefinitionId=$POLICY_ID excludedScopes=[]

# Optional: deploy audit tags policy (no assignment provided here)
az deployment tenant create -l uksouth -f policies/audit-resource-group-tags.bicep
```

## Validate
- Attempt to attach a Public IP to NIC -> **Denied**
- Create a resource group without `Owner` -> **Audited**

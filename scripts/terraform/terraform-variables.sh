#!/bin/sh
echo "Setting environment variables for Terraform"
export ARM_SUBSCRIPTION_ID=eb6659ac-634f-4460-8e5c-c92db0afcabb
export ARM_CLIENT_ID=your_appId
export ARM_CLIENT_SECRET=your_password
export ARM_TENANT_ID=72f988bf-86f1-41af-91ab-2d7cd011db47

# Not needed for public, required for usgovernment, german, china
export ARM_ENVIRONMENT=public

# Azure Kubernetes Service (AKS) DevOps

This is a lab to create a zero downtime scenario for Azure Kubernetes Service (AKS).

## Prerequisties

- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) for Windows or Linux
- [Docker](https://docs.docker.com/install/) for Windows or Linux
- [Terraform](https://www.terraform.io/intro/getting-started/install.html) for Windows or Linux
- [Istio](https://istio.io/docs/setup/kubernetes/download-release/) for Windows or Linux
- Azure CLI
- Windows 10 with WSL

## CI/CD Workflow

![Azure DevOps](./docs/images/devops-workflow.jpg)

## Step 1: Setup an Azure DevOps Project

Azure DevOps Services allows you to easily set up automated pipelines to build, test and deploy your code to any platform. We are going to use Azure DevOps as our default platform. If you don't have an account, you can create one [here](https://azure.microsoft.com/en-us/services/devops/).

![Azure DevOps](./docs/images/devops-project.jpg)

Now you can clone the repository locally:

    git clone https://<organization_name>@dev.azure.com/<organization_name>/<project_name>/_git/<project_name>

## Step 2: Setup Azure Active Directory for AKS authentication

AKS can be configured to use Azure Active Directory (AD) for user authentication. In this configuration, you can log into an AKS cluster using your Azure Active Directory authentication token. If you want to understand more about the authenticaton details you can find more info [here](https://docs.microsoft.com/en-us/azure/aks/aad-integration#authentication-details).

### **Active Directory tenant**

Integration with Active Directory requires a *tenant*. If you don't have an AD tenant, create one through Azure Portal:

![](./docs/images/ad-create.jpg)

Switch to the new directory on Portal, then click on `Azure Active Directory` and make sure it's pointing to the new directory.

![](./docs/images/ad-directory.jpg)

### **Copy your tenant ID**

In the next steps, you'll need to know the tenant ID to provision Active Directory applications. In the Azure Portal, go to your user info and select `Switch directory`. 

![AD directory](./docs/images/ad-switch-directory.jpg)

![AD directory](./docs/images/ad-tenant-id.jpg)

### **Switch to the new tenant on Azure CLI**

Now prepare your Azure CLI to login in the new tenant:

    $ az login -t your_tenant_id --allow-no-subscriptions
    

### **Active Directy applications**

To enable Azure AD authorization for Kubernetes, you need to create two applications: **server** and **client** apps.

![AD authorization](./docs/images/ad-aks.jpg)

- **Server application:** It's a *Web app/API* that will be used to get a users Azure AD group membership. The web app obtains an `access token` for the user, which proves to the web API that the user successfully authenticated to the web app and the web app was able to obtain a delegated user identity to call the web API. This access token is sent in the request to the web API, which authorizes the user and returns the desired resource. For more info about *Web app/API* [here](https://docs.microsoft.com/en-us/azure/active-directory/develop/web-api).

- **Client application:** It's a *native* application that will be used when logging in with the Kubernetes CLI (known as `kubectl`). The client app obtains an `access token` for the user by using the `OAuth 2.0 protocol`. This access token is then sent in the request to the server app (web API), which authorizes the user and returns the desired resource. For more info about *native* apps [here](https://docs.microsoft.com/en-us/azure/active-directory/develop/native-app).

### **Create the server application**

These are the environment variables needed to create the server application:

| Variable | Description
| -------------- | -------------- |
| RBAC_AZURE_TENANT_ID | Paste the tenant ID you copied from the `Copy your tenant ID` section. |
| RBAC_SERVER_APP_NAME | Set your preferred server application name. |
| RBAC_SERVER_APP_URL | Set your application URL based on the application name. |
| RBAC_SERVER_APP_SECRET | Set your preferred application secret. The pre-defined script generates a 32-character hex random secret. |


Access the `scripts/azure-ad` directory and open the `create-server-app.sh` script in your preferred text editor to edit the environment variables:

```bash
    export RBAC_AZURE_TENANT_ID="YOUR_TENANT_ID"
    export RBAC_SERVER_APP_NAME="YOUR_APP_NAME"
    export RBAC_SERVER_APP_URL="http://your_app_name"
    export RBAC_SERVER_APP_SECRET="$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)"
```

Then run the script:

    ./create-server-app.sh

Now open the Azure Portal and search for the server application on Azure `Active Directory -> App registrations -> View all applications -> YOUR_APP_NAME -> Settings -> Required Permissions`. Click on `Grant permissions` button and accept to permissions for your tenant:

![AD grant permissions](./docs/images/ad-grant-permissions.jpg)

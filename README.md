# Azure Kubernetes Service (AKS) DevOps

This is a lab to create a zero downtime scenario for Azure Kubernetes Service (AKS).

## Prerequisties

- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) for Windows or Linux
- [Docker](https://docs.docker.com/install/) for Windows or Linux
- [Terraform](https://www.terraform.io/intro/getting-started/install.html) for Windows or Linux
- [Istio](https://istio.io/docs/setup/kubernetes/download-release/) for Windows or Linux

## CI/CD Workflow

![Azure DevOps](./docs/images/devops-workflow.jpg)

## Step 1: Setup an Azure DevOps Project

Azure DevOps Services allows you to easily set up automated pipelines to build, test and deploy your code to any platform. We are going to use Azure DevOps as our default platform. If you don't have an account, you can create one [here](https://azure.microsoft.com/en-us/services/devops/).

![Azure DevOps](./docs/images/devops-project.jpg)

Now you can clone the repository locally:

    git clone https://<organization_name>@dev.azure.com/<organization_name>/<project_name>/_git/<project_name>

## Step 2: Setup Azure Active Directory for AKS authentication

AKS can be configured to use Azure Active Directory (AD) for user authentication. In this configuration, you can log into an AKS cluster using your Azure Active Directory authentication token. If you want to understand more about the authenticaton details you can find more info [here](https://docs.microsoft.com/en-us/azure/aks/aad-integration#authentication-details).

To enable Azure AD authorization for Kubernetes, you need to create two applications: **server** and **client** apps.

![AD authorization](./docs/images/ad-aks.jpg)

- **Server application:** It's a *Web app/API* that will be used to get a users Azure AD group membership. The web app obtains an `access token` for the user, which proves to the web API that the user successfully authenticated to the web app and the web app was able to obtain a delegated user identity to call the web API. This access token is sent in the request to the web API, which authorizes the user and returns the desired resource. For more info about *Web app/API* [here](https://docs.microsoft.com/en-us/azure/active-directory/develop/web-api).

- **Client application:** It's a *native* application that will be used when logging in with the Kubernetes CLI (known as `kubectl`). The client app obtains an `access token` for the user by using the `OAuth 2.0 protocol`. This access token is then sent in the request to the server app (web API), which authorizes the user and returns the desired resource. For more info about *native* apps [here](https://docs.microsoft.com/en-us/azure/active-directory/develop/native-app).



# Azure Kubernetes Service (AKS) DevOps

This is a lab to create a zero downtime scenario for Azure Kubernetes Service (AKS).

## Prerequisties

- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) for Windows or Linux
- [Docker](https://docs.docker.com/install/) for Windows or Linux
- [Terraform](https://www.terraform.io/intro/getting-started/install.html) for Windows or Linux
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest) for Windows or Linux
- [Windows 10 with Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/install-win10) or Ubuntu (16.04 or higher)

## Deployment Workflow

![Azure DevOps](./docs/images/devops-workflow.jpg)

Deployment environments vary significantly according to your architecture needs. In this lab we're going to work with a common 4-tier architecture: **development**, **testing**, **staging** and **production**.

- **Development**: A dedicated environment that allows developers to make code changes in applications to implement new features and fixing bugs. Developers perform unit testing for features validation and, when a new version is ready with all unit tests passing, the code is promoted to testing environment.

- **Testing**: A dedicated environment that allows testers execute test cases. Upon test failures/bugs, they can request bug fixes to dev team and provide detailed test and result logs. If all tests pass, the code is promoted to  staging environment.

- **Staging:** A mirror environment meant to mimic production as precisely as possible for quality assurance. It's an environment to test all installation/configuration/migration scripts and procedures, before they are applied to production environment. Another important step in staging is performing load testing. When the new release is ready, the code is promoted to production. When deploying a new release to production, you can use some techniques to reduce risks and downtime, like **canary release** or **blue/green deployment**.

- **Production**: The environment where end users directly interact with. 

## About the Lab

This Lab will walk through creating an AKS DevOps project that employs [Continuous Integration](https://docs.microsoft.com/en-us/azure/devops/what-is-continuous-integration) and [Continuous Delivery](https://docs.microsoft.com/en-us/azure/devops/learn/what-is-continuous-delivery) to microservices in a Kubernetes cluster.

- [Step 1: Setup Azure Active Directory for AKS authentication](./docs/aad-setup.md)
- [Step 2: Create Infrastructure as Code](./docs/infrastructure-setup.md)
- [Step 3: Setup an Azure DevOps Project](./docs/devops-project-setup.md)

### Pre-requisites

Before start with the provisioning you must activate the AutoUpgradePreview Feature on your azure subscription

```bash 
az account set -s <your subscription id>
az feature register --namespace Microsoft.ContainerService -n AutoUpgradePreview
```

The next command will show you how the state of the registration

```bash
az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService/AutoUpgradePreview')].{Name:name,State:properties.state}"
```

Once the Registration is done, you must refresh the integration using:

```bash 
az provider register --namespace Microsoft.ContainerService
```

### Terraform init

Init configuration on this terraform project contains an external backend configuration depending of the environment which you want to launch. For dynamic passing this properties you must use:

```bash
terraform init -backend-config="./environments/<environment>/backend-configuration.tfvars"
```

### Terraform plan/apply

for this kind of commands you must pass the set of variables for each environment.

```bash
terraform plan -var-file="./environments/<environment>/variables.tfvars"
terraform apply -var-file="./environments/<environment>/variables.tfvars" -auto-approve
```
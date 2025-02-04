# Azure storage
For in-tree azuredisk drivers, ```kubernetes.io/azure-disk``` provisioner can be used in the [azuredisk-storage-class.yaml](./azuredisk-storage-class.yaml).
1. Following command will deploy the storageclass
``` kubectl apply -f azuredisk-storage-class.yaml```

## Deployment with AzureDisk csi drivers
### Prerequisite
1. Create [`azure.json`](./azure.json) cloud config file and fill in all necessary fields, refer to [cloud provider config](https://kubernetes-sigs.github.io/cloud-provider-azure/install/configs/).
- Make sure identity/service principal used by driver has `Contributor` role in the resource group
2. Serialize `azure.json` by following command:

```console
cat azure.json | base64 | awk '{printf $0}'; echo
```
3. Create a secret file [`azure-cloud-provider.yaml`](./azure-cloud-provider.yaml) with following values and fill in `cloud-config` value produced in step#2

```yaml
apiVersion: v1
data:
  cloud-config: [fill-in-here]
kind: Secret
metadata:
  name: azure-cloud-provider
  namespace: kube-system
type: Opaque
```

4. Create a `azure-cloud-provider` secret in k8s cluster

```console
kubectl create -f azure-cloud-provider.yaml
```

### Install driver on a Kubernetes cluster

- install via [kubectl](https://github.com/kubernetes-sigs/azuredisk-csi-driver/blob/master/docs/install-azuredisk-csi-driver.md) on public Azure (please use helm for Azure Stack, RedHat/CentOS)
- install via [helm charts](https://github.com/kubernetes-sigs/azuredisk-csi-driver/tree/master/charts) on public Azure, Azure Stack, RedHat/CentOS

### Create storage class

1. Create storage class yaml file [`azuredisk-storage-class.yaml`](./azuredisk-storage-class.yaml) with provisioner as ```disk.csi.azure.com```
2. Following command will deploy the storageclass
``` kubectl apply -f azuredisk-storage-class.yaml```

# Deployment with AzureFile
1. Create a storage account on azure for the shared file system. Follow the documentation [here](https://docs.microsoft.com/en-us/azure/storage/common/storage-account-create?tabs=azure-portal).
2. Update the `azurefile-storageclass.yaml` with the created storage account name.
3. Following command will deploy the storageclass
``` kubectl apply -f azurefile-storage-class.yaml```

## Links

- https://github.com/kubernetes-sigs/azuredisk-csi-driver/blob/master/README.md
- https://github.com/kubernetes-sigs/azuredisk-csi-driver/blob/master/docs/driver-parameters.md
- https://kubernetes-csi.github.io/docs/
- https://docs.microsoft.com/en-us/azure/aks/azure-files-dynamic-pv

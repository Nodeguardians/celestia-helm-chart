## Celestia Helm Chart

Helm chart for deploying any type of Celestia nodes on a Kubernetes cluster.
## Deploy chart
Deploy Celestia App, bridge, full or light node in few seconds.

### Get Helm Repository Info
```bash
$ helm repo add ng-celestia https://nodeguardians.github.io/celestia-helm-chart/
$ helm repo update
```

### Install Helm Chart
```bash
$ helm install celestia ng-celestia/celestia
```

## Celestia App
### Import node-key and validator private key

For running your node as a validator you can provide your `node_key.json` and `priv_validator_key.json` files using secret (`.Values.celestiaApp.files.nodeKey.existingSecret` and `.Values.celestiaApp.files.privateValidatorKey.existingSecret`).

**Disclaimer:** we do not recommend using secret for **validator private key** (as Kubernetes Secrets are not encrypted), please use remote signer instead (Horcrux or TMKMS) for this file.

Here is the command to generate a secret for `node_key.json` file:
```bash
$ kubectl create secret generic celestia-node-key --from-file=<path>/node_key.json
```

Then override the corresping value: 
```yaml
celestiaApp:
  nodeKey:
  existingSecret: "celestia-node-key"
```

_Note that if you dont provide node-key (and / or validator private key), one will be generated at launch._

## Celestia Node

### Binary disclaimer
For celestia node version lower than `v0.8.0` the binary is located at root folder (not in a binary folder) so you will have to call all the path to use it: `./celestia`.  
For `v0.8.0` version and higher the binary is in `/bin/celestia`, so `celestia` is enough to call it.

As the default values of this chart if for Mocha testnet (waiting for Blockspacerace to become the new official testnet) `./celestia` is the default value used in the chart.

If running a Celestia node in a higher version, override default value like below:

```yaml
celestiaNode:
  binary: /bin/celestia
```

### Run different type of node
There are 3 different types of Celestia Node: bridge, light and full nodes. 
You can deploy anyone of them setting the variable below:
```yaml
celestiaNode:
  type: <bridge|light|full>
```
### Import Celkey
You can provide your own celkey using secret, you will need the 2 files representing your celkey, files inside `/root/.celestia-bridge-mocha/keys/keyring-test/`, for example:

```yaml
├── .celestia-bridge-mocha/keys/keyring-test/
    ├── 9989057057ec3d0d2280cdf689051374bf4721cx.address
    └── my_celes_key.info
```

Then you can create secret from thoses files
```bash
$ kubectl create secret generic celestia-cel-key-1 --from-file=<path>/node_key.json
$ kubectl create secret generic celestia-cel-key-2 --from-file=<path>/node_key.json
```
Provide the name of the secret names and file names in your `values.yaml` file:
```yaml
celestiaNode:
  celKey:
    enabled: true
    address:
      secretName: "celestia-cel-key-1"
      fileName: "9989057057ec3d0d2280cdf689051374bf4721cx.address"
    validatorInfo:
      secretName: "celestia-cel-key-2"
      fileName: "my_celes_key.info"
```



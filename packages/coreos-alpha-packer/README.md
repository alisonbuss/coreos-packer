# coreos-packer
## Projero Gerado pelo Package
   
### Projeto de criação de imagens CoreOS para múltiplas plataformas (Azure, Amazon EC2, Google GCE, DigitalOcean, Docker, VirtualBox).   
   
**Descrição:**
#### A simple CoreOS alpha for production. 
   
**Variaveis sobrescritas:** (OVERRIDE_VARIABLES.json)
```json
{"name":"coreos","release":"alpha","version":"current","build_path":"/packages/coreos-alpha-packer","vagrant_box":"coreos-alpha-packer.box"}
```   
   
**Script de execução:**
```bash
#!/bin/bash
function StartBuilding {
    local path="./packages/coreos-alpha-packer/packer";
    packer build \
		-var-file="${path}/vars-global.json" \
		-var-file="${path}/vars-coreos.json" \
		-var-file="${path}/vars-machine-large.json" \
		-var-file="${path}/vars-vagrant.json" \
        -var-file="${path}/OVERRIDE_VARIABLES.json" \
        "${path}/coreos-template.json";
}
StartBuilding "$@";
exit 0;
```   
   

# DOCUMENTATION:
## [Packer Modules] usados para gerar o "Novo Modelo Packer"
```text
./packer-modules
├── builders
├── post-processors
├── provisioners
└── variables

4 directories

```
 
## New Model for Packer
##### ./packer-new-model/coreos-vagrant.json 
```bash
{
    "packer_template": {
        "description": "CoreOS alpha image for a Vagrant platform.",
        "variables": {
            "custom_variables": "Values.. values..."
        },
        "list_variables": [
            "/variables/vars-global.json",
            "/variables/vars-coreos.json",
            "/variables/vars-machine-large.json",
            "/variables/vars-vagrant.json"
        ],
        "builders": [
            "/builders/vagrant.json"
        ],
        "provisioners": [
            "/provisioners/shell-hello-world.json"
        ],
        "post_processors": [
            "/post-processors/vagrant-box.json"
        ],
        "min_packer_version": "1.1.3"
    }
}
```
 
## Arquivos Gerados pelo Novo Modelo Packer
```text
./packer-builds/coreos-vagrant-packer
├── files
│   ├── ignitions
│   │   ├── coreos-ignition-for-azure.json
│   │   ├── coreos-ignition-for-digitalocean.json
│   │   ├── coreos-ignition-for-ec2.json
│   │   ├── coreos-ignition-for-gce.json
│   │   ├── coreos-ignition-for-packet.json
│   │   ├── coreos-ignition-for-virtualbox.json
│   │   └── coreos-ignition.json
│   └── vagrant_insecure_private_key
├── packer-template
│   ├── coreos-vagrant-template.json
│   ├── coreos-vagrant-template-min.json
│   ├── vars-coreos.json
│   ├── vars-custom-variables.json
│   ├── vars-global.json
│   ├── vars-machine-large.json
│   └── vars-vagrant.json
├── provisioners
│   ├── ansible
│   │   └── README.md
│   └── shell
│       └── README.md
├── README.md
├── start-packer.sh
└── Vagrantfile

6 directories, 20 files

```
 
## vars-custom-variables.json
##### ./packer-builds/coreos-vagrant-packer/packer-template/vars-custom-variables.json
```json
{
  "custom_variables": "Values.. values..."
}
```
 
## list_variables
   
##### ./packer-modules/variables/vars-global.json 
```json
{
    "global_build_path": "./"
}
```
 
##### ./packer-modules/variables/vars-coreos.json 
```json
{
    "coreos_name": "coreos",
    "coreos_release": "stable",
    "coreos_version": "current",
    "coreos_iso_checksum": "",
    "coreos_iso_checksum_type": "none",
    "coreos_ignition_path": "/files/ignitions/",
    "coreos_ignition_name": "coreos-ignition.json"
}
```
 
##### ./packer-modules/variables/vars-machine-large.json 
```json
{
    "machine_memory": "2048",
    "machine_cpus": "2",  
    "machine_disk_size": "40000"
}

```
 
##### ./packer-modules/variables/vars-vagrant.json 
```json
{
    "vagrant_box_name": "coreos-vagrant",
    "vagrant_insecure_private_key": "/files/vagrant_insecure_private_key",
    "vagrant_insecure_public_key": "/files/vagrant_insecure_public_key.pub"
}
```
 
 
## builders
   
##### ./packer-modules/builders/vagrant.json 
```json
{
    "type": "virtualbox-iso",
        
    "vm_name": "vm-{{user `name`}}-packer",
    "iso_checksum": "{{user `iso_checksum`}}",
    "iso_checksum_type": "{{user `iso_checksum_type`}}",
    "iso_url": "http://{{user `release`}}.release.core-os.net/amd64-usr/{{user `version`}}/coreos_production_iso_image.iso",
    "iso_target_path": "{{user `build_path`}}/coreos-{{user `release`}}-{{user `version`}}.iso", 
    "guest_os_type": "Linux26_64",
    
    "hard_drive_interface": "sata",
    "disk_size": "{{user `disk_size`}}",
    "vboxmanage": [
        ["modifyvm", "{{.Name}}", "--memory", "{{user `memory`}}"],
        ["modifyvm", "{{.Name}}", "--cpus", "{{user `cpus`}}"]
    ],
    "http_directory": "{{user `build_path`}}",

    "headless": "false",
    "guest_additions_mode": "disable",
    "output_directory": "{{user `build_path`}}/packer-vm-cache",
    
    "boot_wait": "33s",
    "boot_command": [
        "sudo -i;<enter>",
        "systemctl stop sshd.socket;<enter>",
        "wget http://{{ .HTTPIP }}:{{ .HTTPPort }}{{user `ignition_path`}}{{user `ignition_name`}};<enter>",
        "cat {{user `ignition_name`}};<enter>",
        "coreos-install -d /dev/sda -C {{ user `release` }} -i {{user `ignition_name`}};<enter>",
        "sleep 3s;<enter>",
        "reboot;<enter>"
    ],  
    
    "communicator": "ssh",
    "ssh_port": 22,
    "ssh_username": "core",
    "ssh_private_key_file": "{{user `build_path`}}{{user `vagrant_insecure_private_key`}}",
    "ssh_timeout": "33m",

    "shutdown_command": "sudo -S shutdown -P now"
}
```
 
 
## provisioners
   
##### ./packer-modules/provisioners/shell-hello-world.json 
```json
{
    "type": "shell",
    "inline": ["echo 'Hello World!!!'", "echo 'Hello CoreOS!!!'"]
}
```
 
 
## post_processors
   
##### ./packer-modules/post-processors/vagrant-box.json 
```json
{
    "type": "vagrant",
    "compression_level": "6",
    "output": "{{user `build_path`}}/{{user `vagrant_box_name`}}.box"
}
```
 
 
## coreos-vagrant-template.json
##### ./packer-builds/coreos-vagrant-packer/packer-template/coreos-vagrant-template.json
```json
{
  "description": "CoreOS alpha image for a Vagrant platform.",
  "builders": [
    {
      "type": "virtualbox-iso",
      "vm_name": "vm-{{user `name`}}-packer",
      "iso_checksum": "{{user `iso_checksum`}}",
      "iso_checksum_type": "{{user `iso_checksum_type`}}",
      "iso_url": "http://{{user `release`}}.release.core-os.net/amd64-usr/{{user `version`}}/coreos_production_iso_image.iso",
      "iso_target_path": "{{user `build_path`}}/coreos-{{user `release`}}-{{user `version`}}.iso",
      "guest_os_type": "Linux26_64",
      "hard_drive_interface": "sata",
      "disk_size": "{{user `disk_size`}}",
      "vboxmanage": [
        [
          "modifyvm",
          "{{.Name}}",
          "--memory",
          "{{user `memory`}}"
        ],
        [
          "modifyvm",
          "{{.Name}}",
          "--cpus",
          "{{user `cpus`}}"
        ]
      ],
      "http_directory": "{{user `build_path`}}",
      "headless": "false",
      "guest_additions_mode": "disable",
      "output_directory": "{{user `build_path`}}/packer-vm-cache",
      "boot_wait": "33s",
      "boot_command": [
        "sudo -i;<enter>",
        "systemctl stop sshd.socket;<enter>",
        "wget http://{{ .HTTPIP }}:{{ .HTTPPort }}{{user `ignition_path`}}{{user `ignition_name`}};<enter>",
        "cat {{user `ignition_name`}};<enter>",
        "coreos-install -d /dev/sda -C {{ user `release` }} -i {{user `ignition_name`}};<enter>",
        "sleep 3s;<enter>",
        "reboot;<enter>"
      ],
      "communicator": "ssh",
      "ssh_port": 22,
      "ssh_username": "core",
      "ssh_private_key_file": "{{user `build_path`}}{{user `vagrant_insecure_private_key`}}",
      "ssh_timeout": "33m",
      "shutdown_command": "sudo -S shutdown -P now"
    }
  ],
  "provisioners": [
    {
      "type": "shell",
      "inline": [
        "echo 'Hello World!!!'",
        "echo 'Hello CoreOS!!!'"
      ]
    }
  ],
  "post-processors": [
    {
      "type": "vagrant",
      "compression_level": "6",
      "output": "{{user `build_path`}}/{{user `vagrant_box_name`}}.box"
    }
  ],
  "min_packer_version": "1.1.3"
}

```
 
## start-packer.sh
##### ./packer-builds/coreos-vagrant-packer/start-packer.sh
```bash
#!/bin/bash
function StartPacker {
    local params="$@";
    local coreos_release="alpha";
    local coreos_version="1632.0.0";
    local coreos_url_digests="http://${coreos_release}.release.core-os.net/amd64-usr/${coreos_version}/coreos_production_iso_image.iso.DIGESTS";
    local coreos_iso_checksum_type="SHA512";
    local coreos_iso_checksum=$(wget -qO- "${coreos_url_digests}" | grep "coreos_production_iso_image.iso" | awk '{ print length, $1 | "sort -rg"}' | awk 'NR == 1 { print $2 }');
    local build_path="./packer-builds/coreos-vagrant-packer";
    local template_path="./packer-builds/coreos-vagrant-packer/packer-template";
    local template_file="${template_path}/coreos-vagrant-template-min.json";
    __run_packer() {
        packer "$@" \
			-var-file="${template_path}/vars-global.json" \
			-var-file="${template_path}/vars-coreos.json" \
			-var-file="${template_path}/vars-machine-large.json" \
			-var-file="${template_path}/vars-vagrant.json" \
            -var-file="${template_path}/vars-custom-variables.json" \
            -var "coreos_release=${coreos_release}" \
            -var "coreos_version=${coreos_version}" \
            -var "coreos_iso_checksum_type=${coreos_iso_checksum_type}" \
            -var "coreos_iso_checksum=${coreos_iso_checksum}" \
            -var "global_build_path=${build_path}" \
            "${template_file}";
    }
    case $params in
        validate) { __run_packer "${params}"; };;
        inspect)  { packer inspect "${template_file}"; };;
        build)    { __run_packer "${params}"; };;
        *)        { packer "${params}"; };;
    esac
}
StartPacker "$@";
exit 0;

```
 

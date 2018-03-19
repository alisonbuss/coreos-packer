
# Documentation:

## Custom Variables:

#### ./packer-variables/custom.json
```json
{
    "virtualbox_cpus":"2",
    "virtualbox_memory":"2048",
    "virtualbox_disk_size":"33666"
}
```
 
## List Variables Packer:

#### ./packer-variables/global.json

```json
{
    "global_working_directory": "."
}
```
 
#### ./packer-variables/operational-system/coreos.json

```json
{
    "_comment": "WARNING: When you change the [os_release] of CoreOS, you should also change the file './pre-provision/container-linux-config/keys-to-underworld.yml' for 'stable' line 60.",

    "os_name": "coreos",
    "os_release": "stable",
    "os_version": "1632.3.0",

    "os_iso_url": "http://stable.release.core-os.net/amd64-usr/1632.3.0/coreos_production_iso_image.iso",
    "os_iso_checksum_type": "SHA512",
    "os_iso_checksum": "3afecae521c9a52892362ff436ff2dccc11a890a37d636d7963c9b42b58605c60d6919fd5893a0d69a4e38dc5889a5d2279173c374d07af1a57dec09ae18e85e",

    "os_img_aws_id": "ami-44a03c22",
    "os_img_google_id": "coreos-stable",
    "os_img_google_name": "coreos-stable-1632.3.0",
    "os_img_digitalocean_id": "coreos-stable",

    "os_user_data_name": "keys-to-underworld",
    "os_user_data_path": "/pre-provision/ignitions"
}
```
 
#### ./packer-variables/platform/virtualbox.json

```json
{
    "virtualbox_cpus": "1",
    "virtualbox_memory": "512",
    "virtualbox_disk_size": "20000",

    "virtualbox_ssh_username": "packer",
    "virtualbox_ssh_private_key": "/pre-provision/vagrant_insecure_private_key",

    "virtualbox_vagrant_box_file": "image-coreos-vagrant.box"
}
```

#### ./packer-variables/platform/aws.json

```json
{
    "_comment": "Missing the definition of the variables of this platform!!!"
}
```

#### ./packer-variables/platform/digitalocean.json

```json
{
    "_comment": "Missing the definition of the variables of this platform!!!"
}
```

#### ./packer-variables/platform/google.json

```json
{
    "_comment": "Missing the definition of the variables of this platform!!!"
}
```

## Templates Packer:

#### ./packer-templates/coreos-virtualbox-template.json

```json
{
    "description": "CoreOS image for a VirtualBox platform.",

    "builders": [{
        "type": "virtualbox-iso",
            
        "vm_name": "vm-{{timestamp}}-packer",
        "iso_checksum": "{{user `os_iso_checksum`}}",
        "iso_checksum_type": "{{user `os_iso_checksum_type`}}",
        "iso_url": "{{user `os_iso_url`}}",
        "iso_target_path": "{{user `global_working_directory`}}/builds/{{user `os_name`}}-{{user `os_release`}}-{{user `os_version`}}.iso", 
        "guest_os_type": "Linux26_64",
        
        "hard_drive_interface": "sata",
        "disk_size": "{{user `virtualbox_disk_size`}}",
        "vboxmanage": [
            ["modifyvm", "{{.Name}}", "--cpus", "{{user `virtualbox_cpus`}}"],
            ["modifyvm", "{{.Name}}", "--memory", "{{user `virtualbox_memory`}}"]
        ],
    
        "headless": "false",
        "guest_additions_mode": "disable",
        "output_directory": "{{user `global_working_directory`}}/builds/packer-vm-cache",
        
        "http_directory": "{{user `global_working_directory`}}",
        "boot_wait": "33s",
        "boot_command": [
            "sudo -i;<enter>",
            "systemctl stop sshd.socket;<enter>",
            "wget http://{{ .HTTPIP }}:{{ .HTTPPort }}{{user `os_user_data_path`}}/{{user `os_user_data_name`}}-for-vagrant-virtualbox.json;<enter>",
            "cat {{user `os_user_data_name`}}-for-vagrant-virtualbox.json;<enter>",
            "coreos-install -d /dev/sda -C {{ user `os_release` }} -i {{user `os_user_data_name`}}-for-vagrant-virtualbox.json;<enter>",
            "sleep 3s;<enter>",
            "reboot;<enter>"
        ],  
        
        "communicator": "ssh",
        "ssh_port": 22,
        "ssh_username": "{{user `virtualbox_ssh_username`}}",
        "ssh_private_key_file": "{{user `global_working_directory`}}{{user `virtualbox_ssh_private_key`}}",
        "ssh_timeout": "33m",
    
        "shutdown_command": "sudo -S shutdown -P now"
    }],

    "provisioners": [{
        "type": "shell",
        "environment_vars" : [],
        "execute_command": "{{ .Vars }} sudo -E -S sh '{{ .Path }}'",
        "scripts": [
            "{{user `global_working_directory`}}/pre-provision/shell-script/install-python.sh",
            "{{user `global_working_directory`}}/pre-provision/shell-script/install-rkt.sh",
            "{{user `global_working_directory`}}/pre-provision/shell-script/install-docker.sh",
            "{{user `global_working_directory`}}/pre-provision/shell-script/install-docker-compose.sh",
            "{{user `global_working_directory`}}/pre-provision/shell-script/install-etcd.sh",
            "{{user `global_working_directory`}}/pre-provision/shell-script/install-flannel.sh",
            "{{user `global_working_directory`}}/pre-provision/shell-script/provide-basic-security.sh",
            "{{user `global_working_directory`}}/pre-provision/shell-script/provide-clean-image.sh"
        ]
    }],

    "post-processors": [{
        "type": "vagrant",
        "compression_level": "6",
        "output": "{{user `global_working_directory`}}/builds/{{user `virtualbox_vagrant_box_file`}}"
    }],

    "min_packer_version": "1.1.3"
}
```

#### ./packer-templates/coreos-aws-template.json

```json
{
    "_comment": "Missing the implementation for this platform!!!",

    "description": "CoreOS image for a AWS platform.",

    "builders": [{
        "type": "amazon-ebs"

    }],

    "provisioners": [{
        
    }],

    "post-processors": [{

    }],

    "min_packer_version": "1.1.3"
}
```

#### ./packer-templates/coreos-digitalocean-template.json

```json
{
    "_comment": "Missing the implementation for this platform!!!",

    "description": "CoreOS image for a DigitalOcean platform.",

    "builders": [{
        "type": "digitalocean"

    }],

    "provisioners": [{
        
    }],

    "post-processors": [{

    }],

    "min_packer_version": "1.1.3"
}
```

#### ./packer-templates/coreos-google-template.json

```json
{
    "_comment": "Missing the implementation for this platform!!!",

    "description": "CoreOS image for a Google platform.",

    "builders": [{
        "type": "googlecompute"

    }],

    "provisioners": [{
        
    }],

    "post-processors": [{

    }],

    "min_packer_version": "1.1.3"
}
```

#### ./packer-templates/coreos-all-platforms-template.json

```json
{
    "_comment": "Missing the implementation of all platforms!!!",

    "description": "CoreOS image for all platform.",

    "builders": [
        {
            "type": "virtualbox-iso"
        },
        {
            "type": "amazon-ebs"
        },
        {
            "type": "googlecompute"
        },
        {
            "type": "digitalocean"
        }
    ],

    "provisioners": [{

    }],

    "post-processors": [{

    }],

    "min_packer_version": "1.1.3"
}
```

## Initial provisioning file "Container Linux Config" for CoreOS.

#### ./pre-provision/container-linux-config/keys-to-underworld.yaml

```yaml
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Ignition for creating SSH access keys and user access 
#         settings, updating the operating system.
#-------------------------------------------------------------#

passwd:
  users:
    - name: "core"
      # Vagrant insecure public key.
      ssh_authorized_keys:
        - "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key"

    - name: "lucifer"
      # Vagrant insecure public key.
      ssh_authorized_keys:
        - "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key"

    - name: "packer"
      # Vagrant insecure public key.
      ssh_authorized_keys:
        - "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key"
        
    - name: "vagrant"
      # Output Data:(Last Algorithm: crypt3-md5)-(pass: vagrant).
      password_hash: "$1$iK1XY6BH$s504GuI.QIZYBqMRDMwFr1"
      # Vagrant insecure public key.
      ssh_authorized_keys:
        - "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key"
      home_dir: "/home/vagrant"
      no_create_home: false
      groups:
        - "sudo"
        - "docker"
      shell: "/bin/bash"
    
    - name: "ansible"
      # Vagrant insecure public key.
      ssh_authorized_keys:
        - "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key"
      home_dir: "/home/ansible"
      no_create_home: false
      groups:
        - "sudo"
        - "docker"
      shell: "/bin/bash"

# WARNING: When you change the RELEASE of CoreOS, you should also change thes
# files "./packer-variables/operational-system/coreos.json" for {..."os_release":"stable"...}
update:
  group: "stable"

locksmith:
  reboot_strategy: "etcd-lock"
  window_start: "Sun 0:33"
  window_length: "3h"

storage:
  files:
    - path: "/etc/ssh/sshd_config"
      filesystem: "root"
      mode: 0600
      contents:
        inline: |
          # Apply to users: (core, lucifer, packer, vagrant, ansible).
          AllowUsers core lucifer packer vagrant ansible
          AuthenticationMethods publickey
          UseDNS no
          PermitRootLogin no
          PasswordAuthentication no
          ChallengeResponseAuthentication no
          Subsystem sftp internal-sftp

    - path: "/etc/sudoers.d/packer"
      filesystem: "root"
      mode: 0644
      user:
        id: 0
      group:
        id: 0
      contents:
        inline: "packer ALL=(ALL) NOPASSWD: ALL"

    - path: "/etc/sudoers.d/vagrant"
      filesystem: "root"
      mode: 0644
      user:
        id: 0
      group:
        id: 0
      contents:
        inline: "vagrant ALL=(ALL) NOPASSWD: ALL"

    - path: "/etc/sudoers.d/ansible"
      filesystem: "root"
      mode: 0644
      user:
        id: 0
      group:
        id: 0
      contents:
        inline: "ansible ALL=(ALL) NOPASSWD: ALL"

    - path: "/etc/profile.d/motd.sh"
      filesystem: "root"
      mode: 0644
      contents:
        inline: |
          #!/bin/bash
          echo -e -n "\e[32m\e[1m";
          cat <<'EOF'
          ---Origin Project: 'https://github.com/alisonbuss/coreos-packer/'
               _   _      _ _        __        __         _     _   _      
              | | |D| ___|E|V| ___   \O\      /P/__  _ __|S| __| | | |     
              | |_| |/ _ \ | |/ _ \   \ \ /\ / / _ \| '__| |/ _` | | |     
              |  _  |  __/ | | (_) |   \ V  V / (_) | |  | | (_| | |_|     
              |_| |_|\___|_|_|\___/     \_/\_/ \___/|_|  |_|\__,_| (_)     
                                                                           
          ...............................Image generated by Packer.........
          EOF
          echo -e "\033[00m";
          echo -e -n "This image contains installed: \e[93m\e[1m"; /opt/bin/python --version; 
          echo -e "\033[00m";
```

## Execution script for the compilation, validation and construction of the Image Packer.

#### Example 1:

```bash
#!/bin/bash

make plan compile validate build install-box

exit 0;
```

#### Example 2:

```bash
#!/bin/bash

# 1ª) Step -> compile
bash build-image.sh \
        --action="compile" \
        --source-file="./pre-provision/container-linux-config/keys-to-underworld.yml" \
        --compilation-path="./pre-provision/ignitions" \
        --platforms="vagrant-virtualbox digitalocean ec2 gce";

# 2ª) Step -> inspect
bash build-image.sh \
        --action="inspect" \
        --template-file="./packer-templates/coreos-virtualbox-template.json";

# 3ª) Step -> validate
bash build-image.sh \
        --action="validate" \
        --template-file="./packer-templates/coreos-virtualbox-template.json" \
        --variables="global.json /operational-system/coreos.json /platform/virtualbox.json custom.json" \
        --variables-path="./packer-variables";

# 4ª) Step -> build
bash build-image.sh \
        --action="build" \
        --template-file="./packer-templates/coreos-virtualbox-template.json" \
        --variables="global.json /operational-system/coreos.json /platform/virtualbox.json custom.json" \
        --variables-path="./packer-variables" \
        --packer-only="virtualbox-iso" \
        --working-directory=".";

# 5ª) Step -> install-box
bash build-image.sh \
        --action="install-box" \
        --box-name="packer/coreos-vagrant-box" \
        --box-path="./builds/image-coreos-vagrant.box";

exit 0;
```

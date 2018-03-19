

#### Translation for: **[English](https://github.com/alisonbuss/coreos-packer/blob/master/README_LANG_EN.md)**.

#### Status do Projeto: *(Em Desenvolvimento)*.

<h1 align="center">
    Projeto de criação de imagens CoreOS <br/> para múltiplas plataformas <br/>(Amazon EC2, Google GCE, DigitalOcean, VirtualBox)
</h1>

### Inspirado nos projetos:
 
* **[[coreos-packer](https://github.com/wasbazi/coreos-packer)]** - por Wasbazi.
* **[[coreos-packer](https://github.com/YungSang/coreos-packer)]** - por Yung Sang.
* **[[coreos-packer](https://github.com/kevit/coreos-packer)]** - por Sergey Karatkevich.
* **[[packer-templates](https://github.com/kaorimatz/packer-templates)]** por Satoshi Matsumoto.
* **[[packer-qemu-coreos-container-linux](https://github.com/dyson/packer-qemu-coreos-container-linux)]** - por Dyson Simmons.
* **[[kubernetes-coreos-packer](https://github.com/stylelab-io/kubernetes-coreos-packer)]** - por StyleLab-io.
* **[[aws-coreos-clustering-kit](https://github.com/ainoya/aws-coreos-clustering-kit)]** - por Naoki Ainoya.
* **[[packer-ubuntu](https://github.com/cbednarski/packer-ubuntu)]** - por Chris Bednarski.

### Dependência de ferramentas:

* **[[VirtualBox](https://www.virtualbox.org/)]** 4.3.10 ou superior...
* **[[Vagrant](https://www.vagrantup.com/)]** 1.6.3 ou superior...
* **[[Packer](https://www.packer.io/)]** 1.1.3 ou superior...
* **[[Container Linux Config Transpiler](https://github.com/coreos/container-linux-config-transpiler)]** 0.5.0 ou superior...
* **[[GNU Make](https://www.gnu.org/software/make/)]** 4.1 ou superior...

> **:warning: Nota:**
> - *É necessário ter instalado as dependências citadas acima, para que o projeto funcione.*
> - *A execução desse projeto foi feita através de um **Desktop Ubuntu 17.10 (Artful Aardvark)**.*

### Documentação de apoio:

* **[Documentação Técnica do Projeto](https://github.com/alisonbuss/coreos-packer/blob/master/README_DOC.md)**
* **[Post: Yet Emerging Technologies - Blog, by Sébastien Braun "CoreOS Container Linux"](http://www.yet.org/2017/03/01-container-linux/)**.
* **[Documentação oficial do CoreOS](https://coreos.com/os/docs/latest/cluster-architectures.html)**.
* **[Documentação oficial do Packer](https://www.packer.io/docs/index.html)**.
* **[Documentação oficial do Vagrant](https://www.vagrantup.com/docs/index.html)**.

### Objetivo:

Fornecer um projeto de "Infrastructure as Code (IaC)" usando **Packer Templates** e **Shell Script** para provisionar uma imagem básica para as múltiplas plataformas **(Amazon EC2, Google GCE, DigitalOcean, VirtualBox)**.

### Plataformas Suportadas no Projeto:

  - **[Digital Ocean]** - :x: *Não Implementado...*
  - **[Amazon EC2 AMI]** - :x: *Não Implementado...*
  - **[VirtualBox e Vagrant Box]** - :heavy_check_mark: *Implementado.*
  - **[Google Cloud Compute Engine (GCE)]** - :x: *Não Implementado...*

### Imagem Packer: 

  - **CoreOS Stable 1632.3.0**
    - kernel: v4.14.19
    - systemd: v235
    - ignition: v0.20.1
    - rkt: v1.29.0
    - docker: v17.09.1
    - docker-compose: v1.19.0
    - etcd v2.3.8
    - etcd v3.2.11
    - flannel v0.9.1
    - active-python: v2.7.13

  - **Variáveis do sistema operacional CoreOS**
    - "os_name": "coreos",
    - "os_release": "stable",
    - "os_version": "1632.3.0",
    - "os_iso_url": "http://stable.release.core-os.net/amd64-usr/1632.3.0/coreos_production_iso_image.iso",
    - "os_iso_checksum_type": "SHA512",
    - "os_iso_checksum": "3afecae521c9a52892362ff436ff2dccc11a890a37d636d7963c9b42b58605c60d6919fd5893a0d69a4e38dc5889a5d2279173c374d07af1a57dec09ae18e85e",
    - "os_img_aws_id": "ami-44a03c22",
    - "os_img_google_id": "coreos-stable",
    - "os_img_google_name": "coreos-stable-1632.3.0",
    - "os_img_digitalocean_id": "coreos-stable",
    - "os_user_data_name": "keys-to-underworld",
    - "os_user_data_path": "/pre-provision/ignitions"

Para o pré-provisionamento básico da imagem CoreOS, será através dos arquivos de **Shell Script**:

    ./pre-provision/shell-script/install-python.sh
    ./pre-provision/shell-script/install-rkt.sh
    ./pre-provision/shell-script/install-docker.sh
    ./pre-provision/shell-script/install-docker-compose.sh
    ./pre-provision/shell-script/install-etcd.sh
    ./pre-provision/shell-script/install-flannel.sh
    ./pre-provision/shell-script/provide-basic-security.sh
    ./pre-provision/shell-script/provide-clean-image.sh

> **:warning: Nota:**
> - *Para mais detalhes das variáveis e templetes Packer, você encontra na "[Documentação Técnica](https://github.com/alisonbuss/coreos-packer/blob/master/README_DOC.md)" do projeto.*

### Estrutura do Projeto:

Descrição dos arquivos e diretorios do projeto:

```text
coreos-packer................................Pasta do projeto.
├── packer-templates.........................Pasta dos templates Packer.
│   ├── coreos-all-platforms-template.json...Template para todas as plataformas.
│   ├── coreos-aws-template.json.............Template para a plataforma Amazon EC2 AMI.
│   ├── coreos-digitalocean-template.json....Template para a plataforma Digital Ocean.
│   ├── coreos-google-template.json..........Template para a plataforma Google Cloud Compute Engine (GCE).
│   └── coreos-virtualbox-template.json......Template para a plataforma VirtualBox e Vagrant Box.
├── packer-variables.........................Variáveis Packer.
│   ├── credential...........................Variáveis das credenciais de autorizações das plataformas.
│   │   ├── aws.json.........................Credencial de autorização Amazon.
│   │   ├── digitalocean.json................Credencial de autorização Digital Ocean.
│   │   └── google.json......................Credencial de autorização Google Cloud Compute Engine.
│   ├── custom.json..........................Variável de customizações geral, "Irá sobrescrever as demais variáveis".
│   ├── global.json..........................Variável global.
│   ├── operational-system...................Variáveis do tipo de sistema operacional.
│   │   └── coreos.json......................Variável do sistema operacional CoreOS.
│   └── platform.............................Variáveis específicas de cada plataforma.
│       ├── aws.json
│       ├── digitalocean.json
│       ├── google.json
│       └── virtualbox.json
├── pre-provision............................Pasta dos arquivos de pré-provisionamento da imagem Packer.
│   ├── container-linux-config...............Pasta onde se encontra os "Container Linux Config" para ser convertidos em "ignitions".
│   │   ├── examples.........................Pasta de exemplos "Container Linux Config".
│   │   │   ├── basic-ignition.yml
│   │   │   ├── does-everything.yml
│   │   │   └── vagrant-ignition.yml
│   │   └── keys-to-underworld.yml...........Arquivo principal de "Container Linux Config" será convertido em "ignitions".
│   ├── ignitions............................Pasta onde será armazenados os "Container Linux Config" convertidos em "ignition".
│   │   ├── keys-to-underworld-for-digitalocean.json
│   │   ├── keys-to-underworld-for-ec2.json
│   │   ├── keys-to-underworld-for-gce.json
│   │   ├── keys-to-underworld-for-vagrant-virtualbox.json
│   │   └── keys-to-underworld.json
│   ├── shell-script.........................Scripts de pré-provisionamento da imagem Packer.
│   │   ├── install-docker-compose.sh
│   │   ├── install-docker.sh
│   │   ├── install-etcd.sh
│   │   ├── install-flannel.sh
│   │   ├── install-python.sh
│   │   ├── install-rkt.sh
│   │   ├── provide-basic-security.sh
│   │   └── provide-clean-image.sh
│   ├── vagrant_insecure_private_key.........Chave privada do Vagrant.
│   └── vagrant_insecure_public_key.pub......Chave publica do Vagrant.
├── build-image.sh...........................Shell Script responsavel pelo build do projeto "coreos-packer".
├── LICENSE..................................Licença (MIT).
├── Makefile.................................Arquivo principal de start do projeto "coreos-packer".
├── Makefile.test............................Arquivo de teste do Makefile.
├── README_DOC.md............................Documentação Técnica do Projeto "coreos-packer"
├── README_LANG_EN.md........................Arquivo de tradução do README.md
└── README.md................................Documentação Geral do Projeto "coreos-packer"
```

Arquivo principal do projeto **[Makefile](https://github.com/alisonbuss/coreos-packer/blob/master/Makefile)**.

```Makefile
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Makefile for project construction.
# @example:
#       $ make plan compile validate build
#   OR
#       $ make build-force
#   OR
#       $ make clean
#   OR
#       $ make plan compile build install-box PACKER_ONLY="virtualbox-iso"
#   OR
#       $ make uninstall-box
#-------------------------------------------------------------#

# DEFAULT VARIABLES - Structural
WORKING_DIRECTORY         ?= .
#WORKING_DIRECTORY        ?= `pwd`

# DEFAULT VARIABLES - Packer!!!
PACKER_TEMPLATE           ?= coreos-virtualbox-template.json
PACKER_VARIABLES          ?= global.json /operational-system/coreos.json /platform/virtualbox.json custom.json
PACKER_ONLY               ?= virtualbox-iso

PACKER_TEMPLATES_PATH     ?= $(WORKING_DIRECTORY)/packer-templates
PACKER_VARIABLES_PATH     ?= $(WORKING_DIRECTORY)/packer-variables

# DEFAULT VARIABLES - Ignition For CoreOS
IGNITION_SOURCE_FILE      ?= $(WORKING_DIRECTORY)/pre-provision/container-linux-config/keys-to-underworld.yml
IGNITION_COMPILATION_PATH ?= $(WORKING_DIRECTORY)/pre-provision/ignitions
IGNITION_PLATFORMS        ?= vagrant-virtualbox digitalocean ec2 gce

# DEFAULT VARIABLES - Vagrant
VAGRANT_BOX_NAME          ?= packer/coreos-vagrant-box
VAGRANT_BOX_PATH          ?= $(WORKING_DIRECTORY)/builds/image-coreos-vagrant.box

# DEFAULT VARIABLES - Compile, validate and build image files for Project Packer.
BUILD_IMAGE_CMD           ?= $(WORKING_DIRECTORY)/build-image.sh

plan: 
    @echo "The default values to be used by this Makefile:";
    @echo "";
    @echo "    --> MAKECMDGOALS: make $(MAKECMDGOALS)";
    @echo "    --> WORKING_DIRECTORY: $(WORKING_DIRECTORY)";
    @echo "";
    @echo "    --> PACKER_TEMPLATE: $(PACKER_TEMPLATE)";
    @echo "    --> PACKER_VARIABLES: [$(PACKER_VARIABLES)]";
    @echo "    --> PACKER_ONLY: $(PACKER_ONLY)";
    @echo "    --> PACKER_TEMPLATES_PATH: $(PACKER_TEMPLATES_PATH)";
    @echo "    --> PACKER_VARIABLES_PATH: $(PACKER_VARIABLES_PATH)";
    @echo "";
    @echo "    --> IGNITION_SOURCE_FILE: $(IGNITION_SOURCE_FILE)";
    @echo "    --> IGNITION_COMPILATION_PATH: $(IGNITION_COMPILATION_PATH)";
    @echo "    --> IGNITION_PLATFORMS: $(IGNITION_PLATFORMS)";
    @echo "";
    @echo "    --> VAGRANT_BOX_NAME: $(VAGRANT_BOX_NAME)";
    @echo "    --> VAGRANT_BOX_PATH: $(VAGRANT_BOX_PATH)";
    @echo "";
    @echo "    --> BUILD_IMAGE_CMD: $(BUILD_IMAGE_CMD)";
    @echo "";

compile: 
    @echo "Starting the compilation of the (IGNITION COREOS)..."; 
    @echo "--source file: $(IGNITION_SOURCE_FILE)"; 
    @echo "--compilation path: $(IGNITION_COMPILATION_PATH)"; 

    @bash $(BUILD_IMAGE_CMD) --action="compile" \
                             --source-file="$(IGNITION_SOURCE_FILE)" \
                             --compilation-path="$(IGNITION_COMPILATION_PATH)" \
                             --platforms="$(IGNITION_PLATFORMS)";

    @echo "Complete compilation!";

validate:
    @echo "Starting the validation of the template Packer..."; 
    @echo "--template file: $(WORKING_DIRECTORY)/packer-templates/$(PACKER_TEMPLATE)"; 

    @bash $(BUILD_IMAGE_CMD) --action="inspect" \
                             --template-file="$(PACKER_TEMPLATES_PATH)/$(PACKER_TEMPLATE)";

    @bash $(BUILD_IMAGE_CMD) --action="validate" \
                             --template-file="$(PACKER_TEMPLATES_PATH)/$(PACKER_TEMPLATE)" \
                             --variables="$(PACKER_VARIABLES)" \
                             --variables-path="$(PACKER_VARIABLES_PATH)";

build:
    @echo "Starting the BUILD of the template Packer..."; 
    @echo "--template file: $(WORKING_DIRECTORY)/packer-templates/$(PACKER_TEMPLATE)";

    @bash $(BUILD_IMAGE_CMD) --action="build" \
                             --template-file="$(PACKER_TEMPLATES_PATH)/$(PACKER_TEMPLATE)" \
                             --variables="$(PACKER_VARIABLES)" \
                             --variables-path="$(PACKER_VARIABLES_PATH)" \
                             --packer-only="$(PACKER_ONLY)" \
                             --working-directory="$(WORKING_DIRECTORY)";

build-force: clean compile validate build

clean:
    @echo "Initiating deletion of compilation files from the Project Packer...";
    @echo "--affected directory: $(WORKING_DIRECTORY)/builds";

    @rm -rf $(WORKING_DIRECTORY)/builds; sleep 2s;

    @echo "cleaning completed!"; 

# ----------------------------------------------------------------------
# THE CODES BELOW ARE INTENDED TO RUN THE TOOLS (Vagrant and VirtualBox)
# ----------------------------------------------------------------------
install-box:
    @echo "Starting the installation of the Vagrant Box generated by Packer..."; 
    @echo "--box name: $(VAGRANT_BOX_NAME)"; 
    @echo "--box path: $(VAGRANT_BOX_PATH)"; 

    @vagrant box list;

    @echo "--> Vagrant Box Installation..."; 
    @bash $(BUILD_IMAGE_CMD) --action="install-box" \
                             --box-name="$(VAGRANT_BOX_NAME)" \
                             --box-path="$(VAGRANT_BOX_PATH)";

    @vagrant box list;

    @echo "Complete Vagrant Box installation!";

publish-box:
    @echo "Starting the publish of the Vagrant Box on Vagrant Cloud generated by Packer..."; 
    @echo "--box name: $(VAGRANT_BOX_NAME)"; 
    @echo "--box path: $(VAGRANT_BOX_PATH)"; 

    @echo "--> Vagrant Box Publish..."; 
    @bash $(BUILD_IMAGE_CMD) --action="publish-box" \
                             --box-path="$(VAGRANT_BOX_PATH)";

    @echo "Complete Vagrant Box publish!";

uninstall-box:
    @echo "Starting the uninstallation of the Vagrant Box generated by Packer..."; 
    @echo "--box be uninstall: $(VAGRANT_BOX_NAME)"; 

    @vagrant box list;
    @vagrant global-status;

    @echo "--> Vagrant Box Uninstallation..."; 
    @bash $(BUILD_IMAGE_CMD) --action="uninstall-box" \
                             --box-name="$(VAGRANT_BOX_NAME)";

    @vagrant box list;
    @vagrant global-status;

    @echo "Uninstalling the completed Vagrant Box!";
```

### Executando o projeto.

> **:warning: Nota:**
> - *A execução desse projeto foi feita através de um **Desktop Ubuntu 17.10 (Artful Aardvark)**.*
> - *Suponho que você já tenha instalados as [dependências do projeto](https://github.com/alisonbuss/coreos-packer#depend%C3%AAncia-de-ferramentas) citada acima.*

Antes de sair executado o projeto pelo terminal, precisamos validar algumas dependências já instaladas no seu **desktop**, para poder assim executar o projeto.

### Validando as dependências:

  * **[[VirtualBox](https://www.virtualbox.org/)]** 4.3.10 ou superior...
    * Testar pelo terminal:
      ```bash
      $ VBoxManage -v
      ```
    * Resultado semelhante:
      ```bash
      5.2.8r121009
      ```
  * **[[Vagrant](https://www.vagrantup.com/)]** 1.6.3 ou superior...
    * Testar pelo terminal:
      ```bash
      $ vagrant -v
      ```
    * Resultado semelhante:
      ```bash
      Vagrant 2.0.1
      ```
  * **[[Packer](https://www.packer.io/)]** 1.1.3 ou superior...
    * Testar pelo terminal:
      ```bash
      $ packer -v
      ```
    * Resultado semelhante:
      ```bash
      1.1.3
      ```
  * **[[Container Linux Config Transpiler](https://github.com/coreos/container-linux-config-transpiler)]** 0.5.0 ou superior...
    * Testar pelo terminal:
      ```bash
      $ ct -version
      ```
    * Resultado semelhante:
      ```bash
      ct v0.5.0
      ```
  * **[[GNU Make](https://www.gnu.org/software/make/)]** 4.1 ou superior...
    * Testar pelo terminal:
      ```bash
      $ make -v
      ```
    * Resultado semelhante:
      ```bash
      GNU Make 4.1
      Compilado para x86_64-pc-linux-gnu
      Copyright (C) 1988-2014 Free Software Foundation, Inc.
      ...
      ```

PRONTO!!! se tudo funcionou como o esperado agora podemos executar o projeto [coreos-packer](https://github.com/alisonbuss/coreos-packer/).

> **:warning: Nota:**
> - *Caso ocorra **ERROS** nas validações acima, **Boa Sorte!!!  "O Google é o seu pastor e nada te faltará..."***


### Executando o projeto "[coreos-packer](https://github.com/alisonbuss/coreos-packer/)" usando a ferramenta Packer.

1ª) Vamos criar uma pasta que vai ser o nosso ambiente e fazer o download do projeto **[coreos-packer](https://github.com/alisonbuss/coreos-packer/archive/master.zip)** via terminal:

```bash
$ mkdir -p "my-project-IaC"
$ cd ./my-project-IaC

$ wget -O "coreos-packer.zip" "https://github.com/alisonbuss/coreos-packer/archive/master.zip"

$ ls
coreos-packer.zip
```

2ª) Vamos descompactar o projeto **coreos-packer**, entrar na pasta e exibir o plano de execução:

```bash
$ unzip "coreos-packer.zip"

$ clear
$ ls
coreos-packer-master  coreos-packer.zip

$ cd ./coreos-packer-master
$ ls
build-image.sh  Makefile       packer-templates  pre-provision  README_LANG_EN.md
LICENSE         Makefile.test  packer-variables  README_DOC.md  

$ make plan
The default values to be used by this Makefile:

    --> MAKECMDGOALS: make plan
    --> WORKING_DIRECTORY: .

    --> PACKER_TEMPLATE: coreos-virtualbox-template.json
    --> PACKER_VARIABLES: [global.json /operational-system/coreos.json /platform/virtualbox.json custom.json]
    --> PACKER_ONLY: virtualbox-iso
    --> PACKER_TEMPLATES_PATH: ./packer-templates
    --> PACKER_VARIABLES_PATH: ./packer-variables

    --> IGNITION_SOURCE_FILE: ./pre-provision/container-linux-config/keys-to-underworld.yml
    --> IGNITION_COMPILATION_PATH: ./pre-provision/ignitions
    --> IGNITION_PLATFORMS: vagrant-virtualbox digitalocean ec2 gce

    --> VAGRANT_BOX_NAME: packer/coreos-vagrant-box
    --> VAGRANT_BOX_PATH: ./builds/image-coreos-vagrant.box

    --> BUILD_IMAGE_CMD: ./build-image.sh
```

3ª) Pronto agora vamos executar o projeto **coreos-packer** e gerar uma imagem **"Vagrant Box"**:

```bash
$ ls
build-image.sh  Makefile       packer-templates  pre-provision  README_LANG_EN.md
LICENSE         Makefile.test  packer-variables  README_DOC.md  

$ make plan compile validate build install-box
...
```

PRONTO!!! só isso para gerar uma imagem personalizado do CoreOS para um **"Vagrant Box"**

Resultado semelhante abaixo:
<img alt="print-packer" src="https://github.com/alisonbuss/cluster-coreos-basic-vagrant/raw/master/files/print-coreos-packer.png"/>

### Sucesso!!! \O/

<h2 align="center">
    <i>
        Pronto!!! <br/>
        Agora você tem um ambiente virtual em cluster CoreOS<br/>
        Provisionado pelas ferramentas Packer, Vagrant e Shell Script.
    </i>
</h2>

Resultado final semelhante a imagem abaixo:
<p align="center">
    <img src="https://github.com/alisonbuss/cluster-coreos-basic-vagrant/raw/master/files/print-vagrant-cluster.png" alt="print-vagrant"/>
</p>

### Referências:

* Professor José de Assis - YouTube, Playlist ***Curso - Primeiros passos com Servidor Linux*** <br/>
  Acessado: *Sei lá da pesti, foi em 2017 por ai...* <br/>
  Disponível: *[https://www.youtube.com/playlist?list=PLbEOwbQR9lqy926a_ArLcUL2gHJYuu8XK](https://www.youtube.com/playlist?list=PLbEOwbQR9lqy926a_ArLcUL2gHJYuu8XK)*

* Aula EAD Blog, Curso com José de Assis, ***Primeiros passos com Servidor Linux*** <br/>
  Acessado: *Sei lá da pesti, foi em 2017 por ai...* <br/>
  Disponível: *[http://www.aulaead.com/courses/curso-gratis-servidor-linux](http://www.aulaead.com/courses/curso-gratis-servidor-linux)*

* Vagrant - Official Site, Vagrant Documentation. ***Command-Line Interface*** <br/>
  Acessado: *Sei lá da pesti, foi em 2017 por ai...* <br/>
  Disponível: *[https://www.vagrantup.com/docs/cli/](https://www.vagrantup.com/docs/cli/)*

* Vagrant - Official Site, Vagrant Documentation. ***Vagrantfile*** <br/>
  Acessado: *Sei lá da pesti, foi em 2017 por ai...* <br/>
  Disponível: *[https://www.vagrantup.com/docs/vagrantfile/](https://www.vagrantup.com/docs/vagrantfile/)*

* Yet Emerging Technologies - Blog, by Sébastien Braun. ***CoreOS Container Linux*** <br/>
  Acessado: *Sei lá da pesti, foi em 2018 por ai...* <br/>
  Disponível: *[http://www.yet.org/2017/03/01-container-linux/](http://www.yet.org/2017/03/01-container-linux/)*

* CoreOS - GitHub, Rep: coreos-vagrant. ***Minimal Vagrantfile for Container Linux*** <br/>
  Acessado: *Sei lá da pesti, foi em 2017 por ai...* <br/>
  Disponível: *[https://github.com/coreos/coreos-vagrant/](https://github.com/coreos/coreos-vagrant/)*

* Alison Buss - GitHub, Rep: coreos-kids-vagrant. ***Exemplo de um Vagrantfile subindo varias VM CoreOS sobre uma configuração simples*** <br/>
  Acessado: *Sei lá da pesti, foi em 2017 por ai...* <br/>
  Disponível: *[https://github.com/alisonbuss/coreos-kids-vagrant/](https://github.com/alisonbuss/coreos-kids-vagrant/)*

* Alison Buss - GitHub, Rep: coreos-packer. ***Projeto de criação de imagens CoreOS para múltiplas plataformas (Amazon EC2, Google GCE, DigitalOcean, VirtualBox)*** <br/>
  Acessado: *Sei lá da pesti, foi em 2017 por ai...* <br/>
  Disponível: *[https://github.com/alisonbuss/coreos-packer/](https://github.com/alisonbuss/coreos-packer/)*

* CoreOS - Official Site, CoreOS Documentation. ***Running CoreOS Container Linux on Vagrant*** <br/>
  Acessado: *Sei lá da pesti, foi em 2017 por ai...* <br/>
  Disponível: *[https://coreos.com/os/docs/latest/booting-on-vagrant.html](https://coreos.com/os/docs/latest/booting-on-vagrant.html)*

* CoreOS - Official Site, CoreOS Documentation. ***Container Linux automates machine provisioning with a specialized system for applying initial configuration*** <br/>
  Acessado: *Sei lá da pesti, foi em 2017 por ai...* <br/>
  Disponível: *[https://coreos.com/os/docs/latest/provisioning.html](https://coreos.com/os/docs/latest/provisioning.html)*

* LinuxConfig - Blog, Official Blog. ***How to set/change a hostname on CoreOS Linux*** <br/>
  Acessado: *Sei lá da pesti, foi em 2017 por ai...* <br/>
  Disponível: *[https://linuxconfig.org/how-to-set-change-a-hostname-on-coreos-linux](https://linuxconfig.org/how-to-set-change-a-hostname-on-coreos-linux)*

* CoreOS - Official Site, CoreOS Documentation. ***CoreOS Container Linux cluster discovery*** <br/>
  Acessado: *Sei lá da pesti, foi em 2017 por ai...* <br/>
  Disponível: *[https://coreos.com/os/docs/latest/cluster-discovery.html](https://coreos.com/os/docs/latest/cluster-discovery.html)*

* Etcd - Official Site, Etcd Documentation. ***Clustering Guide - Discovery*** <br/>
  Acessado: *Sei lá da pesti, foi em 2017 por ai...* <br/>
  Disponível: *[https://coreos.com/etcd/docs/latest/op-guide/clustering.html#discovery](https://coreos.com/etcd/docs/latest/op-guide/clustering.html#discovery)*

* CoreOS - Official Site, CoreOS Documentation. ***Customizing docker*** <br/>
  Acessado: *Sei lá da pesti, foi em 2017 por ai...* <br/>
  Disponível: *[https://coreos.com/os/docs/latest/customizing-docker.html](https://coreos.com/os/docs/latest/customizing-docker.html)*

* @mohitarora - Medium Blog, by Mohit Arora. ***Manage Docker Containers using CoreOS - Part 1*** <br/>
  Acessado: *Sei lá da pesti, foi em 2017 por ai...* <br/>
  Disponível: *[https://medium.com/@mohitarora/manage-docker-containers-using-coreos-part-1-c1b401bc0aab](https://medium.com/@mohitarora/manage-docker-containers-using-coreos-part-1-c1b401bc0aab)*

* Yet Emerging Technologies - Blog, by Sébastien Braun. ***rkt - yet emerging container runtime*** <br/>
  Acessado: *Sei lá da pesti, foi em 2017 por ai...* <br/>
  Disponível: *[http://www.yet.org/2017/03/rkt/](http://www.yet.org/2017/03/rkt/)*

* Etcd - Official Site, Etcd Documentation. ***Demo, series of examples shows the basic procedures for working with an etcd cluster*** <br/>
  Acessado: *Sei lá da pesti, foi em 2017 por ai...* <br/>
  Disponível: *[https://coreos.com/etcd/docs/latest/demo.html](https://coreos.com/etcd/docs/latest/demo.html)*

* Etcd - Official Site, Etcd Documentation. ***Clustering Guide*** <br/>
  Acessado: *Sei lá da pesti, foi em 2017 por ai...* <br/>
  Disponível: *[https://coreos.com/etcd/docs/latest/op-guide/clustering.html](https://coreos.com/etcd/docs/latest/op-guide/clustering.html)*

* Etcd2 - Official Site, Etcd2 Documentation. ***Clustering Guide for Etcd2*** <br/>
  Acessado: *Sei lá da pesti, foi em 2017 por ai...* <br/>
  Disponível: *[https://coreos.com/etcd/docs/latest/v2/clustering.html](https://coreos.com/etcd/docs/latest/v2/clustering.html)*

* Etcd - Official Site, Etcd Documentation. ***Etcd cluster runtime reconfiguration on CoreOS Container Linux*** <br/>
  Acessado: *Sei lá da pesti, foi em 2017 por ai...* <br/>
  Disponível: *[https://coreos.com/etcd/docs/latest/etcd-live-cluster-reconfiguration.html](https://coreos.com/etcd/docs/latest/etcd-live-cluster-reconfiguration.html)*

* Flannel - Official Site, Flannel Documentation. ***Running flannel*** <br/>
  Acessado: *Sei lá da pesti, foi em 2017 por ai...* <br/>
  Disponível: *[https://coreos.com/flannel/docs/latest/running.html](https://coreos.com/flannel/docs/latest/running.html)*

* Flannel - Official Site, Flannel Documentation. ***Configuring flannel for container networking*** <br/>
  Acessado: *Sei lá da pesti, foi em 2017 por ai...* <br/>
  Disponível: *[https://coreos.com/flannel/docs/latest/flannel-config.html](https://coreos.com/flannel/docs/latest/flannel-config.html)*

* Flannel - Official Site, Flannel Documentation. ***Configuration - flannel reads its configuration from etcd*** <br/>
  Acessado: *Sei lá da pesti, foi em 2017 por ai...* <br/>
  Disponível: *[https://coreos.com/flannel/docs/latest/configuration.html](https://coreos.com/flannel/docs/latest/configuration.html)*

* CoreOS - GitHub, Rep: flannel, Issue: #554. ***Flannel + etcdv3? #554*** <br/>
  Acessado: *Sei lá da pesti, foi em 2018 por ai...* <br/>
  Disponível: *[https://github.com/coreos/flannel/issues/554](https://github.com/coreos/flannel/issues/554)*

* CoreOS - Official Site, CoreOS Documentation. ***Network configuration with networkd*** <br/>
  Acessado: *Sei lá da pesti, foi em 2017 por ai...* <br/>
  Disponível: *[https://coreos.com/os/docs/latest/network-config-with-networkd.html](https://coreos.com/os/docs/latest/network-config-with-networkd.html)*

* UpCloud - Official Site, Tutorials. ***How to Configure Floating IP on CoreOS*** <br/>
  Acessado: *Sei lá da pesti, foi em 2017 por ai...* <br/>
  Disponível: *[https://www.upcloud.com/support/configure-floating-ip-coreos/](https://www.upcloud.com/support/configure-floating-ip-coreos/)*

### Licença

[<img width="190" src="https://raw.githubusercontent.com/alisonbuss/my-licenses/master/files/logo-open-source-550x200px.png">](https://opensource.org/licenses)
[<img width="166" src="https://raw.githubusercontent.com/alisonbuss/my-licenses/master/files/icon-license-mit-500px.png">](https://github.com/alisonbuss/cluster-coreos-basic-vagrant/blob/master/LICENSE)




























https://vsupalov.com/packer-ami/













## Unstable design !!!

## Status: in development very crazy... rsrsrs ....

# coreos-packer

- basic technology.


- service technology.

http://www.zdnet.com/article/snappy-ubuntu-challenges-coreos-and-project-atomic-on-lightweight-cloud-servers/
https://blog.codeship.com/container-os-comparison/
https://dcos.io/


Entendimento:
https://coreos.com/blog/cluster-osi-model.html


http://virtualelephant.com/2017/11/13/infrastructure-as-code-project-overview/
http://virtualelephant.com/2017/11/14/infrastructure-as-code-bootstrap-coreos-with-ignition/
http://virtualelephant.com/2017/11/16/infrastructure-as-code-understanding-coreos-ignition/
https://vadosware.io/post/installing-python-on-coreos-with-ansible/
http://www.hanymichaels.com/2017/11/02/kubernetes-in-the-enterprise-the-design-guide/




http://bitcubby.com/configuring-vagrant-json-ruby/
https://github.com/tkambler/perfect-vagrant 
https://blog.scottlowe.org/2016/01/18/multi-machine-vagrant-json/ 
https://thornelabs.net/2014/11/13/multi-machine-vagrantfile-with-shorter-cleaner-syntax-using-json-and-loops.html

https://www.tecmint.com/commands-to-collect-system-and-hardware-information-in-linux/

https://grafana.com/

https://5pi.de/2016/11/20/15-producation-grade-kubernetes-cluster/

https://www.youtube.com/watch?v=A760lwRDg9U
https://www.youtube.com/watch?v=C20Ia-OqZt0

https://cloud.google.com/solutions/automated-build-images-with-jenkins-kubernetes

https://cloud.google.com/solutions/jenkins-on-kubernetes-engine#deploying_kubernetes_engine_clusters

https://5pi.de/2016/11/20/15-producation-grade-kubernetes-cluster/

### Projeto de criação de imagens CoreOS para múltiplas plataformas (Amazon EC2, Google GCE, DigitalOcean, VirtualBox).

Inspired by Satoshi Matsumoto [packer-templates](https://github.com/kaorimatz/packer-templates/)

Inspired by wasbazi [coreos-packer](https://github.com/wasbazi/coreos-packer)

Inspired by YungSang [coreos-packer](https://github.com/YungSang/coreos-packer)

Inspired by kevit [coreos-packer](https://github.com/kevit/coreos-packer)

Inspired by [packer-qemu-coreos-container-linux](https://github.com/dyson/packer-qemu-coreos-container-linux)

Inspired by [kubernetes-coreos-packer](https://github.com/stylelab-io/kubernetes-coreos-packer)

Official Documentation: [Packer Documentation](https://www.packer.io/docs/index.html)

Módulos para packer.io, basea-se em um file.json com uma sixtase simples para a moduralização dos "Packer Template". (Modules for packer.io, is based on a file.json with a simple sixtase for the moduralization of "Packer Template".) 

### Referências:

* ChurrOps on DevOps, Blog. ***[Packer] Customizando e automatizando suas imagens – Parte 1***
  Acessado: *17 de Dezembro de 2017*.
  Disponível: *[https://churrops.io/2017/10/13/packer-customizando-e-automatizando-suas-imagens-parte-1/](https://churrops.io/2017/10/13/packer-customizando-e-automatizando-suas-imagens-parte-1/)*.
* Giovanni dos Reis Nunes, Blog. ***Introdução ao Packer***
  Acessado: *17 de Dezembro de 2017*.
  Disponível: *[https://giovannireisnunes.wordpress.com/2016/05/27/introducao-ao-packer/](https://giovannireisnunes.wordpress.com/2016/05/27/introducao-ao-packer/)*.
* Ricardo Martins, Blog. ***Conhecendo o Terraform, Packer e Ansible***
  Acessado: *17 de Dezembro de 2017*.
  Disponível: *[http://www.ricardomartins.com.br/conhecendo-o-terraform-packer-e-ansible/](http://www.ricardomartins.com.br/conhecendo-o-terraform-packer-e-ansible/)*.
* Andre Tadeu, Blog. ***Packer – um breve tutorial***
  Acessado: *17 de Dezembro de 2017*.
  Disponível: *[https://andretdecarvalho.wordpress.com/2014/03/25/packer-um-breve-tutorial/](https://andretdecarvalho.wordpress.com/2014/03/25/packer-um-breve-tutorial/)*.
* CoreOS, Container Linux. ***Using Cloud-Config***
  Acessado: *17 de Dezembro de 2017*.
  Disponível: *[https://coreos.com/os/docs/latest/cloud-config.html](https://coreos.com/os/docs/latest/cloud-config.html)*.
* CoreOS, Container Linux. ***Migrating from Cloud-Config to Container Linux Config***
  Acessado: *17 de Dezembro de 2017*.
  Disponível: *[https://coreos.com/os/docs/latest/migrating-to-clcs.html](https://coreos.com/os/docs/latest/migrating-to-clcs.html)*.
* DigitalOcean, Tutorials. ***How To Secure Your CoreOS Cluster with TLS/SSL and Firewall Rules***
  Acessado: *17 de Dezembro de 2017*.
  Disponível: *[https://www.digitalocean.com/community/tutorials/how-to-secure-your-coreos-cluster-with-tls-ssl-and-firewall-rules](https://www.digitalocean.com/community/tutorials/how-to-secure-your-coreos-cluster-with-tls-ssl-and-firewall-rules)*.
* CoreOS, Container Linux. ***Generate self-signed certificates***
  Acessado: *17 de Dezembro de 2017*.
  Disponível: *[https://coreos.com/os/docs/latest/generate-self-signed-certificates.html](https://coreos.com/os/docs/latest/generate-self-signed-certificates.html)*.
* CoreOS, etcd. ***Enabling HTTPS in an existing etcd cluster***
  Acessado: *17 de Dezembro de 2017*.
  Disponível: *[https://coreos.com/etcd/docs/latest/etcd-live-http-to-https-migration.html](https://coreos.com/etcd/docs/latest/etcd-live-http-to-https-migration.html)*.
* CoreOS, etcd. ***Configure CoreOS Container Linux components to connect to etcd with TLS***
  Acessado: *17 de Dezembro de 2017*.
  Disponível: *[https://coreos.com/etcd/docs/latest/tls-etcd-clients.html](https://coreos.com/etcd/docs/latest/tls-etcd-clients.html)*.
* Swaathi Kakarla, Blog. ***Securing your CoreOS Container***
  Acessado: *17 de Dezembro de 2017*.
  Disponível: *[https://www.twistlock.com/2017/10/16/securing-coreos-container/](https://www.twistlock.com/2017/10/16/securing-coreos-container/)*.
* Matt Carrier, Blog. ***Setup CoreOS with iptables on DigitalOcean***
  Acessado: *17 de Dezembro de 2017*.
  Disponível: *[https://mattcarrier.com/post/core-os-iptables/](https://mattcarrier.com/post/core-os-iptables/)*.
* Jimmy Cuadra, Blog. ***Securing CoreOS with iptables***
  Acessado: *17 de Dezembro de 2017*.
  Disponível: *[https://www.jimmycuadra.com/posts/securing-coreos-with-iptables/](https://www.jimmycuadra.com/posts/securing-coreos-with-iptables/)*.
* Netroby, Blog. ***CoreOS sshd security configure guide***
  Acessado: *17 de Dezembro de 2017*.
  Disponível: *[https://www.netroby.com/view/3814](https://www.netroby.com/view/3814)*.
* KYLE, Blog. ***USING CLOUD CONFIG WITH COREOS***
  Acessado: *17 de Dezembro de 2017*.
  Disponível: *[https://www.programminggoalie.com/cloud-config-coreos-digitalocean/](https://www.programminggoalie.com/cloud-config-coreos-digitalocean/)*.
* Robert, Blog. ***CoreOS Iptables***
  Acessado: *17 de Dezembro de 2017*.
  Disponível: *[http://palex.nl/securing-coreos/](http://palex.nl/securing-coreos/)*
* Skrobul, Blog. ***Deploying CoreOS cluster with etcd secured by TLS/SSL***
  Acessado: *17 de Dezembro de 2017*.
  Disponível: *[http://blog.skrobul.com/securing_etcd_with_tls/](http://blog.skrobul.com/securing_etcd_with_tls/)*.
* gar, Blog. ***CoreOS Etcd and Fleet with Encryption and Authentication***
  Acessado: *17 de Dezembro de 2017*.
  Disponível: *[https://medium.com/@gargar454/coreos-etcd-and-fleet-with-encryption-and-authentication-27ffefd0785c](https://medium.com/@gargar454/coreos-etcd-and-fleet-with-encryption-and-authentication-27ffefd0785c)*.
* Tomasre, Blog. ***Securing CoreOS with Iptables***
  Acessado: *17 de Dezembro de 2017*.
  Disponível: *[http://tomasre.com/2016/03/07/securing-coreos-with-iptables/](http://tomasre.com/2016/03/07/securing-coreos-with-iptables/)*.
* BLAZED’S TECH, Blog. ***CoreOS, Iptables and Vulcand***
  Acessado: *17 de Dezembro de 2017*.
  Disponível: *[https://darkstar.se/2015/02/06/coreos-iptables-and-vulcand/](https://darkstar.se/2015/02/06/coreos-iptables-and-vulcand/)*.


https://github.com/kelseyhightower/kubestack/blob/master/packer/kubestack.json

https://github.com/ainoya/aws-coreos-clustering-kit/

https://github.com/cloudurable/cassandra-image/wiki/Using-Packer-to-create-an-AMI-for-Amazon---EC2
https://github.com/cloudurable/cassandra-image

https://github.com/dyson/packer-qemu-coreos-container-linux

https://github.com/stylelab-io/kubernetes-coreos-packer

https://github.com/brikis98/terraform-up-and-running-code

https://github.com/kaorimatz/packer-templates/

https://github.com/wasbazi/coreos-packer

https://github.com/kevit/coreos-packer

https://github.com/flomotlik/packer-example

http://www.codedependant.net/2016/06/29/coreos-a-year-in-review/

https://www.infoq.com/br/search.action?queryString=API+Gateway&page=1&searchOrder=&sst=KYiYsc1qHfkIyyf8

http://gutocarvalho.net/blog/2016/09/06/por-onde-iniciar-os-estudos-sobre-devops/
https://www.alura.com.br/carreira-engenheiro-devops
https://dev9.com/blog-posts/2016/6/introduction-to-kong-api-gateway
https://www.nginx.com/blog/microservices-api-gateways-part-1-why-an-api-gateway/
https://www.nginx.com/blog/microservices-api-gateways-part-2-how-kong-can-help/

USAR ESSE AKI
https://konghq.com/kong-community-edition/
https://pantsel.github.io/konga/
https://pantsel.github.io/konga/
https://gravitee.io/
http://wicked.haufe.io/
https://www.fusio-project.org/
http://www.apiman.io/latest/index.html

https://sensedia.com/blog/apis/owasp-2017-top-10-riscos-seguranca-apis/

https://dev9.com/blog-posts/2016/6/introduction-to-kong-api-gateway

É AKI AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA........
https://dev9.com/blog-posts/2016/6/introduction-to-kong-api-gateway
https://konghq.com/blog/protecting-rate-limiting-api-kong/

https://github.com/upmc-enterprises/kubernetes-secret-manager
https://github.com/coreos/awesome-kubernetes-extensions

https://www.youtube.com/watch?v=h4A8HytL5ts

https://tyk.io/#section-0

https://www.gluu.org/

http://www.codedependant.net/2016/06/29/coreos-a-year-in-review/

https://getkong.org/
https://pantsel.github.io/konga/
https://ajaysreedhar.github.io/kongdash/
https://medium.com/@aodjaturongvachirasaksakul/kong-free-api-gateway-28edc64f7b6e

https://github.com/coreos/awesome-kubernetes-extensions

https://apiumbrella.io/

http://www.codedependant.net/2016/06/29/coreos-a-year-in-review/


https://github.com/julienstroheker/DCOS-Azure/blob/master/packer/packer/packer.json
https://docs.microsoft.com/en-us/azure/virtual-machines/linux/build-image-with-packer
https://github.com/squasta/PackerAzureRM/blob/master/Packer-VMWin2016StanAzureBasicManagedDisk.json
https://github.com/squasta/PackerAzureRM/blob/master/Packer-VMWin2016-IIS-Azure-squasta.json
https://github.com/squasta/PackerAzureRM

https://github.com/hashicorp/packer/tree/master/examples/azure


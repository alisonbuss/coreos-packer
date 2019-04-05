

#### Translation for: **[English](https://github.com/alisonbuss/coreos-packer/blob/master/README_LANG_EN.md)**.

#### Status do Projeto: *(Está em processo de refatoração)*.

<h2 align="center">
    Projeto de criação de imagens CoreOS <br/> para múltiplas plataformas <br/>(Amazon EC2, Google GCE, DigitalOcean, VirtualBox)
</h2>

### Inspirado nos projetos:

* **[[coreos-packer](https://github.com/wasbazi/coreos-packer)]** - por Wasbazi.
* **[[coreos-packer](https://github.com/YungSang/coreos-packer)]** - por Yung Sang.
* **[[coreos-packer](https://github.com/kevit/coreos-packer)]** - por Sergey Karatkevich.
* **[[kubernetes-coreos-packer](https://github.com/stylelab-io/kubernetes-coreos-packer)]** - por StyleLounge Lab.
* **[[packer-templates](https://github.com/kaorimatz/packer-templates)]** por Satoshi Matsumoto.
* **[[packer-qemu-coreos-container-linux](https://github.com/dyson/packer-qemu-coreos-container-linux)]** - por Dyson Simmons.
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

### Plataformas Suportadas:

  - **[Digital Ocean]** - :x: *Não Implementado...*
  - **[Amazon EC2 AMI]** - :x: *Não Implementado...*
  - **[VirtualBox e Vagrant Box]** - :heavy_check_mark: *Implementado.*
  - **[Google Cloud Compute Engine (GCE)]** - :x: *Não Implementado...*

### Imagem Packer: 

  - **CoreOS Stable 1688.5.3**
    - kernel: v4.16.3
    - systemd: v238
    - ignition: v0.24.0
    - rkt: v1.30.0
    - docker: v18.04.0
    - docker-compose: v1.19.0
    - etcd v2.3.8
    - etcd v3.2.15
    - flannel v0.10.0
    - active-python: v2.7.13

Para o pré-provisionamento básico da imagem CoreOS, será através dos arquivos de **Shell Script**:

    ./pre-provision/shell-script/download-support-files.sh
    ./pre-provision/shell-script/install-python.sh
    ./pre-provision/shell-script/install-rkt.sh
    ./pre-provision/shell-script/install-docker.sh
    ./pre-provision/shell-script/install-docker-compose.sh
    ./pre-provision/shell-script/install-etcd.sh
    ./pre-provision/shell-script/install-flannel.sh
    ./pre-provision/shell-script/provide-basic-security.sh
    ./pre-provision/shell-script/provide-image-finalization.sh

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
|   |   ├── download-support-files.sh
│   │   ├── install-docker-compose.sh
│   │   ├── install-docker.sh
│   │   ├── install-etcd.sh
│   │   ├── install-flannel.sh
│   │   ├── install-python.sh
│   │   ├── install-rkt.sh
│   │   ├── provide-basic-security.sh
│   │   └── provide-image-finalization.sh
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


### Executando o projeto "[coreos-packer](https://github.com/alisonbuss/coreos-packer/)".

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

3ª) Pronto agora vamos executar o projeto **coreos-packer** e gerar uma imagem e o **"Vagrant Box"**:

```bash
$ ls
build-image.sh  Makefile       packer-templates  pre-provision  README_LANG_EN.md
LICENSE         Makefile.test  packer-variables  README_DOC.md  

$ make plan compile validate build install-box
...
```

PRONTO!!! só isso para gerar uma imagem personalizado do CoreOS com um **"Vagrant Box"**

Resultado semelhante abaixo:
<img alt="print-packer" src="https://github.com/alisonbuss/cluster-coreos-basic-vagrant/raw/master/files/print-coreos-packer.png"/>

### Sucesso!!! \O/

<h2 align="center">
    <i>
        Pronto!!! <br/>
        Agora você tem uma imagem personalizada CoreOS<br/>
        Provisionado pela ferramenta Packer e Shell Script.
    </i>
</h2>

### Referências:


    "_comment": "Missing the implementation for this platform!!!",
    "_font01": "https://medium.com/the-andela-way/building-custom-machine-images-with-packer-a21c6d932bf6",
    "_font02": "https://cloud.google.com/video-intelligence/docs/common/auth",
    "_font02": "https://cloud.google.com/compute/docs/machine-types?hl=pt-br",


* Packer - Official Site, Packer Documentation. ***Welcome to the Packer documentation!*** <br/>
  Acessado: *Sei lá da pesti, foi em 2017 por ai...* <br/>
  Disponível: *[https://www.packer.io/docs/index.html](https://www.packer.io/docs/index.html)*

* Packer - Official Site, Packer Documentation. ***Template Communicators*** <br/>
  Acessado: *Sei lá da pesti, foi em 2018 por ai...* <br/>
  Disponível: *[https://www.packer.io/docs/templates/communicator.html](https://www.packer.io/docs/templates/communicator.html)*

* Packer - Official Site, Packer Documentation. ***VirtualBox Builder (from an ISO)*** <br/>
  Acessado: *Sei lá da pesti, foi em 2018 por ai...* <br/>
  Disponível: *[https://www.packer.io/docs/builders/virtualbox-iso.html](https://www.packer.io/docs/builders/virtualbox-iso.html)*

* Professor José de Assis - YouTube, Playlist ***Curso - Primeiros passos com Servidor Linux*** <br/>
  Acessado: *Sei lá da pesti, foi em 2017 por ai...* <br/>
  Disponível: *[https://www.youtube.com/playlist?list=PLbEOwbQR9lqy926a_ArLcUL2gHJYuu8XK](https://www.youtube.com/playlist?list=PLbEOwbQR9lqy926a_ArLcUL2gHJYuu8XK)*

* Aula EAD Blog, Curso com José de Assis, ***Primeiros passos com Servidor Linux*** <br/>
  Acessado: *Sei lá da pesti, foi em 2017 por ai...* <br/>
  Disponível: *[http://www.aulaead.com/courses/curso-gratis-servidor-linux](http://www.aulaead.com/courses/curso-gratis-servidor-linux)*

* Vagrant - Official Site, Vagrant Documentation. ***Command-Line Interface*** <br/>
  Acessado: *Sei lá da pesti, foi em 2017 por ai...* <br/>
  Disponível: *[https://www.vagrantup.com/docs/cli/](https://www.vagrantup.com/docs/cli/)*

* Yet Emerging Technologies - Blog, by Sébastien Braun. ***CoreOS Container Linux*** <br/>
  Acessado: *Sei lá da pesti, foi em 2018 por ai...* <br/>
  Disponível: *[http://www.yet.org/2017/03/01-container-linux/](http://www.yet.org/2017/03/01-container-linux/)*

* ChurrOps on DevOps, Blog. ***Customizando e automatizando suas imagens - Parte 1*** <br/>
  Acessado: *17 de Dezembro de 2017*. <br/>
  Disponível: *[https://churrops.io/2017/10/13/packer-customizando-e-automatizando-suas-imagens-parte-1/](https://churrops.io/2017/10/13/packer-customizando-e-automatizando-suas-imagens-parte-1/)*.

* Giovanni dos Reis Nunes, Blog. ***Introdução ao Packer*** <br/>
  Acessado: *17 de Dezembro de 2017*. <br/>
  Disponível: *[https://giovannireisnunes.wordpress.com/2016/05/27/introducao-ao-packer/](https://giovannireisnunes.wordpress.com/2016/05/27/introducao-ao-packer/)*.

* Ricardo Martins, Blog. ***Conhecendo o Terraform, Packer e Ansible*** <br/>
  Acessado: *17 de Dezembro de 2017*. <br/>
  Disponível: *[http://www.ricardomartins.com.br/conhecendo-o-terraform-packer-e-ansible/](http://www.ricardomartins.com.br/conhecendo-o-terraform-packer-e-ansible/)*.

* Andre Tadeu, Blog. ***Packer – um breve tutorial*** <br/>
  Acessado: *17 de Dezembro de 2017*. <br/>
  Disponível: *[https://andretdecarvalho.wordpress.com/2014/03/25/packer-um-breve-tutorial/](https://andretdecarvalho.wordpress.com/2014/03/25/packer-um-breve-tutorial/)*.

* kelseyhightower - GitHub, By Kelsey Hightower. ***Manage Kubernetes with Packer and Terraform on Google Compute Engine.*** <br/>
  Acessado: *Sei lá da pesti, foi em 2017 por ai...* <br/>
  Disponível: *[https://github.com/kelseyhightower/kubestack](https://github.com/kelseyhightower/kubestack)*.

* CoreOS, Container Linux. ***Using Cloud-Config*** <br/>
  Acessado: *17 de Dezembro de 2017*. <br/>
  Disponível: *[https://coreos.com/os/docs/latest/cloud-config.html](https://coreos.com/os/docs/latest/cloud-config.html)*.

* CoreOS, Container Linux. ***Migrating from Cloud-Config to Container Linux Config*** <br/>
  Acessado: *17 de Dezembro de 2017*. <br/>
  Disponível: *[https://coreos.com/os/docs/latest/migrating-to-clcs.html](https://coreos.com/os/docs/latest/migrating-to-clcs.html)*.

* Matt Carrier, Blog. ***Setup CoreOS with iptables on DigitalOcean*** <br/>
  Acessado: *17 de Dezembro de 2017*. <br/>
  Disponível: *[https://mattcarrier.com/post/core-os-iptables/](https://mattcarrier.com/post/core-os-iptables/)*.

* Jimmy Cuadra, Blog. ***Securing CoreOS with iptables*** <br/>
  Acessado: *17 de Dezembro de 2017*. <br/>
  Disponível: *[https://www.jimmycuadra.com/posts/securing-coreos-with-iptables/](https://www.jimmycuadra.com/posts/securing-coreos-with-iptables/)*.

* Netroby, Blog. ***CoreOS sshd security configure guide*** <br/>
  Acessado: *17 de Dezembro de 2017*. <br/>
  Disponível: *[https://www.netroby.com/view/3814](https://www.netroby.com/view/3814)*.

* KYLE, Blog. ***USING CLOUD CONFIG WITH COREOS*** <br/>
  Acessado: *17 de Dezembro de 2017*. <br/>
  Disponível: *[https://www.programminggoalie.com/cloud-config-coreos-digitalocean/](https://www.programminggoalie.com/cloud-config-coreos-digitalocean/)*.

* Robert, Blog. ***CoreOS Iptables*** <br/>
  Acessado: *17 de Dezembro de 2017*. <br/>
  Disponível: *[http://palex.nl/securing-coreos/](http://palex.nl/securing-coreos/)*

* Tomasre, Blog. ***Securing CoreOS with Iptables*** <br/>
  Acessado: *17 de Dezembro de 2017*. <br/>
  Disponível: *[http://tomasre.com/2016/03/07/securing-coreos-with-iptables/](http://tomasre.com/2016/03/07/securing-coreos-with-iptables/)*.

* BLAZED’S TECH, Blog. ***CoreOS, Iptables and Vulcand*** <br/>
  Acessado: *17 de Dezembro de 2017*. <br/>
  Disponível: *[https://darkstar.se/2015/02/06/coreos-iptables-and-vulcand/](https://darkstar.se/2015/02/06/coreos-iptables-and-vulcand/)*.

* Vladislav Supalov, Blog. ***Using Packer to Build Custom AWS AMIs in Different Regions*** <br/>
  Acessado: *Sei lá da pesti, foi em 2017 por ai...* <br/>
  Disponível: *[https://vsupalov.com/packer-ami/](https://vsupalov.com/packer-ami/)*.

* CoreOS Blog, By Barak Michener. ***What makes a cluster a cluster?*** <br/>
  Acessado: *Sei lá da pesti, foi em 2017 por ai...* <br/>
  Disponível: *[https://coreos.com/blog/cluster-osi-model.html](https://coreos.com/blog/cluster-osi-model.html)*.

* Virtual Elephant Blog, By Chris. ***Infrastructure-as-Code: Project Overview*** <br/>
  Acessado: *Sei lá da pesti, foi em 2017 por ai...* <br/>
  Disponível: *[http://virtualelephant.com/2017/11/13/infrastructure-as-code-project-overview/](http://virtualelephant.com/2017/11/13/infrastructure-as-code-project-overview/)*.

* vadosware.io - Blog, By Vados. ***INSTALLING PYTHON ON COREOS WITH ANSIBLE (TO ENABLE ANSIBLE)*** <br/>
  Acessado: *Sei lá da pesti, foi em 2017 por ai...* <br/>
  Disponível: *[https://vadosware.io/post/installing-python-on-coreos-with-ansible/](https://vadosware.io/post/installing-python-on-coreos-with-ansible/)*.

* Virtual Elephant Blog, By Chris. ***Infrastructure-as-Code: Project Overview*** <br/>
  Acessado: *Sei lá da pesti, foi em 2017 por ai...* <br/>
  Disponível: *[http://virtualelephant.com/2017/11/13/infrastructure-as-code-project-overview/](http://virtualelephant.com/2017/11/13/infrastructure-as-code-project-overview/)*.

* Google Compute Engine, Tutorial. ***Criação automatizada de imagens com Jenkins, Packer e Kubernetes*** <br/>
  Acessado: *Sei lá da pesti, foi em 2017 por ai...* <br/>
  Disponível: *[https://cloud.google.com/solutions/automated-build-images-with-jenkins-kubernetes](https://cloud.google.com/solutions/automated-build-images-with-jenkins-kubernetes)*.

* Julien Stroheker - GitHub, Rep: DCOS-Azure. ***Terraform Script to deploy a DC/OS 1.9 Cluster running on CoreOS*** <br/>
  Acessado: *Sei lá da pesti, foi em 2017 por ai...* <br/>
  Disponível: *[https://github.com/julienstroheker/DCOS-Azure](https://github.com/julienstroheker/DCOS-Azure)*.

* Stanislas Quastana - GitHub, Rep: PackerAzureRM. ***Examples to create Azure VM Images with Packer*** <br/>
  Acessado: *Sei lá da pesti, foi em 2017 por ai...* <br/>
  Disponível: *[https://github.com/squasta/PackerAzureRM/](https://github.com/squasta/PackerAzureRM/)*.

### Licença

[<img width="190" src="https://raw.githubusercontent.com/alisonbuss/my-licenses/master/files/logo-open-source-550x200px.png">](https://opensource.org/licenses)
[<img width="166" src="https://raw.githubusercontent.com/alisonbuss/my-licenses/master/files/icon-license-mit-500px.png">](https://github.com/alisonbuss/coreos-packer/blob/master/LICENSE)


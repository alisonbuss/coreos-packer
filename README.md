
## Unstable design !!!

## Status: in development very crazy... rsrsrs ....

# coreos-packer

http://virtualelephant.com/2017/11/13/infrastructure-as-code-project-overview/
http://virtualelephant.com/2017/11/14/infrastructure-as-code-bootstrap-coreos-with-ignition/
http://virtualelephant.com/2017/11/16/infrastructure-as-code-understanding-coreos-ignition/
https://vadosware.io/post/installing-python-on-coreos-with-ansible/
http://www.hanymichaels.com/2017/11/02/kubernetes-in-the-enterprise-the-design-guide/




http://bitcubby.com/configuring-vagrant-json-ruby/
https://github.com/tkambler/perfect-vagrant 
https://blog.scottlowe.org/2016/01/18/multi-machine-vagrant-json/ 
https://thornelabs.net/2014/11/13/multi-machine-vagrantfile-with-shorter-cleaner-syntax-using-json-and-loops.html


https://grafana.com/

https://5pi.de/2016/11/20/15-producation-grade-kubernetes-cluster/

https://www.youtube.com/watch?v=A760lwRDg9U
https://www.youtube.com/watch?v=C20Ia-OqZt0

https://cloud.google.com/solutions/automated-build-images-with-jenkins-kubernetes

https://cloud.google.com/solutions/jenkins-on-kubernetes-engine#deploying_kubernetes_engine_clusters

https://5pi.de/2016/11/20/15-producation-grade-kubernetes-cluster/

### Projeto de criação de imagens CoreOS para múltiplas plataformas (Azure, Amazon EC2, Google GCE, DigitalOcean, Docker, VirtualBox).

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


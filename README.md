
# coreos-packer

### Projeto de criação de imagens CoreOS para múltiplas plataformas (Azure, Amazon EC2, Google GCE, DigitalOcean, Docker, VirtualBox).

Inspired by Satoshi Matsumoto [packer-templates](https://github.com/kaorimatz/packer-templates/)

Inspired by wasbazi [coreos-packer](https://github.com/wasbazi/coreos-packer)

Inspired by YungSang [coreos-packer](https://github.com/YungSang/coreos-packer)

Inspired by kevit [coreos-packer](https://github.com/kevit/coreos-packer)

Inspired by [packer-qemu-coreos-container-linux](https://github.com/dyson/packer-qemu-coreos-container-linux)

Inspired by [kubernetes-coreos-packer](https://github.com/stylelab-io/kubernetes-coreos-packer)

Official Documentation: [Packer Documentation](https://www.packer.io/docs/index.html)





## Unstable design !!!

## Status: in development very crazy... rsrsrs ....





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




# Implementação Multi-Container
  Implementação oficial sugerida pela documentação [https://www.elastic.co/](https://www.elastic.co/guide/en/elastic-stack-get-started/8.2/get-started-stack-docker.html#get-started-docker-tls).

### Base de conhecimento
- [Site ELK with Docker](https://www.docker.elastic.co/)
- [Doc ELK installation with Docker](https://www.elastic.co/guide/en/elasticsearch/reference/8.4/docker.html)
- [Fleet Elastic Agent Doc](https://www.elastic.co/guide/en/fleet/8.4/add-a-fleet-server.html)
- [Github ELK oficial](https://github.com/elastic)
- [YouTUBE ELK oficial](https://www.youtube.com/c/OfficialElasticCommunity)
### Images:
  v 8.2.3 (estável)
  - [Elasticsearch 8.4.3](https://www.docker.elastic.co/r/elasticsearch)
  - [Kibana 8.4.3](https://www.docker.elastic.co/r/kibana)

### Configurações customizadas
Para adicionar configurações customizadas seja ao Elasticsearch ou Kibana, deve-se adicionar um bind nos **volumes** para os referidos caminhos, usando sempre um ficheiro yaml com as respetivas configs:
- Elasticseach: 
```console
  - ./es01.yml:/usr/share/elasticsearch/config/elasticsearch.yml
```
- Kibana: 
```console
  - ./kibana.yml:/usr/share/kibana/config/kibana.yml
```

### Instalação do Elastic Agent
Primeiro deve-se provisionar o *Elastic Agent* através do integration no Kibana, após isso fazer o [download](https://www.elastic.co/pt/downloads/past-releases/elastic-agent-8-4-3) arquivo compactado **tar** de instalação do *Elastic Agent* e então descompactar o mesmo. Tembém é possível fazer o passo de download através de CLI, para maiores informações verificar [documentação de instalação](https://www.elastic.co/guide/en/fleet/8.4/install-standalone-elastic-agent.html) e [documentação de ](https://www.elastic.co/guide/en/fleet/8.4/create-standalone-agent-policy.html) referente ao tema.
- #### Exemplo do processo via CLI
```console
curl -L -O https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-8.4.3-linux-x86_64.tar.gz
tar xzvf elastic-agent-8.4.3-linux-x86_64.tar.gz
cd elastic-agent-8.4.3-linux-x86_64
sudo ./elastic-agent install
```
### Para desinstalar um *Elastic Agent* 
```console
$ cd /opt/Elastic/Agent
$ elastic-agent uninstall
```
- Importante perceber que para cada *Elastic Agent* deve haver um *Agent Policy*

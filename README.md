# Implementação Multi-Container
  Implementação oficial sugerida pela documentação [https://www.elastic.co/](https://www.elastic.co/guide/en/elastic-stack-get-started/8.2/get-started-stack-docker.html#get-started-docker-tls).

## APIKEYs Testes
ex.: *Authorization: ApiKey VTRscUNZUUJtVVF1TVdxYTVpV186TlgzbjlnR1RTX09zb0ZxLUpkckJlUQ==*  
  
FLEET API KEY  `bW1ETkRvUUJDUUh3Ymk2cGhtVDI6U2RGM0lYMkZRQnVrMkRtclhDclJfdw==`  
VB POC APP KEY : `c1VVSVBvUUJNOU9kMWlQaUhQdlU6M3VUX0NFSjRRdUcwcDhELXItMlN3dw==`

## Base de conhecimento
- [Requerimento de hardware](https://www.elastic.co/guide/en/cloud-enterprise/current/ece-hardware-prereq.html)
- [Site ELK with Docker](https://www.docker.elastic.co/)
- [Doc ELK installation with Docker](https://www.elastic.co/guide/en/elasticsearch/reference/8.4/docker.html)
- [Fleet Elastic Agent Doc](https://www.elastic.co/guide/en/fleet/8.4/add-a-fleet-server.html)
- [Github ELK oficial](https://github.com/elastic)
- [YouTUBE ELK oficial](https://www.youtube.com/c/OfficialElasticCommunity)
- [Capacidades do Beats e Elastic Agent](https://www.elastic.co/guide/en/fleet/current/beats-agent-comparison.html)
- [Fleet Server on-premises](https://www.elastic.co/guide/en/fleet/current/add-a-fleet-server.html#deployed-on-prem)
- [Configurações de segurança ELK](https://www.elastic.co/guide/en/elasticsearch/reference/current/security-settings.html)
- [Elastic Agent comandos e referências](https://www.elastic.co/guide/en/fleet/current/elastic-agent-cmd-options.html)
- [Criar certificados(CA) para self-managed fleet server](https://www.elastic.co/guide/en/fleet/8.4/secure-connections.html)
- [Doc. APM Beat](https://www.elastic.co/guide/en/apm/guide/8.4/apm-components.html)
- [Kibana Configuração de Alertas](https://www.elastic.co/guide/en/kibana/8.4/alert-action-settings-kb.html#action-settings)
- [Kibana chaves encriptação e decriptação (alertas e ações)](https://www.elastic.co/guide/en/kibana/8.4/xpack-security-secure-saved-objects.html#encryption-key-rotation)
## Images:
  v 8.4.3 (estável)
  - [Elasticsearch 8.4.3](https://www.docker.elastic.co/r/elasticsearch)
  - [Kibana 8.4.3](https://www.docker.elastic.co/r/kibana)

## > Configurações customizadas
Para adicionar configurações customizadas seja ao Elasticsearch ou Kibana, deve-se adicionar um bind nos **volumes** para os referidos caminhos, usando sempre um ficheiro yaml com as respetivas configs:
- Elasticseach: 
```console
  - ./es01.yml:/usr/share/elasticsearch/config/elasticsearch.yml
```
- Kibana: 
```console
  - ./kibana.yml:/usr/share/kibana/config/kibana.yml
```
## > Copiar certificados para máquina host
Após cópia de certificados para máquina host, se deve adicionar o CA as configurações de output na Fleet através da UI no Kibana.
```console
docker cp <docker-id or name>:/usr/share/elasticsearch/config/certs/ .
```
## > Instalação do Fleet Server / Elastic Agent
Deve-se fazer o deploy de um *Elastic Agent* com um *Beat* fleet-server. Este será um agregador de dados para casos de monitoramento de vários hosts, os demais **Agents** serão reunidos nesta Fleet. Vale realçar que o *Elastic Agent* é uma aplicação capaz de agregar diversos *Beats*, de forma que o *Elastic Agent* que fez deploy do fleet-server também pode monitorizar o respetivo host em que está com a adição de mais *Integrations*.  
- Adicionar CA na configuração de output na Fleet através da UI Kibana
`fleet->settings`

- Exemplo de instalação: *Elastic Agent* em método **Advanced** com fleet-server
```bash
curl -L -O https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-8.4.3-amd64.deb
sudo dpkg -i elastic-agent-8.4.3-amd64.deb
sudo elastic-agent enroll \
  --fleet-server-es-insecure \
  --fleet-server-es=https://localhost:9200 \
  --fleet-server-service-token=AAEAAWVsYXN0aWMvZmxlZXQtc2VydmVyL3Rva2VuLTE2NjY3MDAwMDY4NTM6MUQ3Z09xSzNUSnk1UGQ1SWlrN2pHQQ \
  --fleet-server-policy=3c28f6d0-545e-11ed-beb2-d70086079f16
sudo systemctl enable elastic-agent
sudo systemctl start elastic-agent

```
-  Para dar comandos a um *Elastic Agent* instalado através de enroll 
```console
$ cd /var/lib/elastic-agent/data/<elastic-agent-directory>
$ elastic-agent uninstall
```

## > Exemplo de instalação: *Elastic Agent* com **APM-server** em Windows conectado ao fleet-server
```powershell
  $ProgressPreference = 'SilentlyContinue'
  Invoke-WebRequest -Uri https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-8.4.3-windows-x86_64.zip -OutFile elastic-agent-8.4.3-windows-x86_64.zip
  Expand-Archive .\elastic-agent-8.4.3-windows-x86_64.zip -DestinationPath .
  cd elastic-agent-8.4.3-windows-x86_64
  .\elastic-agent.exe install --insecure --url=https://<Address>:8220 --enrollment-token=QklLUkQ0UUJ1SWRIRkdMZ0VITDI6UWI1cENMWHZTOVdKNm1ZSDR1WjdjZw==
```
- Ter em atenção que a tag *--insecure* deve ser usada quando há **fleet-server** com CA self-signed. No ambiente de produção deve-se informar a *fleet-server.key* e *fleet-server.crt* criado com o *ca.crt*, para que este certificado seja apontado durante o deploy do *Elastic-Agent* que fará a monitoria das aplicações.



# Workarounds
- Fleet Server - Error - x509: certificate signed by unknown authority

Para contornar este problema precisamos apontar o caminho absoluto do certificado durante a instalação. [Base de referência](https://discuss.elastic.co/t/cannot-install-fleet-server/274764)
```console
--fleet-server-es-ca=<absolute path ca.crt>
```
- Shards pendentes (dados não gravados no Elastic)  
A principal causa disso é armazenamento acima dos 85%. A stack Elastic impede a gravação de novos dados e cria uma pool para além de emitir alertas na UI quanto a shards pendentes de integração. Como solução devemos liberar espaço em disco.  

- Problema na limitação de memória para os containers: `max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]`  
em caso de reinicialização da máquina, a informação é perdida.
  - Windows
  ```console
  wsl -d docker-desktop
  sysctl -w vm.max_map_count=262144
  ```
  - Linux  
  Para persistência desta informação, deve-se alterar este parâmetro em `/etc/sysctl.conf` e reiniciar o serviço docker `systemctl restart docker`
  ```console
  sysctl -w vm.max_map_count=262144
  systemctl restart docker
  ```  

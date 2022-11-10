sudo elastic-agent enroll \
  --fleet-server-es=https://192.168.2.148:9200 \
    --fleet-server-service-token=AAEAAWVsYXN0aWMvZmxlZXQtc2VydmVyL3Rva2VuLTE2NjY3MDg2OTM5MjA6SnEyaEhQaDlRNDJsQkozekpsWjY1Zw \
    --fleet-server-es-insecure \
      --fleet-server-policy=fleet-server-policy


sudo elastic-agent install \
	  --fleet-server-es=https://192.168.2.148:9200 \
	      --fleet-server-service-token=AAEAAWVsYXN0aWMvZmxlZXQtc2VydmVyL3Rva2VuLTE2NjY3MDg2OTM5MjA6SnEyaEhQaDlRNDJsQkozekpsWjY1Zw \
	          --fleet-server-es-insecure \
		        --fleet-server-policy=fleet-server-policy
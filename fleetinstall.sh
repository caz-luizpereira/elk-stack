sudo elastic-agent enroll \
  --fleet-server-es=https://192.168.2.138:9200 \
    --fleet-server-service-token=AAEAAWVsYXN0aWMvZmxlZXQtc2VydmVyL3Rva2VuLTE2NjgxNzAyMzg2ODY6aGh5UmRXcl9Sdm1UOWRfamQ3VTdDZw \
    --fleet-server-es-insecure \
      --fleet-server-policy=fleet-server-policy


sudo elastic-agent install \
	  --fleet-server-es=https://192.168.2.138:9200 \
	      --fleet-server-service-token=AAEAAWVsYXN0aWMvZmxlZXQtc2VydmVyL3Rva2VuLTE2NjgxNzAyMzg2ODY6aGh5UmRXcl9Sdm1UOWRfamQ3VTdDZw \
	          --fleet-server-es-insecure \
		        --fleet-server-policy=fleet-server-policy
#update
sudo apt update
#install java
sudo apt install openjdk-21-jre-headless -y

#install nginx
sudo apt install nginx -y

#install elasticsearch
sudo curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch |sudo gpg --dearmor -o /usr/share/keyrings/elastic.gpg
sudo echo "deb [signed-by=/usr/share/keyrings/elastic.gpg] https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt update
sudo apt install elasticsearch -y
sudo echo "network.host: localhost" | sudo tee -a /etc/elasticsearch/elasticsearch.yml
sudo systemctl start elasticsearch
sudo systemctl enable elasticsearch
sudo curl -X GET "localhost:9200"

#install Kibana
sudo apt install kibana -y
sudo systemctl enable kibana
sudo systemctl start kibana
# echo "kibanaadmin:`openssl passwd -apr1`" | sudo tee -a /etc/nginx/htpasswd.users
sudo tee /etc/nginx/sites-available/kibana.nasir.id > /dev/null << 'EOT'
server {
    listen 80;
    server_name kibana.nasir.id;
    # auth_basic "Restricted Access";
    # auth_basic_user_file /etc/nginx/htpasswd.users;
    location / {
        proxy_pass http://localhost:5601;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
EOT
sudo ln -s /etc/nginx/sites-available/kibana.nasir.id /etc/nginx/sites-enabled/kibana.nasir.id
sudo nginx -t
sudo systemctl reload nginx

#install logstash
sudo apt install logstash -y
sudo tee /etc/logstash/conf.d/02-beats-input.conf > /dev/null << 'EOT'
input {
  beats {
    port => 5044
  }
}
EOT

# install logstatsh
sudo apt install logstash -y
sudo tee /etc/logstash/conf.d/02-beats-input.conf > /dev/null << 'EOT'
input {
  beats {
    port => 5044
  }
}
EOT
sudo tee /etc/logstash/conf.d/30-elasticsearch-output.conf > /dev/null << 'EOT'
output {
  if [@metadata][pipeline] {
	elasticsearch {
  	hosts => ["localhost:9200"]
  	manage_template => false
  	index => "%{[@metadata][beat]}-%{[@metadata][version]}-%{+YYYY.MM.dd}"
  	pipeline => "%{[@metadata][pipeline]}"
	}
  } else {
	elasticsearch {
  	hosts => ["localhost:9200"]
  	manage_template => false
  	index => "%{[@metadata][beat]}-%{[@metadata][version]}-%{+YYYY.MM.dd}"
	}
  }
}
EOT
sudo -u logstash /usr/share/logstash/bin/logstash --path.settings /etc/logstash -t
sudo systemctl start logstash
sudo systemctl enable logstash

# install filebeat
sudo apt install filebeat -y
sudo sed -i 's/output.elasticsearch:/\#output.elasticsearch:/; s/hosts: \["localhost:9200"\]/\#hosts: \["localhost:9200"\]/; s/\#output.logstash:/output.logstash:/; s/\#hosts: \["localhost:5044"\]/hosts: \["localhost:5044"\]/' /etc/filebeat/filebeat.yml
sudo filebeat modules enable system
sudo filebeat modules list
sudo filebeat setup --pipelines --modules system
sudo filebeat setup --index-management -E output.logstash.enabled=false -E 'output.elasticsearch.hosts=["localhost:9200"]'
sudo filebeat setup -E output.logstash.enabled=false -E output.elasticsearch.hosts=['localhost:9200'] -E setup.kibana.host=localhost:5601
sudo systemctl start filebeat
sudo systemctl enable filebeat
sudo curl -XGET 'http://localhost:9200/filebeat-*/_search?pretty'
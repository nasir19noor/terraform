sudo apt update
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-8.x.list
sudo apt update
sudo apt install filebeat -y
sudo sed -i "s/output.elasticsearch:/\#output.elasticsearch:/; s/hosts: \[\"localhost:9200\"\]/\#hosts: \[\"localhost:9200\"\]/; s/\#output.logstash:/output.logstash:/; s/\#hosts: \[\"localhost:5044\"\]/hosts: \[\"34.124.239.173:5044\"\]/" /etc/filebeat/filebeat.yml
sudo filebeat modules enable system
sudo filebeat modules list
sudo filebeat setup --pipelines --modules system
sudo filebeat setup --pipelines -e
sudo filebeat setup --index-management -E output.logstash.enabled=false -E "output.elasticsearch.hosts=[\"34.124.239.173:9200\"]"
sudo filebeat setup -E output.logstash.enabled=false -E "output.elasticsearch.hosts=[\"34.124.239.173:9200\"]" -E setup.kibana.host=http://kibana.nasir.id:80
sudo systemctl start filebeat
sudo systemctl enable filebeat
sudo curl -XGET "http://34.124.239.173:9200/filebeat-*/_search?pretty"
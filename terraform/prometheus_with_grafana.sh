#!/bin/bash

#create user for node exporter
sudo useradd --no-create-home --shell /bin/false node_exporter
# download node exporter
wget https://github.com/prometheus/node_exporter/releases/download/v0.18.1/node_exporter-0.18.1.linux-amd64.tar.gz
tar -xvzf node_exporter-0.18.1.linux-amd64.tar.gz 
sudo cp node_exporter-0.18.1.linux-amd64/node_exporter /usr/local/bin/


sudo echo "[Unit]" >> /etc/systemd/system/node_exporter.service
sudo echo "Description=Node Exporter" >> /etc/systemd/system/node_exporter.service
sudo echo "Wants=network-online.target" >> /etc/systemd/system/node_exporter.service
sudo echo "After=network-online.target" >> /etc/systemd/system/node_exporter.service
sudo echo "[Service]" >> /etc/systemd/system/node_exporter.service
sudo echo "User=node_exporter" >> /etc/systemd/system/node_exporter.service
sudo echo "Group=node_exporter" >> /etc/systemd/system/node_exporter.service
sudo echo "ExecStart=/usr/local/bin/node_exporter" >> /etc/systemd/system/node_exporter.service
sudo echo "[Install]" >> /etc/systemd/system/node_exporter.service
sudo echo "WantedBy=default.target" >> /etc/systemd/system/node_exporter.service

# run node exporter service
sudo systemctl daemon-reload
sudo systemctl start node_exporter
sudo systemctl status node_exporter
sudo systemctl enable node_exporter
#curl 'localhost:9100/metrics'

#create user for prometheus
sudo useradd --no-create-home --shell /bin/false prometheus
#https://github.com/prometheus/prometheus/releases/download/v2.17.2/prometheus-2.17.2.linux-amd64.tar.gz

# download and untar
wget https://github.com/prometheus/prometheus/releases/download/v2.17.2/prometheus-2.17.2.linux-amd64.tar.gz
tar -xvzf prometheus-2.17.2.linux-amd64.tar.gz 
sudo cp prometheus-2.17.2.linux-amd64/prometheus /usr/local/bin/
sudo cp prometheus-2.17.2.linux-amd64/promtool usr/local/bin/
sudo cp prometheus-2.17.2.linux-amd64/promtool /usr/local/bin/

sudo mkdir /etc/prometheus
sudo cp -r prometheus-2.17.2.linux-amd64/consoles/   /etc/prometheus/consoles
sudo cp -r prometheus-2.17.2.linux-amd64/console_libraries/   /etc/prometheus/console_libraries
sudo cp prometheus-2.17.2.linux-amd64/prometheus.yml /etc/prometheus/

# change folder owner for user prometheus
sudo chown -R prometheus:prometheus /etc/prometheus

sudo mkdir /var/lib/prometheus
sudo chown prometheus:prometheus /var/lib/prometheus

#sudo nano /etc/prometheus/prometheus.yml
wget https://raw.githubusercontent.com/Oleksandr2309/1994/master/prometheus.yml
sudo cp prometheus.yml /etc/prometheus/prometheus.yml

wget https://raw.githubusercontent.com/Oleksandr2309/1994/master/prometheus.service
sudo cp prometheus.service /etc/systemd/system/prometheus.service

#run prometheus service
sudo systemctl daemon-reload
sudo systemctl start prometheus
sudo systemctl status prometheus
sudo systemctl enable prometheus
#curl 'localhost:9090/metrics'


#Install grafana

wget https://dl.grafana.com/oss/release/grafana_6.7.3_amd64.deb

#install grafana
sudo apt install ./grafana_6.7.3_amd64.deb

#start grafana
sudo systemctl start grafana-server
sudo systemctl status grafana-server
sudo systemctl enable grafana-server



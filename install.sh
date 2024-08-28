sudo apt-get install gnupg curl

curl -fsSL https://pgp.mongodb.com/server-7.0.asc > key

sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor key

echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.com/apt/ubuntu jammy/mongodb-enterprise/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-enterprise-7.0.list

sudo apt-get update

sudo apt-get install -y mongodb-enterprise

echo "mongodb-enterprise hold"sudo dpkg --set-selectionsecho "mongodb-enterprise-server hold"sudo dpkg --set-selectionsecho "mongodb-enterprise-database hold"sudo dpkg --set-selectionsecho "mongodb-mongosh hold"sudo dpkg --set-selectionsecho "mongodb-enterprise-mongos hold"sudo dpkg --set-selectionsecho "mongodb-enterprise-tools hold"sudo dpkg --set-selections

sudo chown mongodb:mongodb /data

#sudo nano /etc/mongod.conf
config_file="/etc/mongod.conf"
#change dbPath to /data
sed -i 's|dbPath: /var/lib/mongodb|dbPath: /data|' "$config_file"
#add “,ea3” to bindIp
sed -i 's|bindIp: 0.0.0.0|' "$config_file"
#uncomment “replication”
#add “  replSetName: "rs0"” under replication
sed -i '/#replication:/a replication:\n replSetName: "rs0"' "$config_file"

sudo systemctl start mongod

sleep 5

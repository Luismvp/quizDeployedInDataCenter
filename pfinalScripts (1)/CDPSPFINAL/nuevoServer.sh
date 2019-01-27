#Levantamos el servidor 4
sudo vnx -f s4.xml --create
#Montamos el nas en el servidor 4
sudo lxc-attach --clear-env -n s4 -- mkdir /mnt/nas
sudo lxc-attach --clear-env -n s4 -- mount -t glusterfs 20.2.4.21:/nas /mnt/nas
#Montamos el servicio de Quiz en el servidor 4
sudo lxc-attach --clear-env -n s4 -- apt -y install nodejs
sudo lxc-attach --clear-env -n s4 -- apt -y install npm
sudo lxc-attach --clear-env -n s4 -- bash -c "
cd root;
git clone https://github.com/CORE-UPM/quiz_2019.git;
"
sudo lxc-attach --clear-env -n s4 -- bash -c "
cd root;
cd quiz_2019;
cd public;
ln -s /mnt/nas uploads; 
npm install;
npm install forever; 
npm install mysql2;
export QUIZ_OPEN_REGISTER=yes; 
export DATABASE_URL=mysql://quiz:xxxx@20.2.4.31:3306/quiz;
cd ..;
./node_modules/forever/bin/forever start ./bin/www
"
#Añadimos el servidor 4 al balanceador
sudo scp nuevoServHaproxy.py root@lb:/root
sudo lxc-attach --clear-env -n lb -- sudo python3 root/nuevoServHaproxy.py
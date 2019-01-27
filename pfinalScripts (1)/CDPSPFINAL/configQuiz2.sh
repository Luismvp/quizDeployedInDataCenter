sudo lxc-attach --clear-env -n s1 -- apt -y install nodejs
sudo lxc-attach --clear-env -n s2 -- apt -y install nodejs
sudo lxc-attach --clear-env -n s3 -- apt -y install nodejs

sudo lxc-attach --clear-env -n s1 -- apt -y install npm
sudo lxc-attach --clear-env -n s2 -- apt -y install npm
sudo lxc-attach --clear-env -n s3 -- apt -y install npm

sudo lxc-attach --clear-env -n s1 -- bash -c "
cd root;
git clone https://github.com/CORE-UPM/quiz_2019.git;
"
sudo lxc-attach --clear-env -n s2 -- bash -c "
cd root;
git clone https://github.com/CORE-UPM/quiz_2019.git;
"
sudo lxc-attach --clear-env -n s3 -- bash -c "
cd root;
git clone https://github.com/CORE-UPM/quiz_2019.git;
"
#iniciamos el servicio quiz en s1
sudo lxc-attach --clear-env -n s1 -- bash -c "
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
npm run-script migrate_cdps # solo en uno de los servidores; 
npm run-script seed_cdps # solo en uno de los servidores;
./node_modules/forever/bin/forever start ./bin/www;
"
#iniciamos el servicio quiz en s2

sudo lxc-attach --clear-env -n s2 -- bash -c "
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
#iniciamos el servicio quiz en s3

sudo lxc-attach --clear-env -n s3 -- bash -c "
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

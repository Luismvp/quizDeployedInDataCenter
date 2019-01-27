sudo lxc-attach --clear-env -n bbdd -- apt update 
sudo lxc-attach --clear-env -n bbdd -- apt -y install mariadb-server
sudo lxc-attach --clear-env -n bbdd -- sed -i -e 's/bind-address.*/bind-address=0.0.0.0/' -e 's/utf8mb4/utf8/' /etc/mysql/mariadb.conf.d/50-server.cnf
sudo lxc-attach --clear-env -n bbdd -- systemctl restart mysql
sudo lxc-attach --clear-env -n bbdd -- mysqladmin -u root password xxxx 
sudo lxc-attach --clear-env -n bbdd -- mysql -u root --password='xxxx' -e "CREATE USER 'quiz' IDENTIFIED BY 'xxxx';"
sudo lxc-attach --clear-env -n bbdd -- mysql -u root --password='xxxx' -e "CREATE DATABASE quiz;" 
sudo lxc-attach --clear-env -n bbdd -- mysql -u root --password='xxxx' -e "GRANT ALL PRIVILEGES ON quiz.* to 'quiz'@'localhost' IDENTIFIED by 'xxxx';" 
sudo lxc-attach --clear-env -n bbdd -- mysql -u root --password='xxxx' -e "GRANT ALL PRIVILEGES ON quiz.* to 'quiz'@'%' IDENTIFIED by 'xxxx';"
sudo lxc-attach --clear-env -n bbdd -- mysql -u root --password='xxxx' -e "FLUSH PRIVILEGES;" 

sudo lxc-attach --clear-env -n s1 -- apt -y install mariadb-client
sudo lxc-attach --clear-env -n s1 -- mysql -h 20.2.4.31 -u quiz --password='xxxx' quiz


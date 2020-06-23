
#!/bin/bash

if [[ $EUID -ne 0 ]]; then
    echo "You must be root"
    exit 1

function mainmenu(){
    clear
    echo " "
    echo Installation Of LAMP Stack On Debian Distro 
    echo " "
    echo "Choose a option from below:" 
         echo 1. Install Apache 
         echo 2. Install MariaDB
         echo 3. Install PHP
         echo 4. Complete LAMP Installation
         echo 5. Exit
    echo " "
    echo -n "Enter Option No.:"
    read option
    case $option in
	1)
		function apache () {
		    TIME=2
			echo Updating System...
			sleep $TIME
			apt update && apt upgrade -y
			echo Starting Apache Installation... 
			sleep $TIME
			sudo iptables -I INPUT -p tcp --dport 80 -j ACCEPT
			sudo ufw allow http
			sudo chown www-data:www-data /var/www/html/ -R
			apt install -y apache2 apache2-utils
			sudo systemctl start apache2
			sudo systemctl enable apache2	
			echo " "
				if [ $? -eq 0 ]
                then
                    echo Apache Installation Successful
                else
                    echo Installation Error
                fi 
        }  
        apache   
        read -n 1 -p "<Enter> for main menu"
        mainmenu
        ;;  

    2)
		function maria () {
		TIME=2
			echo Installing MariaDB...
			sleep $TIME
			sudo apt -y install mariadb-server mariadb-client
			sudo systemctl start mariadb
			sudo systemctl enable mariadb
				if [ $? -eq 0 ]
				then
					echo Configuring SQL Server...
					sleep $TIME
					sudo mysql_secure_installation
					echo " "
					echo SQL Server Configured Successfully!
					sleep $TIME
				else
					echo MariaDB Installation Error...
				fi
			}
			maria
			read -n 1 -p "<Enter> for main menu"
			mainmenu
	;;

	3)
		function php () {
			echo Installing PHP...
			sudo apt install -y php libapache2-mod-php php-mysql php-common php-cli php-common php-json php-readline php-curl php-gd php-mbstring php-xml php-xmlrpc
			sudo a2enmod php
			sudo systemctl restart apache2
			echo " "
			echo PHP Installation Successful
			#Para testar o PHP instalado...
			#sudo vim /var/www/html/info.php <?php phpinfo(); ?>
			}
			php
			read -n 1 -p "<Enter> for main menu"
			mainmenu
	;;

	4)
		function lamp () {
		TIME=2	
			#apache
			echo Installing LAMP stack On Your System...
			sleep $TIME
			echo Installing Apache2...
			sleep $TIME
			apt install -y apache2 apache2-utils
			sudo systemctl start apache2
			sudo systemctl enable apache2
			echo Installing the database ....
			sleep $TIME
			#database
			sudo apt -y install mariadb-server mariadb-client
			sudo systemctl start mariadb
			sudo systemctl enable mariadb
			#PHP
			echo Installing PHP...
			sleep $TIME
			sudo apt install -y php libapache2-mod-php php-mysql php-common php-cli php-common php-json php-readline php-curl php-gd php-mbstring php-xml php-xmlrpc
			sudo a2enmod php
			sudo systemctl restart apache2
			echo Lnstallation Completed Successfully
			sleep $TIME
                        echo Configuring SQL Server...
                        sudo mysql_secure_installation
		}
			lamp
			read -n 1 -p "<Enter> for main menu"
			mainmenu
	;;

	5)
		function goout () {
			TIME=2
			echo " "
			echo Leaving the system ......
			sleep $TIME
			exit 0
		}
		goout
	;;

esac
}
mainmenu    
}

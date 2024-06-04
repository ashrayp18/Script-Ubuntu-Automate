#!/bin/bash

#Change the working dir
cd /root/

#make the req directory
mkdir -p tools/tomcat tools/maven

#Update the server

apt-get update 
echo "Server has been updated"
sleep 3

#Install unzip
apt-get install unzip -y
echo " Unzip tool has been isntalled successfully"
sleep 3

#Install Java-11Open-jdk
apt-get install openjdk-11-jdk -y
echo "openjdk-11-jdk have been installed successfully"


#Download the tomcat Server
cd /root/tools/tomcat
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.89/bin/apache-tomcat-9.0.89.zip
unzip apache-tomcat-9.0.89.zip
chmod -R 777 apache-tomcat-9.0.89
rm -rf apache-tomcat-9.0.89.zip
echo "Tomcat Server Downloaded successfully"
sleep 3

#Installing Jenkins on Tomcat Server
cd /root/tools/tomcat/apache-tomcat-9.0.89/webapps/
wget https://get.jenkins.io/war-stable/2.452.1/jenkins.war
ln -s /root/tools/tomcat/apache-tomcat-9.0.89/bin/startup.sh /usr/local/sbin/tomcatup
echo "Jenkins uploaded to Tomcat Server"
sleep 3

#Install maven Server
cd /root/tools/maven
wget https://dlcdn.apache.org/maven/maven-3/3.9.7/binaries/apache-maven-3.9.7-bin.zip
unzip apache-maven-3.9.7-bin.zip
chmod -R 777 apache-maven-3.9.7
rm -rf apache-maven-3.9.7-bin.zip
echo "Maven Server Installed"
sleep 3

#Update Maven code
cd /root
echo "export Maven=/root/tools/maven/apache-maven-3.9.7" >> ~/.profile
echo 'export PATH=$Maven/bin:$PATH' >> ~/.profile
echo " Maven code updated successfully"
sleep 3


prompt_user() {
    while true; do
        read -p "Do you want to start the Jenkins server? (Yes/No): " choice
        case "$choice" in
            Yes|yes|Y|y)
                echo "Starting the Jenkins server..."
                tomcatup
                echo "Jenkins server started."
                 # Check if the Jenkins password file exists and display the password
                if [ -f /root/.jenkins/secrets/initialAdminPassword ]; then
                    echo "Jenkins initial admin password:"
                    cat /root/.jenkins/secrets/initialAdminPassword
                else
                    echo "Jenkins password file not found."
                fi
		break
                ;;
            No|no|N|n)
                echo "Jenkins server not started."
                break
                ;;
            *)
                echo "Invalid input. Please enter Yes or No."
                ;;
        esac
    done
}

# Call the function to prompt the user
prompt_user

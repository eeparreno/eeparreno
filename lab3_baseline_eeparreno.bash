#!/bin/bash

filename=eeparreno_lab3_baseline.txt

echo "Report Title: SPR500 Lab 3 Report" >> $filename
echo "Full name: Emma Parreno" >> $filename
echo "User name: eeparreno" >> $filename
echo "Student ID: 105852180" >> $filename 

echo "################Lab 3: ##################" >>$filename
echo "---------------Routing table: -----------" >>$filename 
ip r >>$filename
echo "*****************************************" >>$filename
echo "--------------http server status: ------" >>$filename
systemctl status httpd >>$filename
echo "*****************************************" >>$filename
echo "--------------Log file sizes: -----------" >>$filename
ls -l /var/log/messages >>$filename
ls -l /var/log/boot.log >>$filename
ls -l /var/log/maillog >>$filename
ls -l /var/log/secure >>$filename
ls -l /var/log/wtmp >>$filename
ls -l /var/log/btmp >>$filename
ls -l /var/log/lastlog >>$filename
ls -l /var/log/dnf.log >>$filename
echo "*****************************************" >>$filename
echo "------Number of active services of VM2-------" >>$filename
systemctl list-unit-files | grep enabled | wc -l >>$filename
echo "*****************************************">>$filename
echo "----------Number of RPM packages currently installed----" >>$filename
rpm -qa | wc -l >>$filename
echo "*****************************************" >>$filename
echo "----------Current Firewall Rules: -------" >>$filename
sudo iptables -L -n -v >>$filename
echo "***************************************">>$filename
echo "-----Current execution mode of SELinux-----">>$filename
sestatus >>$filename

echo "############# System and device information #######" >> $filename
echo "Hostname information:" >> $filename
hostnamectl >> $filename

echo "*******************************************************************" >> $filename
echo "Disk/partition size, usage, and mount points:" >> $filename 
df >> $filename

echo "*******************************************************************" >> $filename
echo "OS version/release level, and netmask for each active device:" >> $filename
uname -r -v >> $filename 

echo "*******************************************************************" >> $filename
echo "Date the OS was first installed:" >> $filename
rpm -qi basesystem | grep Install >> $filename

echo "*******************************************************************" >> $filename
echo "Hardware details:" >> $filename
lshw -short >> $filename 

echo "*******************************************************************" >> $filename
echo "List of active shell users:" >> $filename
w >> $filename 

echo "######################### Networking information ###############" >> $filename 
echo "*******************************************************************" >> $filename 
echo "network devices (names):" >> $filename
ip link show >> $filename 

echo "*******************************************************************" >> $filename
echo "IP address, broasdcast, and netmask for each active device:" >> $filename
ip a >> $filename 

echo "################ Repositories and package information #########" >> $filename
echo "*******************************************************************" >> $filename
echo "List of active repositories" >> $filename 
dnf repolist enabled >> $filename 

echo "*******************************************************************" >> $filename
echo "Names of software packages installed:" >> $filename
dnf list installed >> $filename

echo "################## Information on machine's services #######" >>  $filename
echo "*******************************************************************" >> $filename 
echo "Dns server configured (used for the local resolver):" >> $filename
cat /etc/resolv.conf >> $filename 

echo "******************************************************************" >> $filename
echo "Installed services currently running:" >> $filename
systemctl list-units --type=service >> $filename 

echo "******************************************************************" >> $filename
echo "Installed services not running:" >> $filename
systemctl list-unit-files | grep "disabled" >> $filename

echo "COMPLETE! Thank you!"






#!/bin/bash

echo "Which machine would you like to output the baseline information to? (select vm1, vm2, vm3, or vm4, or matrix)"
read machine
if [ $machine == 'vm1' ]; then 
	filename=eeparreno_gateway_base.txt;
elif
[ $machine == 'vm2' ]; then
	filename=eeparreno_vm2_base.txt;
elif 
[ $machine == 'vm3' ]; then
	filename=eeparreno_vm3_base.txt;
elif
[ $machine == 'vm4' ]; then
	filename=eeparreno_vm4_base.txt;
elif 
[ $machine == 'matrix' ]; then
	filename=eeparreno_matrix_base.txt;
else 
	echo "selection invalid"
exit 
fi

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

echo "############ Security and Firewall  information #############" >> $filename
echo "*******************************************************************" >> $filename 
echo "Security mode (SELinux status):" >> $filename 
sestatus >> $filename

echo "*******************************************************************" >> $filename 
echo "Firewall configuration and services (firewalld):" >> $filename
sudo firewall-cmd --list-services >> $filename 
sudo firewall-cmd --state >> $filename

echo "################ Repositories and package information #########" >> $filename
echo "*******************************************************************" >> $filename
echo "List of active repositories" >> $filename 
dnf repolist enabled >> $filename 

echo "*******************************************************************" >> $filename
echo "Number of software packages installed:" >> $filename
dnf list installed | wc -l >> $filename 

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






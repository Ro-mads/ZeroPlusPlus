#!bin/bash
yum -y update
yum -y install httpd
myip=`cutl http://169.254.169.254/latest/meta-data/local-ipv4`

cat <<EOF > /var/www/html/index.html
<html>
  <h2>Thank You!!! NMSM!!! <front color="red"> GBSB</font></h2><br>
Owner ${f_name} ${l_name}<br>
%{ for x in names ~}
Privet to ${x} from ${f_name}<br>
%{ endfor ~}
</html>
EOF
sudo service httpd start
chkconfig httpd on

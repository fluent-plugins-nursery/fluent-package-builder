#!/bin/bash

set -exu

. $(dirname $0)/../commonvar.sh

sudo apt install -V -y rsyslog

# Install the current
sudo apt install -V -y \
    /host/${distribution}/pool/${code_name}/${channel}/*/*/fluent-package_*_${architecture}.deb

# Make a dummy pacakge for the next version
dpkg-deb -R /host/${distribution}/pool/${code_name}/${channel}/*/*/fluent-package_*_${architecture}.deb tmp
last_ver=$(cat tmp/DEBIAN/control | grep "Version: " | sed -E "s/Version: ([0-9.]+)-([0-9]+)/\2/g")
sed -i -E "s/Version: ([0-9.]+)-([0-9]+)/Version: \1-$(($last_ver+1))/g" tmp/DEBIAN/control
dpkg-deb --build tmp next_version.deb

# Set up configuration
cat < $(dirname $0)/../../test-tools/rsyslog.conf >> /etc/rsyslog.conf
cp $(dirname $0)/../../test-tools/fluentd.conf /etc/fluent/fluentd.conf

# Launch rsyslog
sudo systemctl restart rsyslog

# Launch fluentd
sudo systemctl restart fluentd
main_pid=$(systemctl show --value --property=MainPID fluentd)

# Ensure to wait for fluentd launching
sleep 1

# Send logs in background for 4 seconds
/opt/fluent/bin/ruby $(dirname $0)/../../test-tools/logdata-sender.rb \
    --udp-data-count 50 --tcp-data-count 60 --syslog-data-count 70 --syslog-identifer "test-syslog" --duration 4 &

sleep 1

# Update to the next version
sudo apt install -V -y ./next_version.deb
test $main_pid -eq $(systemctl show --value --property=MainPID fluentd)

sleep 3

# Stop fluentd to flush the logs and check
systemctl stop fluentd
test $(wc -l /var/log/fluent/test_udp*.log | cut -d' ' -f 1) = "50"
test $(wc -l /var/log/fluent/test_tcp*.log | cut -d' ' -f 1) = "60"
test $(grep "test-syslog" /var/log/fluent/test_syslog*.log | wc -l) = "70"
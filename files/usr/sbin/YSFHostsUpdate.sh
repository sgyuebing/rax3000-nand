#!/bin/sh
# 
# Copyright 2019-2020 Michael BD7MQB <bd7mqb@qq.com>
# This is free software, licensed under the GNU GENERAL PUBLIC LICENSE, Version 2.0
#

# Full path to YSFHosts
YSFHOSTS=/etc/mmdvm/YSFHosts.txt

# Generate YSFHosts.txt file
wget -O ${YSFHOSTS} http://123.60.74.175/files/YSFHosts.txt 

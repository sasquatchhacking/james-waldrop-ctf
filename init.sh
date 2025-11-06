#!/bin/bash
mkdir -p /home/student/logs/.hidden
echo "flag{linux_file_ops_master}" > /home/student/logs/.hidden/flag.txt
chmod 600 /home/student/logs/.hidden/flag.txt

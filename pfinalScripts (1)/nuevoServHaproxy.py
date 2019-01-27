from subprocess import call
import sys
import os
call("touch /etc/haproxy/haproxy.cfg.tmp", shell = True)
call("sudo chmod 777 /etc/haproxy/haproxy.cfg.tmp", shell = True)
f=open('/etc/haproxy/haproxy.cfg')
n=open('/etc/haproxy/haproxy.cfg.tmp', 'w')

for line in f:
    fields = line.strip().split()
    if len(fields) > 0 :
        if fields[0] == 'server':
            if fields[1] == "s3":
                n.write(line)
                n.write("server s4 20.2.3.14:3000 check\n")
                continue
    n.write(line)
f.close()
n.close()

os.remove("/etc/haproxy/haproxy.cfg")
os.rename("/etc/haproxy/haproxy.cfg.tmp", "/etc/haproxy/haproxy.cfg")

call("sudo service haproxy restart ",shell=True)
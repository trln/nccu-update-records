#run once a day

system "find /home/ec2-user/data/update* -mtime +14 -exec rm {} \;"
system "find /home/ec2-user/data/delete* -mtime +14 -exec rm {} \;"
system "find /home/ec2-user/data/packages* -mtime +14 -exec rm {} \;"
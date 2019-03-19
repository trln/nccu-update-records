#run every two weeks

system "find /home/ec2-user/data/update* -mtime +14 -exec rm {} \;"
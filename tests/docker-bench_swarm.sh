!/bin/bash
##
export DOCKER_HOST=tcp://0.0.0.0:2375 

for i in `docker run --rm swarm list token://ce2fcf3f87f4c8a337d08e2f802ebe88|head -1`;
do
 echo $i>>bench.log 
docker -H tcp://$i run -it --rm --net host --pid host --cap-add audit_control \
  -v /var/lib:/var/lib \
 -v /var/run/docker.sock:/var/run/docker.sock \
 -v /usr/lib/systemd:/usr/lib/systemd \
  -v /sbin/auditctl:/sbin/auditctl \
  -v /etc:/etc -v /etc/docker:/etc/docker --label docker-bench-security \
  diogomonica/docker-bench-security /bin/sh|egrep -i 'warn|yell'
 

#docker -H tcp://$i run --privileged=true  -d -it --net host --pid host --cap-add audit_control     -v /var/lib:/var/lib     -v /var/run/docker.sock:/var/run/docker.sock     -v /usr/lib/systemd:/usr/libh

# docker -H $i  info
done 

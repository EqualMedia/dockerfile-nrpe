# Dockerfile for Nagios nrpe daemon

This image can be useful if you use nagios already and want to monitor docker
host (i.e. CoreOS) whether it is up.

Built images are hosted at https://registry.hub.docker.com/u/state/nrpe/

nrpe is started by systemd, because there is no easy way to run nrpe daemon in
foreground.

### RUN
`docker run --cap-add SYS_ADMIN -p 5666:5666 state/nrpe` 


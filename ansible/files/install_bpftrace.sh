# It is impossible to find an up-to-date version of bpftrace.
# But per the [readme](https://github.com/iovisor/bpftrace/blob/master/INSTALL.md#copying-bpftrace-binary-from-docker),
# here's one way to do it.
docker pull quay.io/iovisor/bpftrace:latest
docker run -v /usr/bin:/output quay.io/iovisor/bpftrace:latest /bin/bash -c "cp /usr/bin/bpftrace /output"

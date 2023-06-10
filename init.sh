#/usr/bin/bash

function fix_vm_max_memory_issue()
{
  docker run \
    -it \
    --rm \
    --privileged \
    --pid=host \
    alpine:edge \
    nsenter -t 1 -m -u -n -i sh -c "sysctl -w vm.max_map_count=262144 && echo 'All done!'"
}

# Entry point

fix_vm_max_memory_issue


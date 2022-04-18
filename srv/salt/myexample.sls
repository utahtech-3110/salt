#/srv/salt/myexample.sls

create a partition:
  parted.mkpart:
    - device: /dev/xvdf
    - part_type: primary
    - fs_type: ext2
    - start: 0
    - end: 100
    

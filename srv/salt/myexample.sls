#/srv/salt/myexample.sls

disk_label_mysql:
  module.run:
    - name: partition.mklabel
    - device: /dev/xvdf
    - label_type: gpt
#    - unless: "parted /dev/xvdf print | grep -i '^Partition Table: gpt'"



{% for i in range(10) %}
create_a_partition_{{ i }}:
  module.run:
    - name: partition.mkpart
    - device: /dev/xvdf
    - part_type: primary
    - fs_type: ext4
    - start: {{ i * 50 }}
    - end: {{ i * 50 + 50 }}
{% endfor %}

format_1:
  module.run:
    - name: extfs.mkfs
    - device: /dev/xvdf1
    - fs_type: ext4
    - block_size: 1024
    - reserved: 0
  
format_2:
  module.run:
    - name: extfs.mkfs 
    - device: /dev/xvdf2
    - fs_type: ext4
    - block_size: 1024
    - reserved: 0
    - bytes_per_inode: 1024

format_3:
  module.run:
    - name: extfs.mkfs 
    - device: /dev/xvdf3
    - fs_type: ext4
    - block_size: 4096
    - reserved: 0
#see this site https://docs.saltproject.io/en/latest/ref/modules/all/salt.modules.extfs.html
#
format_4:
  module.run:
    - name: extfs.mkfs 
    - device: /dev/xvdf4
    - fs_type: ext4
    - block_size: 4096
    - number_of_inodes: 128

format_5:
  cmd.run:
    - name: mkfs.vfat -F 32 /dev/xvdf5

format_6:
  cmd.run:
    - name: mkfs.vfat -F 32 -S 512 /dev/xvdf6

format_7:
  cmd.run:
    - name: mkfs.vfat -F 16 -S 4096 /dev/xvdf7

format_8:
  cmd.run:
    - name: mkfs.ntfs /dev/xvdf8

format_9:
  cmd.run:
    - name: mkfs.ntfs -c 512 /dev/xvdf9

format_10:
  cmd.run:
    - name: mkfs.ntfs -c 65536 /dev/xvdf10

{% for i in range(1,11) %}
create_space_{{ i }}:
  file.directory:
    - name: /space/d{{ i }}
    - makedirs: True
{% endfor %}
# https://docs.saltproject.io/en/latest/ref/states/all/salt.states.mount.html
{% for i in range(1,11) %}
mount_{{ i }}:
  mount.fstab_present:
    - name: /dev/xvdf{{ i }}
    - fs_file: /space/d{{ i }}
    - fs_vfstype: "auto"  

{% endfor %}
   
    

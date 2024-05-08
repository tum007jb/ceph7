cephadm bootstrap --cluster-network 192.168.172.0/24  --mon-ip 192.168.172.52 --initial-dashboard-password=P@ssw0rd@ifs --dashboard-password-noupdate --allow-fqdn-hostname --registry-url registry.redhat.io --registry-username surayossri --registry-password Addminit@ti0n | tee -a /root/cephadm_bootstrap.log
ssh-copy-id -f -i /etc/ceph/ceph.pub root@storageceph2.dso.local
ssh-copy-id -f -i /etc/ceph/ceph.pub root@storageceph3.dso.local

ceph orch host add storageceph2.dso.local
ceph orch host add storageceph3.dso.local
ceph orch host ls
ceph orch host label add storageceph1.dso.local mon
ceph orch host label add storageceph2.dso.local mon
ceph orch host label add storageceph3.dso.local mon
ceph orch apply mon storageceph1.dso.local,storageceph2.dso.local,storageceph3.dso.local
ceph orch host ls
ceph orch host rescan storageceph2.dso.local --with-summary
ceph orch host rescan storageceph3.dso.local --with-summary
ceph orch ps
#ceph orch resume
#ceph cephadm check-host ceph-mon02
echo "waiting 120s for mons to be up"
sleep 120s
#MGR
ceph orch host label add storageceph1.dso.local mgr
ceph orch host label add storageceph2.dso.local mgr
ceph orch host label add storageceph3.dso.local mgr
ceph orch apply mgr storageceph1.dso.local,storageceph2.dso.local,storageceph3.dso.local
ceph orch ps
#ceph orch resume
#ceph cephadm check-host ceph-mon02
echo "waiting 120s for mons to be up"
sleep 120s

#OSD
ceph orch host label add storageceph1.dso.local osd
ceph orch host label add storageceph2.dso.local osd
ceph orch host label add storageceph3.dso.local osd
#wait 120S
ceph orch apply osd --all-available-devices
ceph osd tree
ceph osd pool create ocs 64 64
ceph osd pool application enable ocs rbd
# S3 
ceph orch host label add storageceph2.dso.local rgw
ceph orch host label add storageceph3.dso.local rgw
ceph orch apply rgw dso --placement="label:rgw count-per-host:2" --port=8000
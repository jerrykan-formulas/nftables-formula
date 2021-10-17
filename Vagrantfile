# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<EOSCRIPT

read -d '' PUBLIC_KEY <<EOF
mQENBFOpvpgBCADkP656H41i8fpplEEB8IeLhugyC2rTEwwSclb8tQNYtUiGdna9m38kb0OS2DDr
EdtdQb2hWCnswxaAkUunb2qq18vd3dBvlnI+C4/xu5ksZZkRj+fWtArNR18V+2jkwcG26m8AxIrT
+m4M6/bgnSfHTBtT5adNfVcTHqiT1JtCbQcXmwVwWbqS6v/LhcsBE//SHne4uBCK/GHxZHhQ5jz5
h+3vWeV4gvxS3Xu6v1IlIpLDwUtskT1DumfynYnnZmWTGc6SYyIFXTPJLtnoWDb9OBdWgZxXfHEc
BsKGha+bXO+m2tHAgNneN9i5f8oNxo5njrL8jkCckOpNpng18BKXABEBAAG0MlNhbHRTdGFjayBQ
YWNrYWdpbmcgVGVhbSA8cGFja2FnaW5nQHNhbHRzdGFjay5jb20+iQE4BBMBAgAiBQJTqb6YAhsD
BgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRAOCKFJ3le/vhkqB/0QWzELZf4d87WApzolLG+z
psJKtt/ueXL1W1KA7JILhXB1uyvVORt8uA9FjmE083o1yE66wCya7V8hjNn2lkLXboOUd1UTErlR
g1GYbIt++VPscTxHxwpjDGxDB1/fiX2onK5SEpuj4IeIPJVE/uLNAwZyfX8DArLVJ5h8lknwiHlQ
LGlnOu9ulEAejwAKt9CU4oYTszYM4xrbtjB/fR+mPnYh2fBoQO4d/NQiejIEyd9IEEMd/03AJQBu
Mux62tjA/NwvQ9eqNgLw9NisFNHRWtP4jhAOsshv1WW+zPzu3ozoO+lLHixUIz7fqRk38q8Q9oNR
31KvrkSNrFbA3D89uQENBFOpvpgBCADJ79iH10AfAfpTBEQwa6vzUI3Eltqb9aZ0xbZV8V/8pnuU
7rqM7Z+nJgldibFk4gFG2bHCG1C5aEH/FmcOMvTKDhJSFQUxuhgxttMArXm2c22OSy1hpsnVG68G
32Nag/QFEJ++3hNnbyGZpHnPiYgej3FrerQJzv456wIsxRDMvJ1NZQB3twoCqwapC6FJE2hukSdW
B5yCYpWlZJXBKzlYz/gwD/FrGL578WrLhKw3UvnJmlpqQaDKwmV2s7MsoZogC6wkHE92kGPG2Gmo
RD3ALjmCvN1EPsIsQGnwpcXsRpYVCoW7e2nW4wUf7IkFZ94yOCmUq6WreWI4NggRcFC5ABEBAAGJ
AR8EGAECAAkFAlOpvpgCGwwACgkQDgihSd5Xv74/NggA08kEdBkiWWwJZUZEy7cKWWcgjnRuOHd4
rPeT+vQbOWGu6x4bxuVf9aTiYkf7ZjVF2lPn97EXOEGFWPZeZbH4vdRFH9jMtP+rrLt6+3c9j0M8
SIJYwBL1+CNpEC/BuHj/Ra/cmnG5ZNhYebm76h5fT9iPW9fFww36FzFka4VPlvA4oB7ebBtquFg3
sdQNU/MmTVV4jPFWXxh4oRDDR+8N1bcPnbB11b5ary99F/mqr7RgQ+YFF0uKRE3SKa7a+6cIuHEZ
7Za+zhPaQlzAOZlxfuBmScum8uQTrEF5+Um5zkwC7EXTdH1co/+/V/fpOtxIg4XO4kcugZefVm5E
RfVSMA==
EOF

APT_REPO_FILE="/etc/apt/sources.list.d/saltstack.list"
APT_REPO="deb http://repo.saltstack.com/apt/debian/10/amd64/latest buster main"

# Add the saltstack repostory
echo "$APT_REPO" > $APT_REPO_FILE

# Trust the saltstack repository signing key
echo "$PUBLIC_KEY" | base64 -d > /etc/apt/sources.list.d/salt-archive-keyring.gpg

# Install salt minion and python testing tools
apt-get update
apt-get install -y salt-minion

# Configure Minion
cat <<EOF > /etc/salt/minion
file_client: local

file_roots:
  base:
    - /srv/salt
    - /srv/salt/tests/states

pillar_roots:
  base:
    - /srv/salt/tests/pillar
EOF

EOSCRIPT

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.define "nftables", primary: true do |host|
        host.vm.box = 'debian/bullseye64'
        host.vm.host_name = 'nftables.salt.example.com'
        host.vm.synced_folder "./", "/srv/salt"
        host.vm.provision "shell", inline: $script
    end
end

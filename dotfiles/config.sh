lpadmin -p "SecretariaPB" -D "Secretaria (P&B)" -L "C6.3" -E -v smb://printserver.fc.ul.pt/Canon_IN -m drv:///sample.drv/generpcl.ppd -o Duplex=DuplexTumble -o Option1=True
lpadmin -p "SecretariaCores" -D "Secretaria (Cores)" -L "C6.3" -E -v smb://printserver.fc.ul.pt/Canon_IN -m drv:///sample.drv/generic.ppd -o Duplex=DuplexTumble -o Option1=True
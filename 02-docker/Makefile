user   = dev
##############################################################################
ID_RSA = $(shell bash -c "echo id_rsa_$(user){,.pub}")
CONFIG = ca.cnf
##############################################################################
KEYS   = $(ID_RSA) ca.crt
##############################################################################

all: $(KEYS)

#
# Build SSL certificates for our example.com
#
BITS=3072

ca.crt: $(CONFIG) ca.key
	openssl req -new -x509 -days 36500 -config $(CONFIG) \
	            -extensions v3_ca -key ca.key -out $@

id_rsa_$(user) id_rsa_$(user).pub:
	ssh-keygen -q -t rsa -f id_rsa_$(user) -N ""

ca.key:
	openssl genrsa -out $@ $(BITS)

clean:
	rm $(KEYS) ca.key

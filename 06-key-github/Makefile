#email  = $(shell git config user.email)
user   = ivancarlos
email  = $(shell git config github.$(user).email)

all: keys

#
# Build SSL certificates for our example.com
#
keys:
	ssh-keygen -q -t rsa -b 4096 -f id_rsa -fid_rsa_$(user) -N "" -C "${email}"
clean:
	rm id_rsa*

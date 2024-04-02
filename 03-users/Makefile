# PROJECTS  = vim dev eng command web embarcado linux gui
# LANGS     = bash android java cpp cansi lua go db latex python ruby perl
# TOOLS     = cmake makefile gradle
# USERS     = ivan alice bob carol david alpha bravo charlie delta
# JETBRAINS = clion datagrip goland idea phpstorm pycharm rider rubymine webstorm
# ENVS      = jenv luaenv ndenv plenv rbenv rustup cabal cargo dvm goenv

#users  = $(LANGS) $(PROJECTS) $(TOOLS) $(USERS) $(JETBRAINS) $(ENVS)

# users = web delta bravo alpha charlie gradle cmake jenv eng projetoY bash perl arduino ruby cpp qt wx java lua go gtk cansi python projetoX david embarcado alice linux maven rbenv luaenv pycharm rubymine datagrip clion rider goland webstorm idea rustup vim phpstorm circuito db makefile cabal command uff carol latex goenv envs plenv ivan gitolite android cargo dev dvm bob ndenv gui docker
#users  = ivancarlos
users  = dropbear
ID_RSA = $(shell bash -c "echo $(users)|sed 's/\w\+/id_rsa_& id_rsa_&.pub/g'")

KEYS   = $(ID_RSA)

all: $(KEYS)


#
# Build SSL certificates for our example.com
#
$(ID_RSA):
	echo $(users) | xargs -n1 ./create-keys.sh >> log
clean:
	rm $(KEYS) log

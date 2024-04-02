
SUBJ_ARG = /C=BR/ST=Rio de Janeiro/L=Estácio/O=Engenharia Ivan Lopes/CN=ivanlopes.eng.br
# SUBJ_ARG = /C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com
DAYS     = 365
MESSAGE  = Mensagem secreta

all: key.pem cert.pem show_message

key.pem cert.pem:
	# Este comando cria um novo certificado
	openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days $(DAYS) -nodes -subj "$(SUBJ_ARG)"

public.pem:
	openssl x509 -pubkey -noout -in cert.pem > public.pem

encrypt: public.pem
	# DEPRECATED: rsautl
	# echo "$(MESSAGE)" | openssl rsautl -encrypt -pubin -inkey cert.pem -out mensagem.criptografada
	#                             ^^^^^^
	echo "$(MESSAGE)" | openssl pkeyutl -encrypt -pubin -inkey public.pem -out mensagem.criptografada

decrypt: mensagem.criptografada
	# DEPRECATED: rsautl
	# openssl rsautl -decrypt -inkey key.pem -in mensagem.criptografada -out mensagem.descriptografada
	#         ^^^^^^
	openssl pkeyutl -decrypt -inkey key.pem -in mensagem.criptografada -out mensagem.descriptografada
	cat mensagem.descriptografada

show_message:
	gcc -o show_message show_message.c -lssl -lcrypto

show: show_message
	./show_message

build: key.pem cert.pem show_message encrypt decrypt show

clean:
	rm key.pem cert.pem public.pem mensagem.criptografada mensagem.descriptografada show_message

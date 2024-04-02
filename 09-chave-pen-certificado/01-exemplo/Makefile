
# SUBJ_ARG = /C=BR/ST=Rio de Janeiro/L=Estácio/O=Engenharia Ivan Lopes/CN=ivanlopes.eng.br
# SUBJ_ARG = /C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com
SUBJ_ARG = /CN=yourdomain.com
DAYS     = 365
MESSAGE  = Mensagem secreta

all: key.pem cert.pem show_message

key.pem cert.pem:
	openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days $(DAYS) -nodes -subj "$(SUBJ_ARG)"

public.pem: key.pem
	openssl rsa -in key.pem -outform PEM -pubout -out public.pem

encrypt: public.pem
	echo "$(MESSAGE)" | openssl rsautl -encrypt -pubin -inkey public.pem -out mensagem.criptografada

decrypt: mensagem.criptografada
	openssl rsautl -decrypt -inkey key.pem -in mensagem.criptografada -out mensagem.descriptografada
	cat mensagem.descriptografada

# Para os comandos listados que utilizam o `openssl rsautl` para criptografar
# uma mensagem, o padding padrão é `RSA_PKCS1_PADDING`. Portanto, ao
# descriptografar uma mensagem criptografada com esses comandos, você deve
# usar `RSA_PKCS1_PADDING` no seu programa em C.
show_message:
	gcc -o show_message show_message.c -lssl -lcrypto

show: show_message
	./show_message

build: key.pem cert.pem show_message encrypt decrypt show

clean:
	rm key.pem cert.pem public.pem mensagem.criptografada mensagem.descriptografada show_message

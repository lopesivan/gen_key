Para testar o código com certificados PEM em memória, você
precisará de um ambiente de desenvolvimento C configurado com
OpenSSL e libcurl instalados. Aqui estão os passos básicos:

1. **Compilar o Programa**: Use um compilador C, como `gcc`,
   para compilar o código, garantindo que você inclua as
   bibliotecas OpenSSL e cURL. Um comando de exemplo pode ser:
   `gcc -o cacertinmem cacertinmem.c $(pkg-config --libs --cflags
libcurl) -lssl -lcrypto`.

2. **Gerar Certificados PEM**: Para testar, você precisará
   de um certificado PEM. Você pode gerar um certificado
   autoassinado e uma chave privada usando OpenSSL com o comando:
   `openssl req -x509 -newkey rsa:4096 -keyout key.pem -out
cert.pem -days 365`. Este comando cria um novo certificado
   (`cert.pem`) e uma chave privada (`key.pem`), que podem ser
   usados para configurar um servidor HTTPS de teste.

3. **Configurar um Servidor HTTPS para Testes**: Você
   pode usar qualquer servidor web que suporte SSL/TLS para
   testar. Configure-o para usar o certificado e a chave privada
   que você gerou. Dependendo do servidor que você está usando,
   o processo exato para fazer isso varia.

4. **Testar a Conexão**: Execute o programa compilado. Se
   tudo estiver configurado corretamente, o programa deve ser
   capaz de estabelecer uma conexão HTTPS segura com o servidor
   usando o certificado PEM carregado em memória.

Esses passos fornecem um caminho básico para testar o conceito
de carregar certificados PEM em memória para conexões
seguras, mas os detalhes exatos podem variar dependendo do seu
ambiente específico e das ferramentas que você está usando.

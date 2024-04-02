Para criar um Makefile que gere `key.pem` e `cert.pem`
utilizando o comando `openssl`, seu Makefile pode ser
estruturado da seguinte maneira:

```makefile
all: key.pem cert.pem

key.pem cert.pem:
	openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com"
```

Neste Makefile, o alvo padrão `all` depende dos
arquivos `key.pem` e `cert.pem`. O comando `openssl`
é chamado para gerar ambos os arquivos. O parâmetro
`-nodes` é usado para evitar a criação de uma senha
para a chave privada. O parâmetro `-subj` fornece
informações requeridas pelo comando `openssl` sem a
necessidade de inserção manual. Ajuste os valores de
`/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com`
conforme necessário para seus próprios detalhes.

## Essa parte especifica os campos de informação para o

certificado digital:

- **C=US** refere-se ao país, no caso, Estados Unidos.

- **ST=Denial** é o estado ou província, aqui denominado "Denial".

- **L=Springfield** representa a localidade ou cidade, que é
  "Springfield".

- **O=Dis** designa a organização, aqui abreviada como "Dis".

- **CN=www.example.com** é o Common Name, que identifica o
  domínio para o qual o certificado é válido,
  neste caso, "www.example.com".

Esses campos são usados para preencher informações no
certificado digital, que ajudam a identificar quem ou o que
está sendo certificado.

Para criar um certificado para seu site com as
informações fornecidas, você pode usar o seguinte comando
OpenSSL. Lembre-se de executar isso em um ambiente onde o
OpenSSL está instalado e configurado:

```sh
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes -subj "/C=BR/ST=Rio de Janeiro/L=Estácio/O=Engenharia Ivan Lopes/CN=ivanlopes.eng.br"
```

Este comando irá gerar uma chave privada (`key.pem`) e um
certificado autoassinado (`cert.pem`) válidos por 365 dias
para o domínio `ivanlopes.eng.br`, assumindo que sua empresa
se chama "Engenharia Ivan Lopes", está localizada no bairro
Estácio, na cidade do Rio de Janeiro, Brasil. O parâmetro
`-nodes` é usado para evitar a criação de uma senha para
a chave privada.

## Com as chaves que você gerou, você pode:

- **Estabelecer conexões HTTPS seguras** para seu site,
  garantindo que a comunicação entre o servidor e os clientes
  seja criptografada e protegida contra interceptação.
- **Assinar digitalmente documentos e mensagens**,
  proporcionando garantia de que vieram de você e não foram
  alterados.
- **Criptografar e descriptografar mensagens**
  em comunicações seguras, embora para
  criptografia/descriptografia direta de dados, normalmente
  se usem chaves específicas para criptografia assimétrica,
  não um certificado SSL/TLS.

Porém, para criptografia e descriptografia arbitrária de
dados (fora do contexto de SSL/TLS), você geralmente usaria
um conjunto diferente de ferramentas e chaves projetadas
especificamente para essa finalidade.

## Para simular a criptografia e descriptografia

Para simular a criptografia e descriptografia de uma mensagem
usando OpenSSL com suas chaves, você pode seguir estes
passos. Assumiremos que você tem `key.pem` e `cert.pem`.

**Criptografar uma Mensagem (Usuário A para Usuário B)**:

1. Usuário A pode criptografar a mensagem usando a chave
   pública contida no certificado de B (`cert.pem`).

```bash
echo "Mensagem secreta" | openssl rsautl -encrypt -pubin -inkey cert.pem -out mensagem.criptografada
```

**Descriptografar a Mensagem (Usuário B)**: 2. Usuário
B pode descriptografar a mensagem usando sua chave privada
(`key.pem`).

```bash
openssl rsautl -decrypt -inkey key.pem -in mensagem.criptografada -out mensagem.descriptografada
cat mensagem.descriptografada
```

Este processo simula o envio de uma mensagem criptografada
do Usuário A para o Usuário B, onde somente o Usuário B
pode descriptografá-la usando sua chave privada.

### Erro

O aviso indica que o comando `rsautl` foi substituído por
`pkeyutl` no OpenSSL versão 3.0. Além disso, o erro sobre
a chave privada sugere que você está tentando usar a chave
pública extraída de um certificado para criptografia, mas
o OpenSSL espera a chave privada para essa operação. No
entanto, a operação correta para criptografar uma mensagem
com uma chave pública (e descriptografar com a chave privada
correspondente) ainda é viável, apenas precisa ser ajustada
para a nova sintaxe e método correto. Aqui está como você
faria isso com `pkeyutl`:

**Para criptografar com a chave pública (ajustado para o novo comando):**

```bash
echo "Mensagem secreta" | openssl pkeyutl -encrypt -pubin -inkey public.pem -out mensagem.criptografada
```

Neste caso, `public.pem` seria a chave pública extraída do
certificado. Se você não a extraiu ainda, pode fazê-lo com:

```bash
openssl x509 -pubkey -noout -in cert.pem > public.pem
```

**Para descriptografar com a chave privada:**

```bash
openssl pkeyutl -decrypt -inkey key.pem -in mensagem.criptografada -out mensagem.descriptografada
```

Isso irá corrigir o problema e permitir a criptografia e
descriptografia da mensagem.

## Python

Aqui está um exemplo simples em Python que lê um arquivo
criptografado e mostra a mensagem descriptografada na tela,
assumindo que você tem a chave privada `key.pem`:

```python
from OpenSSL import crypto
import sys

# Arquivo criptografado e chave privada
encrypted_file = 'mensagem.criptografada'
private_key_file = 'key.pem'

# Carrega a chave privada
with open(private_key_file, 'rb') as key_file:
    private_key = crypto.load_privatekey(crypto.FILETYPE_PEM, key_file.read())

# Carrega a mensagem criptografada
with open(encrypted_file, 'rb') as encrypted_file:
    encrypted_data = encrypted_file.read()

# Descriptografa a mensagem
try:
    decrypted_data = crypto.decrypt(private_key, encrypted_data, 'RSA_PKCS1_OAEP_PADDING')
    print('Mensagem descriptografada:', decrypted_data.decode('utf-8'))
except Exception as e:
    print('Erro ao descriptografar a mensagem:', e)
```

Este script usa a biblioteca PyOpenSSL para descriptografar
o conteúdo de um arquivo usando RSA com padding
OAEP. Certifique-se de que a biblioteca PyOpenSSL esteja
instalada no seu ambiente (`pip install pyopenssl`). Este
exemplo pressupõe que a mensagem foi criptografada usando
o padrão RSA com padding OAEP, que é um método seguro e
comum para criptografia de mensagens.

### Erro

Para ajustar seu código Python para a biblioteca
`cryptography` para descriptografar um arquivo, você pode
fazer o seguinte:

```python
from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives.asymmetric import padding
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.backends import default_backend
import os

# Caminho para sua chave privada e arquivo criptografado
private_key_path = 'key.pem'
encrypted_file_path = 'mensagem.criptografada'

# Carregar a chave privada
with open(private_key_path, "rb") as key_file:
    private_key = serialization.load_pem_private_key(
        key_file.read(),
        password=None,
        backend=default_backend()
    )

# Carregar o arquivo criptografado
with open(encrypted_file_path, "rb") as encrypted_file:
    encrypted_data = encrypted_file.read()

# Descriptografar a mensagem
try:
    decrypted_data = private_key.decrypt(
        encrypted_data,
        padding.OAEP(
            mgf=padding.MGF1(algorithm=hashes.SHA256()),
            algorithm=hashes.SHA256(),
            label=None
        )
    )
    print('Mensagem descriptografada:', decrypted_data.decode('utf-8'))
except Exception as e:
    print('Erro ao descriptografar a mensagem:', e)
```

Este código utiliza a biblioteca `cryptography` para
descriptografar um arquivo usando RSA com padding OAEP,
que é uma forma segura de criptografia assimétrica.

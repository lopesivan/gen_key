from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives.asymmetric import padding
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.backends import default_backend
import os

# Caminho para sua chave privada e arquivo criptografado
private_key_path = "key.pem"
encrypted_file_path = "mensagem.criptografada"

# Carregar a chave privada
with open(private_key_path, "rb") as key_file:
    private_key = serialization.load_pem_private_key(
        key_file.read(), password=None, backend=default_backend()
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
            label=None,
        ),
    )
    print("Mensagem descriptografada:", decrypted_data.decode("utf-8"))
except Exception as e:
    print("Erro ao descriptografar a mensagem:", e)

#include <openssl/err.h>
#include <openssl/pem.h>
#include <openssl/rsa.h>
#include <stdio.h>
#include <stdlib.h>

int main()
{
    ERR_load_crypto_strings();

    FILE* fp = fopen("key.pem", "rb");
    RSA* rsa = PEM_read_RSAPrivateKey(fp, NULL, NULL, NULL);
    fclose(fp);
    if (!rsa)
    {
        ERR_print_errors_fp(stderr);
        exit(1);
    }

    FILE* in = fopen("mensagem.criptografada", "rb");
    fseek(in, 0, SEEK_END);
    long len = ftell(in);
    fseek(in, 0, SEEK_SET);
    unsigned char* encrypted = malloc(len);
    fread(encrypted, 1, len, in);
    fclose(in);

    unsigned char decrypted[4098];
    int result = RSA_private_decrypt(len, encrypted, decrypted, rsa, RSA_PKCS1_PADDING);
    if (result == -1)
    {
        ERR_print_errors_fp(stderr);
        RSA_free(rsa);
        exit(2);
    }

    printf("%s\n", decrypted);

    RSA_free(rsa);
    free(encrypted);
    EVP_cleanup();
    return 0;
}

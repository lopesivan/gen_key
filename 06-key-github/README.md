# Adicionar sua chave SSH ao ssh-agent

Antes de adicionar uma nova chave SSH ao ssh-agent para
gerenciar suas chaves, você deve ter verificado a existência
de chaves SSH e gerado uma nova chave SSH.

1. Inicie o ssh-agent em segundo plano.

$ eval "$(ssh-agent -s)"

> Agent pid 59566

2. Adicione sua chave SSH privada ao ssh-agent.

$ ssh-add ~/.ssh/id_rsa

3. Adicione a chave SSH à sua conta GitHub.

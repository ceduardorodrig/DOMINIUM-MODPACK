# Dominium Modpack — Servidor

Branch `server` — mods + configs específicos do servidor Dominium.

Usa o mesmo sistema **Packwiz** do branch `main`, mas com:

- Apenas mods `server`/`both` (sem mods visuais/client)
- Configs do servidor (DistantHorizons, LuckPerms, etc.)
- Dados do LuckPerms (permissões e grupos)
- Script de deploy para o Crafty Controller

## Deploy no Crafty Controller

### 1. Sincronizar mods via packwiz

```bash
cd /mnt/NVME_PCI/minecraftserver \[dominium\]/MINECRAFT\ SERVER

# Baixar packwiz-installer-bootstrap (se não tiver)
curl -L -o packwiz-installer-bootstrap.jar \
  https://github.com/packwiz/packwiz-installer-bootstrap/releases/latest/download/packwiz-installer-bootstrap.jar

# Instalar/atualizar mods server-side
java -jar packwiz-installer-bootstrap.jar \
  -s server \
  https://ceduardorodrig.github.io/DOMINIUM-MODPACK/pack.toml
```

O flag `-s server` filtra apenas mods com `side = "server"` ou `side = "both"`.

### 2. Atualizar configs

```bash
cd /mnt/NVME_PCI/minecraftserver\ \[dominium\]/DOMINIUM-MODPACK
git pull

# Copiar configs (com backup automático)
cp -r config/* "/mnt/NVME_PCI/minecraftserver [dominium]/MINECRAFT SERVER/config/"
cp -r data/luckperms/ "/mnt/NVME_PCI/minecraftserver [dominium]/MINECRAFT SERVER/mods/luckperms/"

# Lembrar de trocar as senhas nos templates:
# server/server.properties → rcon.password=CHANGE_ME
# config/playit-companion/agent_key.txt → CHANGE_ME
```

### 3. Reiniciar container

```bash
docker restart crafty-controller
```

## Estrutura

```
├── mods/              # Metadados dos mods (107 mods server/both)
├── config/            # Configs do servidor (293 arquivos)
│   ├── DistantHorizons.toml
│   ├── luckperms/
│   ├── servercore/
│   ├── voicechat/
│   └── ...
├── data/luckperms/    # Banco de permissões (contexts.json + .mv.db)
├── server/            # Arquivos raiz do servidor (templates)
│   ├── server.properties      # (rcon.password=CHANGE_ME)
│   ├── ops.json
│   ├── whitelist.json
│   ├── eula.txt
│   ├── docker-compose.yml
│   ├── RCON.txt
│   └── server-icon.png
├── .gitignore         # Ignora .jar, usercache.json e dados sensíveis
└── deploy.sh          # Script de deploy automático
```

## Deploy rápido

```bash
chmod +x deploy.sh
./deploy.sh
```

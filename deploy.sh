#!/usr/bin/env bash
set -euo pipefail

# Deploy script — Dominium Modpack (server branch)
# Atualiza mods e configs do servidor Minecraft no Crafty Controller.

REPO_DIR="/home/edu/DOMINIUM-MODPACK"
SERVER_DIR="/mnt/NVME_PCI/minecraftserver [dominium]/MINECRAFT SERVER"
BRANCH="server"
PACK_URL="https://ceduardorodrig.github.io/DOMINIUM-MODPACK/pack.toml"
BOOTSTRAP_JAR="$SERVER_DIR/packwiz-installer-bootstrap.jar"
BOOTSTRAP_URL="https://github.com/packwiz/packwiz-installer-bootstrap/releases/latest/download/packwiz-installer-bootstrap.jar"

echo "=== Dominium Server Deploy ==="
echo ""

# 1. Atualizar repo
echo "[1/4] Atualizando repo..."
cd "$REPO_DIR"
git checkout "$BRANCH" 2>/dev/null || git checkout -b "$BRANCH"
git pull origin "$BRANCH"

# 2. Baixar packwiz-installer se não existir
echo "[2/4] Sincronizando mods via packwiz..."
if [ ! -f "$BOOTSTRAP_JAR" ]; then
  curl -L -o "$BOOTSTRAP_JAR" "$BOOTSTRAP_URL"
fi
java -jar "$BOOTSTRAP_JAR" -s server "$PACK_URL"

# 3. Copiar configs (com backup)
echo "[3/4] Copiando configs..."
BACKUP_DIR="$SERVER_DIR/.config-backup/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR/config"
cp -r "$SERVER_DIR/config/" "$BACKUP_DIR/config/"
cp -r config/* "$SERVER_DIR/config/"

# 4. Copiar LuckPerms data
echo "[3/4] Copiando dados do LuckPerms..."
mkdir -p "$SERVER_DIR/mods/luckperms/"
cp -r data/luckperms/* "$SERVER_DIR/mods/luckperms/"

echo "[4/4] Backup salvo em: $BACKUP_DIR"
echo ""
echo "=== Deploy concluído! ==="
echo "Reinicie o container: docker restart crafty-controller"
echo ""
echo "ATENCAO: Verifique se os placeholders foram substituídos:"
echo "  - server.properties → rcon.password=CHANGE_ME"
echo "  - playit-companion/agent_key.txt → CHANGE_ME"

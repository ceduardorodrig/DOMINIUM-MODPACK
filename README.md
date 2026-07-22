# Dominium Modpack

Modpack oficial do servidor Dominium — Minecraft 1.21.1 Fabric.

**Packwiz + GitHub Pages** com auto-update via `packwiz-installer-bootstrap`.

## Instalação (amigos)

### Pré-requisitos
- **Java 21** ([Adoptium](https://adoptium.net/) ou [Oracle](https://www.oracle.com/java/technologies/downloads/#java21))
- **PrismLauncher** ([Download](https://prismlauncher.org/download/windows/))

### 1. Criar instância
1. Abra o PrismLauncher
2. `Adicionar Instância` → `Custom`:
   - Versão: **1.21.1**
   - Loader: **Fabric**
3. Selecione a instância criada e clique em `Editar`

### 2. Configurar auto-update (packwiz-installer-bootstrap)
1. Baixe o [packwiz-installer-bootstrap.jar](https://github.com/packwiz/packwiz-installer-bootstrap/releases/latest) (v0.0.3+)
2. Coloque o `.jar` na pasta `minecraft/` da instância (ao lado de `options.txt`)
3. Em `Editar Instância` → `Configurações` → `Comando de Pré-lançamento`:
   ```
   "$INST_JAVA" -jar packwiz-installer-bootstrap.jar https://ceduardorodrig.github.io/DOMINIUM-MODPACK/pack.toml
   ```
4. Ative a opção para o comando rodar sempre antes de iniciar

Agora, ao iniciar o jogo, o bootstrap baixa os 118 mods automaticamente. Nas próximas execuções, ele verifica se há atualizações e baixa só o que mudou.

### 3. Configurar RAM
No PrismLauncher, `Editar Instância` → `Configurações` → `Java`:
- **Mínimo**: 2048 MB
- **Máximo**: 6144 MB (ou mais, se seu PC permitir)

### 4. Conectar ao servidor
- **IP**: `dominium.mc-srv.com` (ou o IP atual do servidor)
- **Porta**: 25565 (padrão)

### 5. Opcionais (resource packs)
O pack já inclui 2 resource packs via Modrinth. Você pode baixar mais manualmente:
- **Fresh Animations**: https://modrinth.com/resourcepack/fresh-animations
- **Bare Bones**: https://modrinth.com/resourcepack/bare-bones

Coloque os `.zip` na pasta `resourcepacks/` da instância e ative no jogo em `Opções → Resource Packs`.

## Para desenvolvedores (atualizar mods)

### No Psicopompo (Linux)
```bash
cd /mnt/NVME_PCI/minecraftserver\ \[dominium\]/DOMINIUM-MODPACK

# Atualizar todos os mods para última versão compatível
packwiz update --all

# Se um mod específico quebrar, pode fixar a versão:
# packwiz mr add <slug> --version-id <id>

# Atualizar index
packwiz refresh

# Commitar e publicar
git add -A
git commit -m "Atualizar mods para $(date +%d/%m/%Y)"
git push
```

### Adicionar um mod novo
```bash
# Mods do Modrinth
packwiz mr add <slug>

# Mods de URL direta (ex: versão beta de algum mod)
packwiz url add <nome> <url_do_jar>

# Depois
packwiz refresh
git add -A && git commit -m "Adicionar <mod>" && git push
```

### Remover um mod
```bash
packwiz remove <slug>
packwiz refresh
git add -A && git commit -m "Remover <mod>" && git push
```

## Sincronização com o servidor

O servidor roda no **crafty-controller** (Docker) no Psicopompo.

Para atualizar os mods do servidor com os do pack:
```bash
python3 /mnt/NVME_PCI/minecraftserver\\ \[dominium\]/sync_mods.py
```

(O script baixa os mods `both`/`server` do packwiz e reinicia o container.)

## Estrutura do repositório
```
├── pack.toml          # Configuração do packwiz
├── index.toml         # Índice com hashes de todos os arquivos
├── mods/              # Metadados dos mods (.pw.toml)
├── config/            # Configurações do cliente
├── resourcepacks/     # Metadados dos resource packs
├── .gitattributes     # Desabilita conversão de linha (importante para hashes)
└── .gitignore         # Ignora .jar, .zip, .mrpack
```

## Licença

Este repositório contém apenas metadados. Os mods são propriedade de seus respectivos autores e estão sujeitos às suas próprias licenças.

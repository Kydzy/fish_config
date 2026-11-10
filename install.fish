#!/usr/bin/env fish

# Détermine le dossier du dépôt (compatible Fish 3.3.1).
set -l repo_dir (dirname (status --current-filename))

set -l source_file "$repo_dir/functions/fish_prompt.fish"
set -l target_dir "$HOME/.config/fish/functions"

# Vérifie que le fichier source existe.
if not test -f "$source_file"
    echo "Erreur : fish_prompt.fish introuvable."
    exit 1
end

# Crée le dossier de destination.
mkdir -p "$target_dir"
or exit 1

# Installe la configuration.
cp "$source_file" "$target_dir/fish_prompt.fish"
or exit 1

echo "Configuration Fish installée avec succès !"
echo "Redémarre Fish pour appliquer les changements."

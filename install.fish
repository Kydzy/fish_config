#!/usr/bin/fish
#!/usr/bin/env fish

set -l repo_dir (path dirname (status --current-filename))
set -l fish_config "$HOME/.config/fish"

mkdir -p "$fish_config/functions"

cp "$repo_dir/functions/fish_prompt.fish" "$fish_config/functions/fish_prompt.fish"

echo "Configuration Fish installee avec succes !"
echo "Redemarre Fish pour appliquer les changements."

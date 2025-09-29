
SCRIPT_PATH="/usr/local/share/install_oh_my_zsh_plugins.sh"
tee "$SCRIPT_PATH" > /dev/null \
<< 'EOF'
#!/usr/bin/env bash
set -e

ZSH_PLUGINS=${ZSH_CUSTOM:-/home/vscode/.oh-my-zsh/custom}/plugins

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_PLUGINS}/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_PLUGINS}/zsh-syntax-highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_PLUGINS}/fast-syntax-highlighting
git clone https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_PLUGINS}/zsh-autocomplete

# Read the content of the .zshrc file
content=$(cat "/home/vscode/.zshrc")

# Use sed to find and modify the line with the plugins variable
new_content=$(echo "$content" | sed "s/plugins=(.*)/plugins=(git zsh-autosuggestions fast-syntax-highlighting docker kubectl)/g")

# Write the modified content back to the .zshrc file
echo "$new_content" > "/home/vscode/.zshrc"

echo "Plugins variable modified and .zshrc sourced."

# Persist ZSH history
mkdir -p /commandhistory
chown -R vscode:vscode /commandhistory
# Create the .zsh_history file if it doesn't exist
if [ ! -f /commandhistory/.zsh_history ]; then
    touch /commandhistory/.zsh_history
fi
# Append the history configuration to .zshrc
if ! grep -q "export HISTFILE=/commandhistory/.zsh_history" /home/vscode/.zshrc; then
    echo "autoload -Uz add-zsh-hook; append_history() { fc -W }; add-zsh-hook precmd append_history; export HISTFILE=/commandhistory/.zsh_history" >> /home/vscode/.zshrc
fi

EOF

chmod +x $SCRIPT_PATH

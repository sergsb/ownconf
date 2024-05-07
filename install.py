import shutil

files = ['nvim','tmux.conf']
#Check that files exists, exit if not exists
for file in files:
    if not os.path.exists(file):
        print(f"File {file} not exists")
        exit(1)

#Copy directory nvim to ~/.config/nvim
shutil.copytree('nvim', '~/.config/nvim')
#Create directory ~/.config/tmux if not exists
shutil.copytree('tmux', '~/.config/tmux')
#Copy tmux.conf to ~/.config/tmux/tmux.conf
shutil.copy('tmux.conf', '~/.config/tmux/tmux.conf')

aliases = {"vim":"nvim","vi":"nvim","oldvim":"vim","vimdiff":"nvim -d","xclip":"xclip -selection c","gpuc":"watch -n 0.2 nvidia-smi","ls":"ls -F","ll":"ls -lh","lt":"du -sh * | sort -h","count":"find . -type f | wc -l","cpv":"rsync -ah --info=progress2","..":"cd ..","hg":"history | grep"}
enviroment = {"EDITOR":"nvim"}

tmux_autoload = """
tmux autoload
 if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
   exec tmux new-session -A -s main
 fi
"""

zsh_history = """
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000000
SAVEHIST=100000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
"""

set-option -g default-terminal screen-256color
set-option -ga terminal-overrides ",xterm-256color:Tc"

set-option -g mouse on

set -g prefix C-k
unbind C-i

# Set new panes to open in current directory
bind c new-window -c "#{pane_current_path}"
bind '"' split-window -c "#{pane_current_path}"
bind % split-window -h -c "#{pane_current_path}"


### TPM

# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'

set -g @plugin 'egel/tmux-gruvbox'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run -b '~/.tmux/plugins/tpm/tpm'

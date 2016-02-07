# Change prefix key
set-option -g prefix C-a
unbind-key C-b
bind-key C-a send-prefix

# Default global options
set-option -g default-shell /bin/fish
set-option -g terminal-overrides 'xterm*:smcup@:rmcup@'
set-option -g base-index 1
set-option -g bell-action none
set-option -g default-terminal "xterm-256color"
set-option -g history-limit 8192
set-option -g set-titles on
set-option -g set-titles-string "#T"
set-option -g status on
set-option -g status-left ""
set-option -g status-right " #[fg=colour15] CPU #[fg=colour33]#(~/Code/proc.sh) #[fg=colour15]MEM #[fg=colour33]#(~/Code/mem.sh) #[fg=colour15]· #[fg=colour33]#H #[fg=colour15]· #[fg=colour33]#(date +'%H:%M') "
set-option -g status-position bottom
set-option -g status-style ""
set-option -g status-keys vi

# Default global window options
set-window-option -g mode-keys vi
set-window-option -g utf8 on
set-window-option -g pane-base-index 1
set-window-option -g automatic-rename off
set-window-option -g window-status-format "#[bg=colour231]#[fg=black] #I #[bg=colour252]#[fg=black] #W "
set-window-option -g window-status-current-format "#[bg=colour160]#[fg=colour231] #I #[bg=colour124]#[fg=colour231] #W "

# white colour231
# cyan colour81
# orange colour166
# grey colour243
# green colour40
# dark grey colour235
# blue colour33
# red colour160

# Keys to switch session
bind-key q switchc -t0
bind-key w switchc -t1
bind-key e switchc -t2

# Other key bindings
bind-key i choose-window
# unbind-key C-PgDn
# unbind-key C-PgUp
unbind-key PPage
unbind-key NPage
bind-key -n "M-PPage" command-prompt "split-window -v"
bind-key -n "M-NPage" command-prompt "split-window -h"
bind-key D detach \; lock
bind-key N neww \; splitw -d
bind-key -n "C-n" new-window
bind-key -n "C-h" select-window -t :-
bind-key -n "C-l" select-window -t :+
bind-key -n "C-k" select-pane -t :.-
bind-key -n "C-j" select-pane -t :.+

# Statusbar
# ---------

# Show messages and notifications for 2 seconds
set-option -g display-time 2000

# Refresh the statusbar every 1 second
set-option -g status-interval 60

# Colors
# ------

# Default statusbar colors
# set-option -g status-bg colour235 #base02
# set-option -g status-fg colour136 #yellow
# set-option -g status-attr default

# Default window title colors
# set-window-option -g window-status-fg colour231
# set-window-option -g window-status-bg colour237
# set-window-option -g window-status-attr none
# set-window-option -g window-status-separator ""

# Active window title colors
# set-window-option -g window-status-current-fg colour166 #orange
# set-window-option -g window-status-current-bg default
# set-window-option -g window-status-current-attr bright

# set-window-option -g window-status-activity-bg colour237
# set-window-option -g window-status-activity-attr underscore
# set-window-option -g window-status-activity-fg colour231

# Pane border
# set-option -g pane-border-fg colour243
set-option -g pane-active-border-fg colour160

# Message text
# set-option -g message-bg colour81
# set-option -g message-fg colour231
# set-option -g message-command-bg colour81
# set-option -g message-command-fg colour231

# Pane number display
# set-option -g display-panes-active-colour colour33 #blue
# set-option -g display-panes-colour colour166 #orange

# Clock
# set-window-option -g clock-mode-colour colour64 #green

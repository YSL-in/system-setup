#!/bin/bash

# power & screen lock settings
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false
gsettings set org.gnome.desktop.session idle-delay 900
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 900  # 15 minutes
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 900  # 15 minutes
gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'suspend'
gsettings set org.gnome.desktop.interface show-battery-percentage true

gsettings set org.gnome.desktop.screensaver lock-enabled true
gsettings set org.gnome.desktop.screensaver lock-delay 30
gsettings set org.gnome.desktop.notifications show-in-lock-screen false

# multitasking settings
gsettings set org.gnome.shell.app-switcher current-workspace-only true
gsettings set org.gnome.mutter workspaces-only-on-primary true

# Keyboard shortcuts
gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-up "[]"
gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-down "[]"
gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-left "[]"
gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-right "[]"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Shift><Control><Super>Left']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Shift><Control><Super>Right']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-last "[]"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1 "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Control><Super>Left']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Control><Super>Right']"
gsettings set org.gnome.desktop.wm.keybindings switch-panels "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-panels-backward "[]"

gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Super>d']"
gsettings set org.gnome.desktop.wm.keybindings toggle-maximized "['<Super>Up']"

gsettings set org.gnome.shell.keybindings toggle-message-tray "['<Alt>1']"
gsettings set org.gnome.shell.keybindings toggle-quick-settings "['<Alt>2']"
gsettings set org.gnome.shell.keybindings toggle-overview "['<Alt>space']"
gsettings set org.gnome.shell.keybindings screenshot "['<Shift><Ctrl><Alt>3']"
gsettings set org.gnome.shell.keybindings screenshot-window "['<Super>Print']"
gsettings set org.gnome.shell.keybindings show-screenshot-ui "['<Shift><Ctrl><Alt>4']"

gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Super>e']"

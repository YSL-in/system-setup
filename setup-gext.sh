#!/bin/bash

sudo apt-get install -y gnome-shell-extension-manager
google-chrome https://chromewebstore.google.com/detail/gnome-shell-integration/gphhapmejobijbbhgpjhcjognlahblep \
   https://extensions.gnome.org

# Ref: https://extensions.gnome.org
wget -O apps-menu.zip 'https://extensions.gnome.org/extension-data/apps-menugnome-shell-extensions.gcampax.github.com.v64.shell-extension.zip'
wget -O caffeine.zip 'https://extensions.gnome.org/extension-data/caffeinepatapon.info.v57.shell-extension.zip'
wget -O clipboard-indicator.zip 'https://extensions.gnome.org/extension-data/clipboard-indicatortudmotu.com.v68.shell-extension.zip'
wget -O coverflow-alt-tab.zip 'https://extensions.gnome.org/extension-data/CoverflowAltTabpalatis.blogspot.com.v78.shell-extension.zip'
wget -O places-status-indicator.zip 'https://extensions.gnome.org/extension-data/places-menugnome-shell-extensions.gcampax.github.com.v68.shell-extension.zip'
wget -O top-panel-workspace-scroll.zip 'https://extensions.gnome.org/extension-data/scroll-workspacesgfxmonk.net.v38.shell-extension.zip'

gnome-extensions install apps-menu.zip
gnome-extensions install caffeine.zip
gnome-extensions install clipboard-indicator.zip
gnome-extensions install coverflow-alt-tab.zip
gnome-extensions install places-status-indicator.zip
gnome-extensions install top-panel-workspace-scroll.zip

rm apps-menu.zip caffeine.zip clipboard-indicator.zip coverflow-alt-tab.zip \
   places-status-indicator.zip top-panel-workspace-scroll.zip

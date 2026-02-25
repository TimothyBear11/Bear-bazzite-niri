#!/bin/bash
set -ouex pipefail

### Add Terra Repo (for noctalia-shell, zed, and more)
dnf5 -y install terra-release

### Add Antigravity repo (for the Antigravity AI IDE)
tee /etc/yum.repos.d/antigravity.repo > /dev/null << EOF
[antigravity-rpm]
name=Antigravity RPM Repository
baseurl=https://us-central1-yum.pkg.dev/projects/antigravity-auto-updater-dev/antigravity-rpm
enabled=1
gpgcheck=1
gpgkey=https://us-central1-yum.pkg.dev/projects/antigravity-auto-updater-dev/antigravity-rpm/gpg
EOF

dnf5 makecache

### Remove full KDE Plasma (we're going Niri + Noctalia)
dnf5 -y remove plasma-workspace plasma-* kde-*


### Install packages
# All apps from your list that are best as layered RPMs (native integration, system-wide CLI tools, Niri ecosystem, minimal KDE apps, etc.)
# RPMFusion is enabled by default in Bazzite/ublue images
dnf5 -y install \
    niri \
    gnome-keyring \
    xwayland-satellite \
    kitty \
    fish \
    fastfetch \
    vesktop \
    noctalia-shell \
    cava \
    ddcutil \
    cliphist \
    wlsunset \
    antigravity \
    dolphin \
    kate \
    ark \
    telegram-desktop \
    neovim \
    zed \
    direnv \
    eza \
    fzf \
    zoxide \
    starship \
    bat \
    gh \
    nodejs \
    python3-pip

### Post-install: npm & pip tools (gemini-cli and pywalfox + pywal)
# gemini-cli (your "gemeni-cli" — Google Gemini terminal agent)
npm install -g @google/gemini-cli

# pywalfox (Firefox/Theming) + pywal (required for it to work)
pip3 install --break-system-packages pywal pywalfox

### Systemd setup (kept from your original + Niri focus)
systemctl enable podman.socket
systemctl --global add-wants niri.service swayidle.service
systemctl --global add-wants niri.service plasma-polkit-agent.service

echo "✅ Custom Bazzite build complete!"
echo "   • Niri + Noctalia Shell + all requested tools layered"
echo "   • Floorp & Spotify → install as Flatpaks after first boot (best practice on immutable images)"
echo "   • Run 'gemini' or 'pywalfox install' in your user session to finish setup"


$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

pip install --upgrade pip
pip --version
pip install flake8 autopep8 jupyter neovim matplotlib numpy scipy pandas
# torch torchvision tensorflow
pip list


npm update  --global
npm install --global npm
npm --version
npm install --global yarn eslint neovim gtop prettier @fsouza/prettierd
npm list    --global


rustup update
rustup default stable
cargo --version
cargo install bat fd-find hexyl procs ripgrep sd zoxide svls texlab stylua git-delta alacritty
# exa sheldon starship zellij
cargo install --list

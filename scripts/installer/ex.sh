
cp -rf ~/dotfiles/scripts/installer/texlive.profile profile_buf1.txt
cp -rf profile_buf1.txt profile_buf2.txt
sed -e "4a TEXMFSYSVAR $HOME/.local/opt/texlive/2021/texmf-var" profile_buf2.txt > profile_buf1.txt
cp -rf profile_buf1.txt profile_buf2.txt
sed -e "4a TEXMFSYSCONFIG $HOME/.local/opt/texlive/2021/texmf-config" profile_buf2.txt > profile_buf1.txt
cp -rf profile_buf1.txt profile_buf2.txt
sed -e "4a TEXMFLOCAL $HOME/.local/opt/texlive/texmf-local" profile_buf2.txt > profile_buf1.txt
cp -rf profile_buf1.txt profile_buf2.txt
sed -e "4a TEXMFHOME $HOME/.cache/texlive2021/texmf" profile_buf2.txt > profile_buf1.txt
cp -rf profile_buf1.txt profile_buf2.txt
sed -e "4a TEXMFVAR $HOME/.cache/texlive2021/texmf-var" profile_buf2.txt > profile_buf1.txt
cp -rf profile_buf1.txt profile_buf2.txt
sed -e "4a TEXMFCONFIG $HOME/.cache/texlive2021/texmf-config" profile_buf2.txt > profile_buf1.txt
cp -rf profile_buf1.txt profile_buf2.txt
sed -e "4a TEXDIR $HOME/.local/opt/texlive/2021" profile_buf2.txt > profile_buf1.txt

cp -rf profile_buf1.txt ans.txt
cat ans.txt

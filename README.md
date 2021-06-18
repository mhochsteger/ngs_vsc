## Scripts to install NGSolve on VSC4

To install NGSolve run in your home directory:

```
git clone https://github.com/mhochsteger/ngs_vsc
cd ngs_vsc
./install.sh
cp -a privatemodules ~/
cd
echo "module load use.own" >> .bashrc
echo "module load ngsolve" >> .bashrc
```


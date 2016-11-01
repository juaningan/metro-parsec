## Install deps
zap refresh  
zap install TRIBarchiver-gnu-tar  
zap install TRIBcdrtools  
zap install TRIBeditor-vim

## Download MVI scripts
mkdir -p /packages/localsrc/Tribblix/mvi  
wget "https://github.com/ptribble/mvi/archive/master.tar.gz" -O- | tar xvz -C /packages/localsrc/Tribblix/mvi --strip 1  

## Download custom MVI scrips
wget "https://github.com/juaningan/parsec-mvi/archive/master.tar.gz" -O- | tar xvz -C /packages/localsrc/Tribblix/mvi --strip 1

## Launch build script
cd /packages/localsrc/Tribblix/mvi; bash -e -x ./mvi.sh 32bit dhcp debug nodisk realport fvwm tce xorg

## Other launch options
bash -e -x ./mvi-mkfs.sh 32bit dhcp tce-installer
bash -e -x ./mvi-noiso.sh 32bit dhcp debug realport motif tce xorg



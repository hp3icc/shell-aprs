sudo cat > /bin/menu-aprs <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC Menu Shell-APRS" --menu "Suba o Baje con las flechas del teclado y seleccione el numero de opcion:" 23 56 13 \
1 " Editar Beacom1 " \
2 " Editar Beacom2 " \
3 " Editar Beacom3 " \
4 " Start/Restart Beacom1 " \
5 " Start/Restart Beacom2  " \
6 " Start/Restart Beacom3 " \
7 " Stop Beacom1  " \
8 " Stop Beacom2   " \
9 " Stop Beacom3 " \
10 " Menu Principal " 3>&1 1>&2 2>&3)
exitstatus=$?
#on recupere ce choix
#exitstatus=$?
if [ $exitstatus = 0 ]; then
    echo "Your chosen option:" $choix
else
    echo "You chose cancel."; break;
fi
# case : action en fonction du choix
case $choix in
1)
sudo nano /opt/shell-aprs/bcom1.sh ;;
2)
sudo nano /opt/shell-aprs/bcom2.sh ;;
3)
sudo nano /opt/shell-aprs/bcom3.sh ;;
4)
sudo systemctl stop aprsb1.service && sudo systemctl start aprsb1.service &&  sudo systemctl enable aprsb1.service ;;
5)
sudo systemctl stop aprsb2.service && sudo systemctl start aprsb2.service &&  sudo systemctl enable aprsb2.service ;;
6)
sudo systemctl stop aprsb3.service && sudo systemctl start aprsb3.service &&  sudo systemctl enable aprsb3.service ;;
7)
sudo systemctl stop aprsb1.service &&  sudo systemctl disable aprsb1.service ;;
8)
sudo systemctl stop aprsb2.service &&  sudo systemctl disable aprsb2.service ;;
9)
sudo systemctl stop aprsb3.service &&  sudo systemctl disable aprsb3.service ;;
10)
break;
esac
done
exit 0
EOF
######

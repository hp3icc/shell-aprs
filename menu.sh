sudo cat > /bin/menu-aprs <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC Menu Shell-APRS" --menu "Suba o Baje con las flechas del teclado y seleccione el numero de opcion:" 23 56 13 \
1 " Editar Beacon-1 " \
2 " Editar Beacon-2 " \
3 " Editar Beacon-3 " \
4 " Editar Beacon-4 " \
5 " Start/Restart Beacon-1 " \
6 " Start/Restart Beacon-2  " \
7 " Start/Restart Beacon-3 " \
8 " Start/Restart Beacon-4 " \
9 " Stop Beacon-1  " \
10 " Stop Beacon-2   " \
11 " Stop Beacon-3 " \
12 " Stop Beacon-4 " \
13 " Menu Principal " 3>&1 1>&2 2>&3)
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
sudo nano /opt/shell-aprs/bcom4.sh ;;
5)
sudo systemctl stop aprsb1.service && sudo systemctl start aprsb1.service &&  sudo systemctl enable aprsb1.service ;;
6)
sudo systemctl stop aprsb2.service && sudo systemctl start aprsb2.service &&  sudo systemctl enable aprsb2.service ;;
7)
sudo systemctl stop aprsb3.service && sudo systemctl start aprsb3.service &&  sudo systemctl enable aprsb3.service ;;
8)
sudo systemctl stop aprsb4.service && sudo systemctl start aprsb4.service &&  sudo systemctl enable aprsb4.service ;;
9)
sudo systemctl stop aprsb1.service &&  sudo systemctl disable aprsb1.service ;;
10)
sudo systemctl stop aprsb2.service &&  sudo systemctl disable aprsb2.service ;;
11)
sudo systemctl stop aprsb3.service &&  sudo systemctl disable aprsb3.service ;;
12)
sudo systemctl stop aprsb4.service &&  sudo systemctl disable aprsb4.service ;;
13)
break;
esac
done
exit 0
EOF
######
chmod +x /bin/menu*

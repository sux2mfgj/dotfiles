MINECRAFT_IP := 54.186.158.76

all:
	cat Makefile

aizu_network:
	sudo wpa_supplicant -B -i wlp3s0 -c /etc/wpa_supplicant/wpa_supplicant.conf
	sudo dhclient wlp3s0

aizu_network_kill:
	sudo pkill wpa_supplicant
	sudo pkill dhclient

kadoccho:
	sudo sed -i '1s/^/nameserver 163.143.94.180\n/' /etc/resolv.conf

startx:
	startx --listen tcp

setup:
	slack &

xmodmap:
	xmodmap $(HOME)/.xmodmap
	xmodmap $(HOME)/.xmodmap.a

ssh_u_aizu:
	ssh -c 3des-cbc -l m5211133 sshgate.u-aizu.ac.jp 

ssh_kadoccho:
	ssh ubuntu@kadoccho.org

minecraft_isi:
	ssh -i ~/.ssh/chacha_isizaka_minecraft.pem ubuntu@$(MINECRAFT_IP)

run_minecraft:
	java -jar ~/Downloads/Minecraft.jar

display_conn:
	xrandr --output LVDS-1 --auto --output VGA1 --auto --right-of LVDS-1  

display_dis:
	xrandr --output VGA1 --off

inspect_history:
	cat ~/.zsh_history| sort |uniq -c |sort -n |tail -n 30

show_lbs:
	sort -n `find ~/logbook/ -type f`
#tail -vn +1 `find ~/logbook/ -type f`
#tail -vn +1 $(HOME)/logbook/*


ssh_gsoc:
#ssh root@`sudo virsh net-dhcp-leases default | grep gsoc2017 | awk '{print substr($$5, 1, (length($$5)+1)-4)}'`
	ssh hima@`sudo virsh net-dhcp-leases default | grep gsoc2017 | awk '{print substr($$5, 1, (length($$5)+1)-4)}'`

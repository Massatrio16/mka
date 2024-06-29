 # memanggil direktori saat ini
current_directory=$(pwd)




echo " "
echo " TWRP BUILD CONFIGURATION "
echo " "

# Membuat Folder twrp
 cd /.workspace
 mkdir twrp
 cd twrp


# Input Konfigurasi Pengguna 
 
 echo "Manifest AOSP Branch AVAILABLE : \
 - 11 \
 - 12.1 \ "
 echo "Pilih Manifest branch : "
read Manifest_branch
if [ -z "$Manifest_branch" ]; then
    echo "Input Manifest branch kosong!."
    exit 1
fi
echo "Link Device tree twrp : "
read Device_tree
if [ -z "${Device_tree}" ]; then
    echo "Input Device tree Kosong !"
    exit 1
fi
echo "Branch Device_tree_twrp : "
read Branch_dt_twrp
if [ -z "${Branch_dt_twrp}" ]; then
    echo "Input branch device tree Kosong !"
    exit 1
fi
echo "Device Path : "
read Device_Path
if [ -z "${Device_Path}" ]; then
    echo "Input Device path Kosong!"
    exit 1
fi
echo "Device Name : "
read Device_Name
if [ -z "{$Device_Name}" ]; then
    echo "Input Device Name Kosong!"
    exit 1
fi
echo "Build Target (recovery,boot,vendorboot) : "
read Build_Target
 if [ -z "${Build_Target}" ]; then
    echo "Input Build Target Kosong!"
    exit 1
fi


# Menyimpan Konfigurasi ke File save settings
echo " "
echo "Konfigurasi Tersimpan"
echo " "
sed -i "s|Device_tree=.*|Device_tree=$Device_tree|" ${current_directory}/save_settings.txt
 
sed -i "s|Branch_dt_twrp=.*|Branch_dt_twrp=$Branch_dt_twrp|" ${current_directory}/save_settings.txt


sed -i "s|Device_Path=.*|Device_Path=$Device_Path|" ${current_directory}/save_settings.txt

sed -i "s|Device_Name=.*|Device_Name=$Device_Name|" ${current_directory}/save_settings.txt

sed -i "s|Build_Target=.*|Build_Target=$Build_Target|" ${current_directory}/save_settings.txt


# Menginstall Package Yang diperlukan

echo " "
echo "  Build Environment "
echo " "

  apt update
  apt -y upgrade
  apt -y install gperf gcc-multilib gcc-10-multilib g++-multilib g++-10-multilib libc6-dev lib32ncurses5-dev x11proto-core-dev libx11-dev tree lib32z-dev libgl1-mesa-dev libxml2-utils xsltproc bc ccache lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libwxgtk3.0-gtk3-dev libxml2 lzop pngcrush schedtool squashfs-tools imagemagick libbz2-dev lzma ncftp qemu-user-static libstdc++-10-dev libtinfo5
   #add-apt-repository universe
   apt install nano bc bison ca-certificates curl flex gcc git libc6-dev libssl-dev openssl python-is-python3 ssh wget zip zstd  make clang gcc-arm-linux-gnueabi software-properties-common build-essential libarchive-tools gcc-aarch64-linux-gnu -y &&  apt install build-essential -y &&  apt install libssl-dev libffi-dev libncurses5-dev zlib1g zlib1g-dev libreadline-dev libbz2-dev libsqlite3-dev make gcc -y &&  apt install pigz -y &&  apt install python2 -y &&  apt install python3 -y &&  apt install cpio -y &&  apt install lld -y &&  apt install llvm -y
   apt -y install libncurses5
   apt -y install rsync
   apt -y install repo


   # Sync Minimal Manifest
   
   
        git config --global user.name "Nico170420"
        git config --global user.email "b170420nc@gmail.com"
        
        repo init --depth=1 -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-${Manifest_branch} 
        
        repo sync


        # Clone Device tree Twrp
        echo " "
        echo " Cloning Device Tree "
        echo " "
        git clone ${Device_tree} -b ${Branch_dt_twrp} ${Device_Path}
        echo " "
        echo " Building Recovery "
        echo " "
        sleep 1


        # Build Twrp
         export ALLOW_MISSING_DEPENDENCIES=true; . build/envsetup.sh; cd ${Device_Path}; lunch twrp_${Device_Name}-eng; mka ${Build_Target}image


        # Menyalin Hasil Build Ke Folder saat ini 
        
       if [ "${Build_Target}" = "vendorboot" ]; then
         cp -r ../../../out/target/product/${Device_Name}/vendor_boot.img ${current_directory}
         else
         cp -r ../../../out/target/product/${Device_Name}/${Build_Target}.img ${current_directory}     
        fi
cd ${current_directory}
if [ "${Build_Target}" = "vendorboot" ]; then
mv vendor_boot.img TWRP_${Device_Name}_vendor_boot.img
else
mv ${Build_Target}.img TWRP_${Device_Name}_${Build_Target}.img
fi

cd ${current_directory}
echo " "
echo "Done Build"
echo " "
if [ "${Build_Target}" = "vendorboot" ]; then
chmod a+x TWRP_${Device_Name}_vendor_boot.img
else
chmod a+x TWRP_${Device_Name}_${Build_Target}.img
fi


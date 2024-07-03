

###########################################################
###########################################################

bot_notif() {

source ${current_directory}/save_settings.txt

if [ -z "${id_chat}" ]; then
echo " "
echo " id chat Tidak diatur, Melewati kirim notifikasi !"
echo " "
else
echo " "
curl -X POST "https://api.telegram.org/bot${Token}/sendMessage" -d "chat_id=${id_chat}&text=Start Creat Environment For Building TWRP_${Device_Name}..."
echo " "
fi
}

bot_notif2() {
source ${current_directory}/save_settings.txt
if [ -z "${id_chat}" ]; then
echo " "
echo " id chat Tidak diatur, Melewati kirim notifikasi !"
echo " "
else
echo " "
curl -X POST "https://api.telegram.org/bot${Token}/sendMessage" -d "chat_id=${id_chat}&text= Start Building TWRP_${Device_Name}..."
echo " "
fi
}


bot_error() {
source ${current_directory}/save_settings.txt

if [ -z "${id_chat}" ]; then
echo " "
echo " id chat Tidak diatur, Melewati kirim notifikasi !"
echo " "
else
echo " "
curl -X POST "https://api.telegram.org/bot${Token}/sendMessage" -d "chat_id=${id_chat}&text= ERROR BUILD! COBA CEK YANG ERROR!"
echo " "
fi

}

bot_file() {
source ${current_directory}/save_settings.txt

if [ "${Build_Target}" = "vendorboot" ]; then
chmod a+x ${current_directory}/TWRP_${Device_Name}_vendor_boot.img.xz
if [ -z "${id_chat}" ]; then
echo " "
echo " id chat Tidak diatur, Melewati kirim notifikasi !"
echo " "
else
echo " "
curl -X POST "https://api.telegram.org/bot${Token}/sendMessage" -d "chat_id=${id_chat}&text= NEW BUILD TWRP_${Device_Name}!"
echo " "
curl -F document=@"${current_directory}/TWRP_${Device_Name}_vendor_boot.img.xz" https://api.telegram.org/bot${Token}/sendDocument?chat_id=${id_chat}
echo " "
fi
else
chmod a+x ${current_directory}/TWRP_${Device_Name}_${Build_Target}.img.xz
if [ -z "${id_chat}" ]; then
echo " "
echo " id chat Tidak diatur, Melewati kirim notifikasi !"
echo " "
else
echo " "
curl -X POST "https://api.telegram.org/bot${Token}/sendMessage" -d "chat_id=${id_chat}&text= NEW BUILD TWRP_${Device_Name}!"
echo " "
curl -F document=@"${current_directory}/TWRP_${Device_Name}_${Build_Target}.img.xz" https://api.telegram.org/bot${Token}/sendDocument?chat_id=${id_chat}
echo " "
fi
fi

}






# Fungsi Main


main() {

echo " "
echo "--------------Builder TWRP by Massatrio16 -----------"
echo "1. New Build for Aosp (sync minimal manifest)"
echo "2. Rebuild for Aosp (don't sync minimal manifest)"
echo "3. New Build for Omni (sync minimal manifest)"
echo "4. Rebuild for Omni (don't sync minimal manifest)"
echo "5. ADD NOTIFICATION TELEGRAM BOT (Adding Notification is recommended) "
echo "6. Delete All Resources Sync Manifest "
echo "7. Exit "
echo " "
echo "Pilih ( 1 - 7)"
read Main

# Mendeteksi Input pengguna
if [ "${Main}" = 1 ]; then ## Jika Pengguna Input 1 ##
Aosp
main
elif [ "${Main}" = 2 ]; then ## Jika Pengguna Input 2 ##
ReAosp
main
elif [ "${Main}" = 3 ]; then ## jika Pengguna Input 3 ##
Omni
main
elif [ "${Main}" = 4 ]; then ## Jika Pengguna input 4 ##
ReOmni
main
elif [ "${Main}" = 5 ]; then ## Jika pengguna input 5 ##
botconfig
elif [ "${Main}" = 6 ]; then ## Jika pengguna input 6 ##
deletesync
elif [ "${Main}" = 7 ]; then ## jika pengguna input 7 $#
exit 0
else ## Jika pengguna Memasukkan selain pilihan ##
echo " "
echo " Invalid Input !!!!"
echo " "
main
fi
}

###########################################################
###########################################################

# Fungsi Dari Build Aosp
Aosp()
{

 
source save_settings.txt

echo " "
echo " TWRP BUILD CONFIGURATION "
echo "  "
echo " : CATATAN : "
echo "[Wajib] = tidak boleh skip"
echo "Jika terjadi salah kamu bisa ulangi dengan skip(tekan enter) pada Konfigurasi berlabel wajib"
echo " "
# Membuat Folder twrp
 

 # Input Konfigurasi
 echo "Manifest AOSP Branch AVAILABLE : "
 echo " 11 "
 echo " 12.1 "
 echo "Pilih Manifest branch (11 , 12,1) [wajib] : "
read Manifest_branch
if [ -z "$Manifest_branch" ]; then
    echo "Input Manifest branch kosong!."
    echo " "
    main
fi
echo " "
echo " Link Device Tree TWRP [wajib] : "
read Device_tree
if [ -z "${Device_tree}" ]; then
    echo "Input Device tree Kosong !"
    echo " "
    main
    fi
echo " "
echo "Branch Device_tree_twrp [wajib]: "
read Branch_dt_twrp
if [ -z "${Branch_dt_twrp}" ]; then
    echo "Input branch device tree Kosong !"
    echo " "
    main
fi
echo " "
echo "Device Path [wajib]: "
read Device_Path
if [ -z "${Device_Path}" ]; then
    echo "Input Device path Kosong!"
    echo " "
    main
fi
echo " "
echo "Device Name [wajib]: "
read Device_Name
if [ -z "${Device_Name}" ]; then
    echo "Input Device Name Kosong!"
    echo " "
    main
fi
echo " "
echo " Run Lunch target Twrp (Isi nama setelah twrp_ (x657b untuk twrp_x657b)"
read Lunch
if [ -z "${Lunch}" ]; then
    echo "Input Lunch Kosong!"
    echo " "
    main
    
fi
echo " "
echo "Build Target ( recovery / boot / vendorboot ) [wajib]: "
read Build_Target
 if [ -z "${Build_Target}" ]; then
    echo "Input Build Target Kosong!"
    echo " "
    main
    
fi
echo " "
echo " Link_Device_Tree_Common "
read Common
echo " "
echo " Device_Path_Common "
read Path_Common
if [ -n "${Common}" ] && [ -z "${Path_Common}" ]; then
echo " "
echo " Device tree common Terisi!, Tetapi Path Common Kosong"
main
fi

# menyimpan konfigurasi

echo " "
echo "Konfigurasi Tersimpan"
echo " "
sed -i "s|Device_tree=.*|Device_tree=$Device_tree|" ${current_directory}/save_settings.txt
 
sed -i "s|Branch_dt_twrp=.*|Branch_dt_twrp=$Branch_dt_twrp|" ${current_directory}/save_settings.txt


sed -i "s|Device_Path=.*|Device_Path=$Device_Path|" ${current_directory}/save_settings.txt

sed -i "s|Device_Name=.*|Device_Name=$Device_Name|" ${current_directory}/save_settings.txt

sed -i "s|Build_Target=.*|Build_Target=$Build_Target|" ${current_directory}/save_settings.txt
sed -i "s|Lunch=.*|Lunch=$Lunch|" ${current_directory}/save_settings.txt

if [ -n "${Common}" ] && [ -n "${Path_Common}" ]; then
sed -i "s|Common=.*|Common=$Common|" ${current_directory}/save_settings.txt
sed -i "s|Path_Common=.*|Path_Common=$Path_Common|" ${current_directory}/save_settings.txt
fi


cd /.workspace
 mkdir twrp
 cd twrp
 
# Menginstall Package yang diperlikan
cd ${current_directory}
bot_notif
cd /.workspace/twrp
echo " "
echo "  Build Environment "
echo " "

   


   # Sync Minimal Manifest
   
        git config --global user.name "Nico170420"
        git config --global user.email "b170420nc@gmail.com"
        
        repo init --depth=1 -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-${Manifest_branch}
        
        repo sync --force-sync



        # Cloning Device tree
        echo " "
        echo " Cloning Device Tree "
        echo " "
        
        
        git clone ${Device_tree} -b ${Branch_dt_twrp} ${Device_Path}
        
        

        if [ -n "${Common}" ] && [ -n "${Path_Common}" ]; then
       git clone ${Common} -b ${Branch_dt_twrp} ${Path_Common}
      
fi
        echo " "

        # Start Building 
        cd ${current_directory}
        bot_notif2
        cd /.workspace/twrp
        clear
        echo " Building Recovery "
        echo " "
        
        sleep 1
         export ALLOW_MISSING_DEPENDENCIES=true; . build/envsetup.sh; cd /.workspace/twrp/${Device_Path}; lunch twrp_${Lunch}-eng; mka ${Build_Target}image

        # Menyalin Hasil Build Ke direktori saat ini 
        
       if [ "${Build_Target}" = "vendorboot" ]; then
         if [ -e "/.workspace/twrp/out/target/product/${Lunch}/vendor_boot.img" ]; then
       
         cp -r /.workspace/twrp/out/target/product/${Lunch}/vendor_boot.img ${current_directory}
         
         else
         echo " "
         echo " FILE HASIL BUILD TIDAK DITEMUKAN SEPERTINYA ADA MASALAH"
         echo " "
         bot_error
         main
         fi
         
         
         
         else
         
         if [ -e "/.workspace/twrp/out/target/product/${Lunch}/${Build_Target}.img" ]; then
         cp -r /.workspace/twrp/out/target/product/${Lunch}/${Build_Target}.img ${current_directory}   
         
           else
           echo " "
           echo "FILE HASIL BUILD TIDAK DITEMUKAN SEPERTINYA ADA MASALAH  "
           echo " "
           bot_error
            main
            fi   
        fi
        echo " DONE BUILD!!! "
cd ${current_directory}
if [ "${Build_Target}" = "vendorboot" ]; then
mv vendor_boot.img TWRP_${Device_Name}_vendor_boot.img
echo " "
echo " Mengkompress File menjadi lebih kecil..."
xz TWRP_${Device_Name}_vendor_boot.img
echo " "
else
echo " "
echo " Mengkompress File menjadi lebih kecil..."
mv ${Build_Target}.img TWRP_${Device_Name}_${Build_Target}.img
xz TWRP_${Device_Name}_${Build_Target}.img
echo " "
fi

bot_file
main #kembali ke menu
}

###########################################################
###########################################################

#Fungsi Rebuild 

ReAosp()
{



if [ -d "/.workspace/twrp" ]; then


# Permintaan Pilihan ke Pengguna
echo "Memanggil Konfigurasi yang Tersimpan"
source save_settings.txt
echo "Ingin ubah konfigurasi tersimpan?"
echo "1. Ya"
echo "2. Tidak"
echo "Pilih (1-2): "
read settings

# Mendeteksi Pilihan dari Perubahan konfigurasi


if [ "${settings}" = 1 ]; then  # Jika Pilihan 1 dijalan kan #
  
  # Membuat Masukkan Ulang Konfigurasi
    

echo " "
echo " Link Device Tree TWRP [wajib] : "
read Device_tree
if [ -z "${Device_tree}" ]; then
    echo "Input Device tree Kosong !"
    echo " "
    main
    fi
echo " "
echo "Branch Device_tree_twrp [wajib]: "
read Branch_dt_twrp
if [ -z "${Branch_dt_twrp}" ]; then
    echo "Input branch device tree Kosong !"
    echo " "
    main
fi
echo " "
echo "Device Path [wajib]: "
read Device_Path
if [ -z "${Device_Path}" ]; then
    echo "Input Device path Kosong!"
    echo " "
    main
fi
echo " "
echo "Device Name [wajib]: "
read Device_Name
if [ -z "${Device_Name}" ]; then
    echo "Input Device Name Kosong!"
    echo " "
    main
fi
echo " "
echo " Run Lunch target Twrp (Isi nama setelah twrp_ (x657b untuk twrp_x657b)"
read Lunch
if [ -z "${Lunch}" ]; then
    echo "Input Lunch Kosong!"
    echo " "
    main
    
fi



echo " "
echo "Build Target ( recovery / boot / vendorboot ) [wajib]: "
read Build_Target
 if [ -z "${Build_Target}" ]; then
    echo "Input Build Target Kosong!"
    echo " "
    main
    
fi
echo " "
echo " Username_Github/Nama_Repo_DT_commom "
read Common
echo " "
echo " Device_Path_Common "
read Path_Common
if [ -n "${Common}" ] && [ -z "${Path_Common}" ]; then
echo " "
echo " Device tree common Terisi!, Tetapi Path Common Kosong"
main
fi

 sed -i "s|Device_tree=.*|Device_tree=$Device_tree|" ${current_directory}/save_settings.txt
 
sed -i "s|Branch_dt_twrp=.*|Branch_dt_twrp=$Branch_dt_twrp|" ${current_directory}/save_settings.txt


sed -i "s|Device_Path=.*|Device_Path=$Device_Path|" ${current_directory}/save_settings.txt

sed -i "s|Device_Name=.*|Device_Name=$Device_Name|" ${current_directory}/save_settings.txt

sed -i "s|Build_Target=.*|Build_Target=$Build_Target|" ${current_directory}/save_settings.txt

sed -i "s|Lunch=.*|Lunch=$Lunch|" ${current_directory}/save_settings.txt

if [ -n "${Common}" ] && [ -n "${Path_Common}" ]; then
sed -i "s|Common=.*|Common=$Common|" ${current_directory}/save_settings.txt
sed -i "s|Path_Common=.*|Path_Common=$Path_Common|" ${current_directory}/save_settings.txt
fi

 
    echo " Diperbarui!"
sleep 1



    
    # Menghapus Cloning device tree yang telah ada sebelumnya
   if  [ -e "${current_directory}/TWRP_${Device_Name}_vendor_boot.img.xz" ]; then
    rm -rf ${current_directory}/TWRP_${Device_Name}_vendor_boot.img.xz
fi
if [ -e "${current_directory}/TWRP_${Device_Name}_${Build_Target}.img.xz" ]; then
rm -rf ${current_directory}/TWRP_${Device_Name}_${Build_Target}.img.xz
fi
    if [ -e "/.workspace/twrp/${Path_Common}" ]; then
rm -rf /.workspace/twrp/${Path_Common}
fi
    rm -rf /.workspace/twrp/${Device_Path}
   rm -rf /.workspace/twrp/out/target/product/${Lunch}
# Memanggil Konfigurasi Yang tersimpan
    source ${current_directory}/save_settings.txt
    
# Cloning Device tree

cd /.workspace/twrp
echo " "
echo " Cloning Device tree "
echo " "

# Clone device tree
git clone ${Device_tree} -b ${Branch_dt_twrp} ${Device_Path}
        if [ -n "${Common}" ] && [ -n "${Path_Common}" ]; then
       git clone ${Common} -b ${Branch_dt_twrp} ${Path_Common}
      
fi
        sleep 1
        cd ${current_directory}
        bot_notif2
        cd /.workspace/twrp
        clear
        echo " "
        echo " BUILDING TWRP "
        echo " "
        # Start Building 
        
         export ALLOW_MISSING_DEPENDENCIES=true; . build/envsetup.sh; cd /.workspace/twrp/${Device_Path}; lunch twrp_${Lunch}-eng; mka ${Build_Target}image

        # Menyalin hasil ke direktori saat ini
        
          
       if [ "${Build_Target}" = "vendorboot" ]; then
         if [ -e "/.workspace/twrp/out/target/product/${Lunch}/vendor_boot.img" ]; then
       
         cp -r /.workspace/twrp/out/target/product/${Lunch}/vendor_boot.img ${current_directory}
         
         else
         echo " "
         echo " FILE HASIL BUILD TIDAK DITEMUKAN SEPERTINYA ADA MASALAH "
         echo " "
         bot_error
         main
         fi
         
         
         
         else
         
         if [ -e "/.workspace/twrp/out/target/product/${Lunch}/${Build_Target}.img" ]; then
         cp -r /.workspace/twrp/out/target/product/${Lunch}/${Build_Target}.img ${current_directory}   
         
           else
           echo " "
           echo "FILE HASIL BUILD TIDAK DITEMUKAN SEPERTINYA ADA MASALAHD "
           echo " "
           bot_error
            main
            fi   
        fi
        echo " DONE BUILD ! "
        echo " "
cd ${current_directory}
if [ "${Build_Target}" = "vendorboot" ]; then
mv vendor_boot.img TWRP_${Device_Name}_vendor_boot.img
echo " "
echo " Mengkompress file menjadi lebih kecil... "
xz TWRP_${Device_Name}_vendor_boot.img
echo " "
else
mv ${Build_Target}.img TWRP_${Device_Name}_${Build_Target}.img
echo " "
echo " Mengkompress file menjadi lebih kecil..."
xz TWRP_${Device_Name}_${Build_Target}.img
echo " "
    fi
    bot_file
    ## Akhir dari Pilihan 1 ##
    
main
elif [ "${settings}" = 2 ]; then ## Awal Dari Pilihan 2 ##

# Memanggil konfigurasi yang tersimpan

    source ${current_directory}/save_settings.txt
if  [ -e "${current_directory}/TWRP_${Device_Name}_vendor_boot.img.xz" ]; then
    rm -rf ${current_directory}/TWRP_${Device_Name}_vendor_boot.img.xz
fi
if [ -e "${current_directory}/TWRP_${Device_Name}_${Build_Target}.img.xz" ]; then
rm -rf ${current_directory}/TWRP_${Device_Name}_${Build_Target}.img.xz
fi

if [ -e "/.workspace/twrp/${Path_Common}" ]; then
rm -rf /.workspace/twrp/${Path_Common}
fi
    # Menghapus sumber daya yang telah dibuat 
    rm -rf /.workspace/twrp/${Device_Path}
    rm -rf /.workspace/twrp/out/target/product/${Lunch}

# Cloning Device tree

cd /.workspace/twrp
echo " "
echo " Cloning Device tree "
echo " "

git clone ${Device_tree} -b ${Branch_dt_twrp} ${Device_Path}

if [ -n "${Common}" ] && [ -n "${Path_Common}" ]; then
       git clone ${Common} -b ${Branch_dt_twrp} ${Path_Common}
      
fi


        
        sleep 1
        cd ${current_directory}
bot_notif2
cd /.workspace/twrp
clear
echo " "
        echo " BUILDING TWRP "
        echo " "
        # start building
         export ALLOW_MISSING_DEPENDENCIES=true; . build/envsetup.sh; cd /.workspace/twrp/${Device_Path}; lunch twrp_${Lunch}-eng; mka ${Build_Target}image

        # Menyalin Hasil build ke direktori saat ini
        
       
       if [ "${Build_Target}" = "vendorboot" ]; then
         if [ -e "/.workspace/twrp/out/target/product/${Lunch}/vendor_boot.img" ]; then
       
         cp -r /.workspace/twrp/out/target/product/${Lunch}/vendor_boot.img ${current_directory}
         
         else
         echo " "
         echo " FILE HASIL BUILD TIDAK DITEMUKAN SEPERTINYA ADA MASALAH "
         echo " "
         bot_error
         main
         fi
         
         
         
         else
         
         if [ -e "/.workspace/twrp/out/target/product/${Lunch}/${Build_Target}.img" ]; then
         cp -r /.workspace/twrp/out/target/product/${Lunch}/${Build_Target}.img ${current_directory}   
         
           else
           echo " "
           echo "FILE HASIL BUILD TIDAK DITEMUKAN SEPERTINYA ADA MASALAH "
           echo " "
           bot_error
            main
            fi   
        fi
        echo " Done ! "
        echo " "
cd ${current_directory}
if [ "${Build_Target}" = "vendorboot" ]; then
mv vendor_boot.img TWRP_${Device_Name}_vendor_boot.img
echo " "
echo "Mengkompress file menjadi lebih kecil..."
xz TWRP_${Device_Name}_vendor_boot.img
echo " "
else
mv ${Build_Target}.img TWRP_${Device_Name}_${Build_Target}.img
echo " "
echo "Mengkompress file menjadi lebih kecil..."
xz TWRP_${Device_Name}_${Build_Target}.img
echo " "
fi
bot_file
    ## Akhir Dari pilihan 2 ##


main  #Kembali Ke menu



else ## Jika Pengguna Memasukkan Tidak sesuai dengan pilihan ##
echo " "
echo "Invalid Input!"
echo " "
main
fi
else
echo " "
echo "TIDAK DAPAT MENEMUKAN FILE SYNC MANIFEST! APAKAH KAMU SUDAH SYNC MANIFEST?"
main
fi

}


###########################################################
###########################################################
#Fungsi Omni
Omni()
{
 
source save_settings.txt

 echo " "
 echo " BUILD CONFIGURATION TWRP "
 echo " "
 
 
 echo "Manifest Omni branch AVAILABLE : "
 echo "5.1 "
 echo "6.0 "
 echo "7.1 "
 echo "8.1 "
 echo "9.0 "
 echo "Pilih Manifest branch : "
read Manifest_branch
if [ -z "$Manifest_branch" ]; then
    echo "Input Manifest branch kosong!."
    echo " "
    main
fi
echo "Link Device tree twrp : "
read Device_tree
if [ -z "${Device_tree}" ]; then
    echo "Input Device tree Kosong !"
    echo " "
    main
fi
echo "Branch Device_tree_twrp : "
read Branch_dt_twrp
if [ -z "${Branch_dt_twrp}" ]; then
    echo "Input branch device tree Kosong !"
    echo " "
    main
fi
echo "Device Path : "
read Device_Path
if [ -z "${Device_Path}" ]; then
    echo "Input Device path Kosong!"
    echo " "
    main
fi
echo "Device Name : "
read Device_Name
if [ -z "${Device_Name}" ]; then
    echo "Input Device Name Kosong!"
    echo " "
    main
fi
echo "Build Target (recovery,boot) : "
read Build_Target
 if [ -z "${Build_Target}" ]; then
    echo "Input Build Target Kosong!"
    echo " "
    main
fi

sed -i "s|Device_tree=.*|Device_tree=$Device_tree|" ${current_directory}/save_settings.txt
 
sed -i "s|Branch_dt_twrp=.*|Branch_dt_twrp=$Branch_dt_twrp|" ${current_directory}/save_settings.txt


sed -i "s|Device_Path=.*|Device_Path=$Device_Path|" ${current_directory}/save_settings.txt

sed -i "s|Device_Name=.*|Device_Name=$Device_Name|" ${current_directory}/save_settings.txt

sed -i "s|Build_Target=.*|Build_Target=$Build_Target|" ${current_directory}/save_settings.txt
cd /.workspace
 mkdir twrp
 cd twrp

cd ${current_directory}
 bot_notif
 cd /.workspace/twrp
echo " "
echo " Build Environment... "
echo " "

  
   
   
        git config --global user.name "Nico170420"
        git config --global user.email "b170420nc@gmail.com"
        
        repo init --depth=1 -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git -b twrp-${Manifest_branch}
        
        repo sync --force-sync
        echo " "

        echo " Cloning Device Tree "
        echo " "
        git clone ${Device_tree} -b ${Branch_dt_twrp} ${Device_Path}
        
        sleep 1
        cd ${current_directory}
        bot_notif2
        cd /.workspace/twrp
        clear
        echo " "
        echo " Building recovery..."
        echo " "
         export ALLOW_MISSING_DEPENDENCIES=true; . build/envsetup.sh; cd /.workspace/twrp/${Device_Path}; lunch omni_${Device_Name}-eng; mka ${Build_Target}image
       
     
     
     if [ -e "/.workspace/twrp/out/target/product/${Device_Name}/${Build_Target}.img" ]; then
         cp -r /.workspace/twrp/out/target/product/${Device_Name}/${Build_Target}.img ${current_directory}     
        else
        echo "FILE HASIL BUILD TIDAK DITEMUKAN SEPERTINYA ADA MASALAH"
        bot_error
        main
        fi
        
        echo " DONE BUILD !"
     echo " "
cd ${current_directory}
mv ${Build_Target}.img TWRP_${Device_Name}_${Build_Target}.img
echo " "
echo " Mengkompress file menjadi lebih kecil "

xz TWRP_${Device_Name}_${Build_Target}.img
echo " "
bot_file
main
}

###########################################################
###########################################################

# Fungsi Reomni
ReOmni()
{
if [ -d "/.workspace/twrp" ]; then

source save_settings.txt

echo "Memanggil Konfigurasi yang Tersimpan"

echo "Ingin ubah konfigurasi tersimpan?"
echo "1. Ya"
echo "2. Tidak"
echo "Pilih (1-2): "
read settings

if [ "${settings}" = 1 ]; then
    echo "Link Device tree twrp : "
read Device_tree
if [ -z "${Device_tree}" ]; then
    echo "Input Device tree Kosong !"
    echo " "
    main
fi
echo "Branch Device_tree_twrp : "
read Branch_dt_twrp
if [ -z "${Branch_dt_twrp}" ]; then
    echo "Input branch device tree Kosong !"
    echo " "
    main
fi
echo "Device Path : "
read Device_Path
if [ -z "${Device_Path}" ]; then
    echo "Input Device path Kosong!"
    echo " "
    main
fi
echo "Device Name : "
read Device_Name
if [ -z "$Device_Name}" ]; then
    echo "Input Device Name Kosong!"
    echo " "
    main
fi
echo "Build Target (recovery,boot,vendorboot) : "
read Build_Target
 if [ -z "${Build_Target}" ]; then
    echo "Input Build Target Kosong!"
    echo " "
    main
fi

    sed -i "s|Device_tree=.*|Device_tree=$Device_tree|" ${current_directory}/save_settings.txt
 
sed -i "s|Branch_dt_twrp=.*|Branch_dt_twrp=$Branch_dt_twrp|" ${current_directory}/save_settings.txt


sed -i "s|Device_Path=.*|Device_Path=$Device_Path|" ${current_directory}/save_settings.txt

sed -i "s|Device_Name=.*|Device_Name=$Device_Name|" ${current_directory}/save_settings.txt

sed -i "s|Build_Target=.*|Build_Target=$Build_Target|" ${current_directory}/save_settings.txt


echo " Diperbarui!"
sleep 1

    
if  [ -e "${current_directory}/TWRP_${Device_Name}_vendor_boot.img.xz" ]; then
    rm -rf ${current_directory}/TWRP_${Device_Name}_vendor_boot.img.xz
fi
if [ -e "${current_directory}/TWRP_${Device_Name}_${Build_Target}.img.xz" ]; then
rm -rf ${current_directory}/TWRP_${Device_Name}_${Build_Target}.img.xz
fi 
    rm -rf /.workspace/twrp/${Device_Path}
    rm -rf /.workspace/twrp/out/target/product/${Device_Name}

source ${current_directory}/save_settings.txt
cd /.workspace/twrp
echo " "
echo "Cloning Device Tree "
echo " "
git clone ${Device_tree} -b ${Branch_dt_twrp} ${Device_Path}
cd ${current_directory}
bot_notif2
cd /.workspace/twrp
clear
echo " "
echo " Building recovery "
echo " "
sleep 1

        
         export ALLOW_MISSING_DEPENDENCIES=true; . build/envsetup.sh; cd /.workspace/twrp/${Device_Path}; lunch omni_${Device_Name}-eng; mka ${Build_Target}image
        
   
         if [ -e "/.workspace/twrp/out/target/product/${Device_Name}/${Build_Target}.img" ]; then
         cp -r /.workspace/twrp/out/target/product/${Device_Name}/${Build_Target}.img ${current_directory}     
        else
        echo "FILE HASIL BUILD TIDAK DITEMUKAN SEPERTINYA ADA MASALAH"
        bot_error
        main
        fi    
echo " DONE BUILD !"
   echo " "
        cd ${current_directory}
mv ${Build_Target}.img TWRP_${Device_Name}_${Build_Target}.img

echo " Mengkompress file menjadi lebih kecil "
xz TWRP_${Device_Name}_${Build_Target}.img
echo " "
bot_file
main


#end of 1

elif [ "${settings}" = 2 ]; then #Start of 2
    source ${current_directory}/save_settings.txt
    if  [ -e "${current_directory}/TWRP_${Device_Name}_vendor_boot.img.xz" ]; then
    rm -rf ${current_directory}/TWRP_${Device_Name}_vendor_boot.img.xz
fi
if [ -e "${current_directory}/TWRP_${Device_Name}_${Build_Target}.img.xz" ]; then
rm -rf ${current_directory}/TWRP_${Device_Name}_${Build_Target}.img.xz
fi
    rm -rf /.workspace/twrp/${Device_Path}
    rm -rf /.workspace/twrp/out/target/product/${Device_Name}


cd /.workspace/twrp
echo " "
echo "Cloning Device Tree "
echo " "
git clone ${Device_tree} -b ${Branch_dt_twrp} ${Device_Path}

cd ${current_directory}
bot_notif2
cd /.workspace/twrp
clear
echo " "
sleep 1
echo " "
echo " Building recovery "
echo " "
        
         export ALLOW_MISSING_DEPENDENCIES=true; . build/envsetup.sh; cd /.workspace/twrp/${Device_Path}; lunch omni_${Device_Name}-eng; mka ${Build_Target}image
        
   
         if [ -e "/.workspace/twrp/out/target/product/${Device_Name}/${Build_Target}.img" ]; then
         cp -r /.workspace/twrp/out/target/product/${Device_Name}/${Build_Target}.img ${current_directory}     
        else
        echo "FILE HASIL BUILD TIDAK DITEMUKAN SEPERTINYA ADA MASALAH"
        bot_error
        main
        fi  
echo " DONE BUILD ! "
   echo " "
        cd ${current_directory}
mv ${Build_Target}.img TWRP_${Device_Name}_${Build_Target}.img
echo "Mengkompress file menjadi lebih kecil"
xz TWRP_${Device_Name}_${Build_Target}.img
echo " "
bot_file
main
#end of 2
else #else of Reomni
echo " "
    echo "Input tidak valid. Perintah dibatalkan."
    echo " "
    main
fi
else
echo " "
echo "TIDAK DAPAN MENEMUKAN FILE SYNC MANIFEST! APAKAH KAMU SUDAH SYNC MANIFEST?"
main
fi

}

###########################################################
###########################################################

botconfig() {
sorce save_settings.txt

echo " ---- Telegram Bot Configuration ---- "
echo " "
echo "Token Bot Telah diatur default sebagai bot owner script"
echo "tetapi chat id belum diatur, ngin mengaturnya?"
echo "1. Atur Ulang Token"
echo "2. Atur Ulang Chat id"
echo " Pilih ( 1-2 ) : "
read setcon

if [ "${setcon}" = 1 ]; then
echo " "
echo "Ketik Token Anda"
read Token
if [ -z "${Token}" ]; then
echo " "
echo " Token kosong ! "
main
else
sed -i "s|Token=.*|Token=$Token|" ${current_directory}/save_settings.txt
echo " "
echo "Token Telah disimpan!"
main
fi
elif [ "${setcon}" = 2 ]; then
echo " "
echo "Ketik Chat Id anda"
read id_chat
if [ -z "${id_chat}" ]; then
echo " "
echo " Id chat kosong ! "
main
else
sed -i "s|id_chat=.*|id_chat=$id_chat|" ${current_directory}/save_settings.txt
echo " "
echo " Id chat disimpan!"
main
fi
else
echo " Invalid Input ! "
main
fi



}

deletesync() {
echo " "
echo " Yakin Menghapus sync manifest? "
echo "Kamu harus melakukan sync manifest ulang jika ingin Rebuild/Reomni!"
echo "1. Ya"
echo "2. Tidak"
echo "pilih (1-2) :"
read del
if [ "${del}" = 1 ]; then
echo " "

if [ -d "/.workspace/twrp" ]; then
echo "Menghapus sync manifest..."
rm -rf /.workspace/twrp
echo "Done!"
main
else
echo "File sync Tidak ada! apakah kamu sudah melakukan sync Manifest?"
main
fi
elif [ "${del}" = 2 ]; then
main
else
echo " "
echo " Invalid input "
main
fi

}




###########################################################
###########################################################

# Menjalankan Fungsi Main 

clear
echo " "
echo " Menyimpan Folder saat ini... "
current_directory=$(pwd)
sed -i "s|current_directory=.*|current_directory=$current_directory|" save_settings.txt
echo " --- Memeriksa Package ---"
echo " "
if ! dpkg -l python3 gperf gcc-multilib gcc-10-multilib g++-multilib g++-10-multilib libc6-dev lib32ncurses5-dev x11proto-core-dev libx11-dev tree lib32z-dev libgl1-mesa-dev libxml2-utils xsltproc bc ccache lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libwxgtk3.0-gtk3-dev libxml2 lzop pngcrush schedtool squashfs-tools imagemagick libbz2-dev lzma repo rsync ncftp qemu-user-static libstdc++-10-dev libtinfo5 &>/dev/null; then
    # Jika paket belum terinstal, jalankan perintah instalasi
    echo " Beberapa Package belum terinstall! "
    sleep 1
    apt update
    apt -y upgrade
    apt -y install gperf python3 gcc-multilib gcc-10-multilib g++-multilib g++-10-multilib libc6-dev lib32ncurses5-dev x11proto-core-dev libx11-dev tree lib32z-dev libgl1-mesa-dev libxml2-utils xsltproc bc ccache lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libwxgtk3.0-gtk3-dev libxml2 lzop pngcrush schedtool squashfs-tools imagemagick libbz2-dev lzma repo rsync ncftp qemu-user-static libstdc++-10-dev libtinfo5
fi
clear
main
exit 0

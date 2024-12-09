


# Fungsi Main

main() {

echo " "
echo "--------------Builder TWRP by Massatrio16 -----------"
echo "1. New Build for Aosp (sync minimal manifest)"
echo "2. Rebuild for Aosp ( No need sync minimal manifest)"
echo "3. New Build for Omni (sync minimal manifest)"
echo "4. Rebuild for Omni ( No need sync minimal manifest)"
echo "5. New Build For Ofox (Sync Minimal Manifest) "
echo "6. Rebuild for ofox ( No need sync Minimal Manifest)"
echo "7. Setting Notification Telegram & Upload File (Recommended)"
echo "8. Delete All Resources Sync Manifest "
echo "9. Exit "
echo " "
read -p "Pilih ( 1 - 9) : " Main

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
Ofox
main
elif [ "${Main}" = 6 ]; then ## Jika pengguna input 6 ##
reofox
main
elif [ "${Main}" = 7 ]; then ## Jika pengguna input 7 ##
botconfig
elif [ "${Main}" = 8 ]; then ## Jika pengguna input 8 ##
deletesync
elif [ "${Main}" = 9 ]; then ## jika pengguna input 9 $#
exit 0
else ## Jika pengguna Memasukkan selain pilihan ##
echo " "
echo " input tidak valid !!!!"
echo " "
main
fi
}


###########################################################
###########################################################
##############################################################
##############################################################



Aosp() {

 
source ${current_directory}/save_settings.txt
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
 echo " 14 "
 echo "Pilih Manifest branch (11 , 12,1, 14) [wajib] : "
read Manifest_branch
if [ -z "$Manifest_branch" ]; then
    echo "Input Manifest branch kosong!."
    echo " "
    main
fi
if [ "${Manifest_branch}" != "11" ] && [ "${Manifest_branch}" != "12.1" ] && ["${Manifest_branch}" != "14" ]; then
   echo ""
   echo "sepertinya Minimal Manifest yang dimasukkan tidak tersedia!"
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
echo "Lunch target Twrp (twrp_xxxx) change xxxx with your file in device tree example : intput X657B for twrp_X657B"
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
 if [ "${Build_Target}" != "recovery" ] && [ "${Build_Target}" != "boot" ] && [ "${Build_Target}" != "vendorboot" ]; then
   echo ""
   echo "Sepertinya  Build Target tidak cocok, yang kamu ketik saat ini adalah ${Build_Target}"
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

if [ -z "${Common}" ] && [ -n "${Path_Common}" ]; then
echo " "
echo " Patch common Terisi, Tetapi Device tree common kosong "
main
fi

echo " "
echo " Mendeteksk Out Target File... "
Out=$(basename "$Device_Path")
sed -i "s|Out=.*|Out=$Out|" ${current_directory}/save_settings.txt
sleep 1




# MENYIMPAN KONFIGURASI KE FILE save_settings.txt

echo " "
echo "Menyimpan Konfigurasi..."
echo " "
sed -i "s|Build_Status=.*|Build_Status=TWRP|" ${current_directory}/save_settings.txt
sed -i "s|Manifest_branch=.*|Manifest_branch=$Manifest_branch|" ${current_directory}/save_settings.txt
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






echo " "
echo " Tersimpan! "



# MEMBUAT FOLDER WORKSPACE BUILD TWRP DI GITPOD ( anda bisa ubah direktori ini sesuka hati anda dimana tempat nya )

mkdir ${di_build}
cd ${di_build}
 
 
 # Mulai untuk melakukan sync
 
cd ${current_directory}
bot_notif
cd ${di_build}
echo " "
echo "  Build Environment "
echo " "

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
        
        
        
        # Build dimulai
        
        echo " "
        cd ${current_directory}
        bot_notif2
        cd ${di_build}
        clear
        echo " Building Recovery "
        echo " "
        sleep 1
        
         export ALLOW_MISSING_DEPENDENCIES=true; . build/envsetup.sh; cd ${di_build}/${Device_Path}; lunch twrp_${Lunch}-eng; mka ${Build_Target}image -j8

        
        
        
        
        # Pemeriksaan Hasil Build
         if [ "${Build_Target}" = "vendorboot" ]; then
         if [ -e "${di_build}/out/target/product/${Out}/vendor_boot.img" ]; then  
         cp -r ${di_build}/out/target/product/${Out}/vendor_boot.img ${current_directory}
         
         elif [ -e "${di_build}/out/target/product/${Device_Name}/vendor_boot.img" ]; then     
        cp ${di_build}/out/target/product/${Device_Name}/vendor_boot.img ${current_directory}
        
        elif [ -e "${di_build}/out/target/product/${Lunch}/vendor_boot.img" ]; then
        cp ${di_build}/out/target/product/${Lunch}/vendor_boot.img ${current_directory}
         else
         echo " "
         echo " FILE HASIL BUILD TIDAK DITEMUKAN SEPERTINYA ADA MASALAH"
         echo " "
         bot_error
         main
         fi
           
         else
         
         
         if [ -e "${di_build}/out/target/product/${Out}/${Build_Target}.img" ]; then
         cp -r ${di_build}/out/target/product/${Out}/${Build_Target}.img ${current_directory}
         
         elif [ -e "${di_build}/out/target/product/${Device_Name}/${Build_Target}.img" ]; then
        cp ${di_build}/out/target/product/${Device_Name}/${Build_Target}.img ${current_directory}
        
        elif [ -e "${di_build}/out/target/product/${Lunch}/${Build_Target}.img" ]; then
        cp ${di_build}/out/target/product/${Lunch}/${Build_Target}.img ${current_directory}
        
           else
           echo " "
           echo "FILE HASIL BUILD TIDAK DITEMUKAN SEPERTINYA ADA MASALAH  "
           echo " "
           bot_error
            main
            fi   
        fi
        
        
        
        # Memindahkan hasil build dari root dir ke workspace gitpod
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

if [ -n "${id_chat}" ] && [ -n "${id_topic}" ]; then
bot_file_topic
else
bot_file
fi

upload
main #kembali ke menu
}

##############################################################
##############################################################
##############################################################
##############################################################


#Fungsi Rebuild 

ReAosp()
{


# memeriksa workspace

source ${current_directory}/save_settings.txt
if [ -n ${Manifest_branch} ] || [ "${Build_Status}" = "TWRP" ]; then
sed -i "s|Build_Status=.*|Build_Status=TWRP|" ${current_directory}/save_settings.txt

# Permintaan Pilihan ke Pengguna
echo "Memanggil Konfigurasi yang Tersimpan"
source ${current_directory}/save_settings.txt
echo "Ingin ubah konfigurasi tersimpan?"
echo "1. Ya"
echo "2. Tidak"
read -p "Pilih (1-2): " settings


# Mendeteksi Pilihan dari Perubahan konfigurasi

if [ "${settings}" = 1 ]; then  # Jika Pilihan 1 dijalan kan #
  


#+++++++++++++++++++++++++ AWAL REAOSP PILIHAN 1 ++++++++++++++++++++#



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
 if [ "${Build_Target}" != "recovery" ] && [ "${Build_Target}" != "boot" ] && [ "${Build_Target}" != "vendorboot" ]; then
   echo ""
   echo "Sepertinya  Build Target tidak cocok, yang kamu ketik saat ini adalah ${Build_Target}"
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

if [ -z "${Common}" ] && [ -n "${Path_Common}" ]; then
echo " "
echo " Patch common Terisi, Tetapi Device tree common kosong "
main
fi




echo " "
echo " Mendeteksk Out Target File... "
Out=$(basename "$Device_Path")
sed -i "s|Out=.*|Out=$Out|" ${current_directory}/save_settings.txt
sleep 1





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


echo "Memeriksa ketersediaan Manifest..."
sleep 1

    
    # Menghapus Cloning device tree yang telah ada sebelumnya
    if [ -d "${di_build}" ]; then
    echo " "
    echo "Manifest tersedia Menghapus beberapa file..."
   if  [ -e "${current_directory}/TWRP_${Device_Name}_vendor_boot.img.xz" ]; then
    rm -rf ${current_directory}/TWRP_${Device_Name}_vendor_boot.img.xz
fi
if [ -e "${current_directory}/TWRP_${Device_Name}_${Build_Target}.img.xz" ]; then
rm -rf ${current_directory}/TWRP_${Device_Name}_${Build_Target}.img.xz
fi

if [ -n "${Path_Common}" ]; then   
rm -rf ${di_build}/${Path_Common}
fi
    rm -rf ${di_build}/${Device_Path}
   rm -rf ${di_build}/out/target/product/${Out}

   else
   echo " "
   echo " Sepertinya Manifest tidak ada Mengulangi sync manifest..."
   
   mkdir ${di_build}
   cd ${di_build}
   repo init --depth=1 -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-${Manifest_branch}
        
  repo sync --force-sync
  fi



# Memanggil Konfigurasi Yang tersimpan
    source ${current_directory}/save_settings.txt

cd ${di_build}
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
        cd ${di_build}
        clear
        
        # BUILD DIMULAI
        echo " "
        echo " BUILDING TWRP "
        echo " "
        # Start Building 
        
         export ALLOW_MISSING_DEPENDENCIES=true; . build/envsetup.sh; cd ${di_build}/${Device_Path}; lunch twrp_${Lunch}-eng; mka ${Build_Target}image -j8

       
       
       
       
       
       
       
        # MEMERIKSA FILE LALU MENYALIN FILE KE WORKSPACE 
          
         if [ "${Build_Target}" = "vendorboot" ]; then
            if [ -e "${di_build}/out/target/product/${Out}/vendor_boot.img" ]; then
              cp -r ${di_build}/out/target/product/${Out}/vendor_boot.img ${current_directory}
        elif [ -e "${di_build}/out/target/product/${Device_Name}/vendor_boot.img" ]; then  
           cp ${di_build}/out/target/product/${Device_Name}/vendor_boot.img ${current_directory}
        elif [ -e "${di_build}/out/target/product/${Lunch}/vendor_boot.img" ]; then
           cp ${di_build}/out/target/product/${Lunch}/vendor_boot.img ${current_directory}
              
       else
         echo " "
         echo " FILE HASIL BUILD TIDAK DITEMUKAN SEPERTINYA ADA MASALAH"
         echo " "
         bot_error
         main
         fi
                         
       else
         
         
         if [ -e "${di_build}/out/target/product/${Out}/${Build_Target}.img" ]; then
         cp -r ${di_build}/out/target/product/${Out}/${Build_Target}.img ${current_directory}   
         elif [ -e "${di_build}/out/target/product/${Device_Name}/${Build_Target}.img" ]; then
         
        cp ${di_build}/out/target/product/${Device_Name}/${Build_Target}.img ${current_directory}
        elif [ -e "${di_build}/out/target/product/${Lunch}/${Build_Target}.img" ]; then
        cp ${di_build}/out/target/product/${Lunch}/${Build_Target}.img ${current_directory}
           else
           echo " "
           echo "FILE HASIL BUILD TIDAK DITEMUKAN SEPERTINYA ADA MASALAH  "
           echo " "
           bot_error
            main
            fi   
        fi
        
        
        
        
        
        
        # MENGUBAH NAMA FILE DAN MENGKOMPRESS FILE
        
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
    
if [ -n "${id_chat}" ] && [ -n "${id_topic}" ]; then
bot_file_topic
else
bot_file
fi


    upload
   
   #---------------------------------------------------- AKHIR AOSP PILIHAN 1 ------------------------------------------#
    
main
elif [ "${settings}" = 2 ]; then 

   #+++++++++++++++++++++++++++++++++ AWAL AOSP PILIHAN 2 +++++++++++++++++++++++++#



# Memanggil konfigurasi yang tersimpan

    source ${current_directory}/save_settings.txt

    
echo "Memeriksa ketersediaan Manifest..."
sleep 1

    
    # Menghapus Cloning device tree yang telah ada sebelumnya
    if [ -d "${di_build}" ]; then
    echo " "
    echo "Manifest tersedia Menghapus beberapa file..."
   if  [ -e "${current_directory}/TWRP_${Device_Name}_vendor_boot.img.xz" ]; then
    rm -rf ${current_directory}/TWRP_${Device_Name}_vendor_boot.img.xz
fi
if [ -e "${current_directory}/TWRP_${Device_Name}_${Build_Target}.img.xz" ]; then
rm -rf ${current_directory}/TWRP_${Device_Name}_${Build_Target}.img.xz
fi

if [ -n "${Path_Common}" ]; then   
rm -rf ${di_build}/${Path_Common}
fi
    rm -rf ${di_build}/${Device_Path}
   rm -rf ${di_build}/out/target/product/${Out}

   else
   echo " "
   echo " Sepertinya Manifest tidak ada Mengulangi sync manifest..."
   
   mkdir ${di_build}
   cd ${di_build}
   repo init --depth=1 -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-${Manifest_branch}
        
  repo sync --force-sync
  fi

# Cloning Device tree

cd ${di_build}
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
cd ${di_build}
clear
echo " "
        echo " BUILDING TWRP "
        echo " "
        # start building
         export ALLOW_MISSING_DEPENDENCIES=true; . build/envsetup.sh; cd ${di_build}/${Device_Path}; lunch twrp_${Lunch}-eng; mka ${Build_Target}image -j8





        # Menyalin Hasil build ke direktori saat ini
        
       
              if [ "${Build_Target}" = "vendorboot" ]; then
         if [ -e "${di_build}/out/target/product/${Out}/vendor_boot.img" ]; then
       
         cp -r ${di_build}/out/target/product/${Out}/vendor_boot.img ${current_directory}
         elif [ -e "${di_build}/out/target/product/${Device_Name}/vendor_boot.img" ]; then
         
        cp ${di_build}/out/target/product/${Device_Name}/vendor_boot.img ${current_directory}
        elif [ -e "${di_build}/out/target/product/${Lunch}/vendor_boot.img" ]; then
        cp ${di_build}/out/target/product/${Lunch}/vendor_boot.img ${current_directory}
        
          
         else
         echo " "
         echo " FILE HASIL BUILD TIDAK DITEMUKAN SEPERTINYA ADA MASALAH"
         echo " "
         bot_error
         main
         fi
         
         
         
         else
         
         if [ -e "${di_build}/out/target/product/${Out}/${Build_Target}.img" ]; then
         cp -r ${di_build}/out/target/product/${Out}/${Build_Target}.img ${current_directory}   
         elif [ -e "${di_build}/out/target/product/${Device_Name}/${Build_Target}.img" ]; then
         
        cp ${di_build}/out/target/product/${Device_Name}/${Build_Target}.img ${current_directory}
        elif [ -e "${di_build}/out/target/product/${Lunch}/${Build_Target}.img" ]; then
        cp ${di_build}/out/target/product/${Lunch}/${Build_Target}.img ${current_directory}
           else
           echo " "
           echo "FILE HASIL BUILD TIDAK DITEMUKAN SEPERTINYA ADA MASALAH  "
           echo " "
           bot_error
            main
            fi   
        fi
        echo " Done Build! "
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

if [ -n "${id_chat}" ] && [ -n "${id_topic}" ]; then
bot_file_topic
else
bot_file
fi

upload


    #-------------------------_--------_------------- AKHIR AOSP PILIHAN 2 ---------------------------_-------------------#


main  #Kembali Ke menu



else 

# kondisi jika Tidak memilih selain 2 pilihan tersebut 

echo " "
echo "Invalid Input!"
echo " "
main
fi

else
echo " "
echo " KAMU BELUM PERNAH MELAKUKAN SYNC TWRP SEBELUMNYA! "
echo " "
main
fi


}


##############################################################
##############################################################
##############################################################
##############################################################



#Fungsi Omni
Omni()
{
 
source ${current_directory}/save_settings.txt

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
if [ "${Manifest_branch}" != "5.1" ] && [ "${Manifest_branch}" != "6.0" ] && [ "${Manifest_branch}" != "7.1" ] && [ "${Manifest_branch}" != "8.1" ] && [ "${Manifest_branch}" != "9.0" ]; then
   echo ""
   echo "sepertinya Minimal Manifest yang dimasukkan tidak tersedia!"
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
if [ "${Build_Target}" != "recovery" ] && [ "${Build_Target}" != "boot" ]; then
   echo ""
   echo "Sepertinya  Build Target tidak cocok, yang kamu ketik saat ini adalah ${Build_Target}"
   echo " "
   main
   fi
sed -i "s|Manifest_branch=.*|Manifest_branch=$Manifest_branch|" ${current_directory}/save_settings.txt

sed -i "s|Device_tree=.*|Device_tree=$Device_tree|" ${current_directory}/save_settings.txt
 
sed -i "s|Branch_dt_twrp=.*|Branch_dt_twrp=$Branch_dt_twrp|" ${current_directory}/save_settings.txt


sed -i "s|Device_Path=.*|Device_Path=$Device_Path|" ${current_directory}/save_settings.txt

sed -i "s|Device_Name=.*|Device_Name=$Device_Name|" ${current_directory}/save_settings.txt

sed -i "s|Build_Target=.*|Build_Target=$Build_Target|" ${current_directory}/save_settings.txt

 mkdir ${di_build}
 cd ${di_build}

cd ${current_directory}
 bot_notif
 cd ${di_build}
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


        bash ${current_directory}/scripts/convert.sh ${Device_Path}/omni.dependencies

        
        sleep 1
        cd ${current_directory}
        bot_notif2
        cd ${di_build}
        clear
        echo " "
        echo " Building recovery..."
        echo " "
         export ALLOW_MISSING_DEPENDENCIES=true
         JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
         PATH=$JAVA_HOME/bin:$PATH
         source build/envsetup.sh
         cd ${di_build}
         lunch omni_${Device_Name}-eng
         make clean
         make ${Build_Target}image
       
     
     
     if [ -e "${di_build}/out/target/product/${Device_Name}/${Build_Target}.img" ]; then
         cp -r ${di_build}/out/target/product/${Device_Name}/${Build_Target}.img ${current_directory}     
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

##############################################################
##############################################################
##############################################################
##############################################################

# Fungsi Reomni
ReOmni()
{


source ${current_directory}/save_settings.txt

echo "Memanggil Konfigurasi yang Tersimpan"
if [ -n ${Manifest_branch} ]; then
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

    echo " "
    echo "Memeriksa Ketersediaan Manifest..."
    sleep 1
    if [ -d "${di_build}" ]; then
    echo " "
    echo " Manifest Tersedia menghapus beberapa file..."
if  [ -e "${current_directory}/TWRP_${Device_Name}_vendor_boot.img.xz" ]; then
    rm -rf ${current_directory}/TWRP_${Device_Name}_vendor_boot.img.xz
fi
if [ -e "${current_directory}/TWRP_${Device_Name}_${Build_Target}.img.xz" ]; then
rm -rf ${current_directory}/TWRP_${Device_Name}_${Build_Target}.img.xz
fi 
    rm -rf ${di_build}/${Device_Path}
    rm -rf ${di_build}/out/target/product/${Device_Name}
else

mkdir ${di_build}
cd ${di_build}
echo "Manifest Tidak Tersedia Mengulangi sync Manifest.."
echo " "
repo init --depth=1 -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git -b twrp-${Manifest_branch}
repo sync --force-sync
fi


source ${current_directory}/save_settings.txt
cd ${di_build}
echo " "
echo "Cloning Device Tree "
echo " "
git clone ${Device_tree} -b ${Branch_dt_twrp} ${Device_Path}
cd ${current_directory}
bot_notif2
cd ${di_build}
clear
echo " "
echo " Building recovery "
echo " "
sleep 1

        
         export ALLOW_MISSING_DEPENDENCIES=true
         JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
         PATH=$JAVA_HOME/bin:$PATH
         source build/envsetup.sh
         cd ${di_build}
         lunch omni_${Device_Name}-eng
         make clean
         make ${Build_Target}image
   
         if [ -e "${di_build}/out/target/product/${Device_Name}/${Build_Target}.img" ]; then
         cp -r ${di_build}/out/target/product/${Device_Name}/${Build_Target}.img ${current_directory}     
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
    echo " "
    echo "Memeriksa Ketersediaan Manifest..."
    sleep 1
    if [ -d "${di_build}" ]; then
    echo " "
    echo " Manifest Tersedia menghapus beberapa file..."
if  [ -e "${current_directory}/TWRP_${Device_Name}_vendor_boot.img.xz" ]; then
    rm -rf ${current_directory}/TWRP_${Device_Name}_vendor_boot.img.xz
fi
if [ -e "${current_directory}/TWRP_${Device_Name}_${Build_Target}.img.xz" ]; then
rm -rf ${current_directory}/TWRP_${Device_Name}_${Build_Target}.img.xz
fi 
    rm -rf ${di_build}/${Device_Path}
    rm -rf ${di_build}/out/target/product/${Device_Name}
else

mkdir ${di_build}
cd ${di_build}
echo "Manifest Tidak Tersedia Mengulangi sync Manifest.."
echo " "
repo init --depth=1 -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git -b twrp-${Manifest_branch}
repo sync --force-sync
fi

cd ${di_build}
echo " "
echo "Cloning Device Tree "
echo " "
git clone ${Device_tree} -b ${Branch_dt_twrp} ${Device_Path}

cd ${current_directory}
bot_notif2
cd ${di_build}
clear
echo " "
sleep 1
echo " "
echo " Building recovery "
echo " "
        
         export ALLOW_MISSING_DEPENDENCIES=true
         JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
         PATH=$JAVA_HOME/bin:$PATH
         source build/envsetup.sh
         cd ${di_build}
         lunch omni_${Device_Name}-eng
         make clean
         make ${Build_Target}image
   
         if [ -e "${di_build}/out/target/product/${Device_Name}/${Build_Target}.img" ]; then
         cp -r ${di_build}/out/target/product/${Device_Name}/${Build_Target}.img ${current_directory}     
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
echo " KAMU BELUM PERNAH MELAKUKAN SYNC! "
echo " "
main
fi

}



##############################################################
##############################################################
##############################################################
##############################################################



Ofox() {
source ${current_directory}/save_settings.txt
echo " "
echo " OFOX BUILD CONFIGURATION "
echo "  "
echo " : CATATAN : "
echo "[Wajib] = tidak boleh skip"
echo "Jika terjadi salah kamu bisa ulangi dengan skip(tekan enter) pada Konfigurasi berlabel wajib"
echo " "
# Membuat Folder twrp
 

 # Input Konfigurasi
 echo "Manifest AOSP Branch AVAILABLE : "
 echo " 11.0 "
 echo " 12.1 "
 echo "Pilih Manifest branch (11.0 , 12,1) [wajib] : "
read Manifest_branch
if [ -z "$Manifest_branch" ]; then
    echo "Input Manifest branch kosong!."
    echo " "
    main
fi
if [ "${Manifest_branch}" != "11.0" ] && [ "${Manifest_branch}" != "12.1" ]; then
   echo ""
   echo "sepertinya Minimal Manifest yang dimasukkan tidak tersedia!"
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
if [ "${Build_Target}" != "recovery" ] && [ "${Build_Target}" != "boot" ] && [ "${Build_Target}" != "vendorboot" ]; then
   echo ""
   echo "Sepertinya  Build Target tidak cocok, yang kamu ketik saat ini adalah ${Build_Target}"
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
sed -i "s|Build_Status=.*|Build_Status=OrangeFox|" ${current_directory}/save_settings.txt
sed -i "s|Manifest_branch=.*|Manifest_branch=$Manifest_branch|" ${current_directory}/save_settings.txt
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





mkdir ${di_build}
cd ${di_build}
 mkdir ofox
 cd ${di_build}/ofox
 
# Menginstall Package yang diperlikan
cd ${current_directory}
bot_notif
cd ${di_build}/ofox
echo " "
echo "  Build Environment "
echo " "

   


   # Sync Minimal Manifest
   
        git config --global user.name "Nico170420"
        git config --global user.email "b170420nc@gmail.com"
        
        git clone https://gitlab.com/OrangeFox/misc/scripts.git
        cd scripts
        sudo bash setup/android_build_env.sh
        cd ${di_build}/ofox
        
                
        
        
        
        git clone https://gitlab.com/OrangeFox/sync.git
        cd sync
        ./orangefox_sync.sh --branch ${Manifest_branch}
        
cd ${di_build}/ofox/sync/fox_${Manifest_branch}

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
        cd ${di_build}/ofox/sync/fox_${Manifest_branch}
        clear
        echo " Building Recovery "
        echo " "
        
        sleep 1
        
        
        
        
        
        
         export ALLOW_MISSING_DEPENDENCIES=true; source build/envsetup.sh; cd ${di_build}/ofox/sync/fox_${Manifest_branch}/${Device_Path}; lunch twrp_${Lunch}-eng; mka ${Build_Target}image -j8

        # Menyalin Hasil Build Ke direktori saat ini 
        
       
         
         
         if [ -e "${di_build}/ofox/sync/fox_${Manifest_branch}/out/target/product/${Out}/OrangeFox-Unofficial-${Out}.img" ]; then
         cp -r ${di_build}/ofox/sync/fox_${Manifest_branch}/out/target/product/${Out}/OrangeFox-Unofficial-${Out}.img ${current_directory}
            cp -r ${di_build}/ofox/sync/fox_${Manifest_branch}/out/target/product/${Out}/OrangeFox-Unofficial-${Out}.zip ${current_directory}
            
         elif [ -e "${di_build}/ofox/sync/fox_${Manifest_branch}/out/target/product/${Device_Name}/OrangeFox-Unofficial-${Device_Name}.img" ]; then
         
        cp ${di_build}/ofox/sync/fox_${Manifest_branch}/out/target/product/${Device_Name}/OrangeFox-Unofficial-${Device_Name}.img ${current_directory}
        cp ${di_build}/ofox/sync/fox_${Manifest_branch}/out/target/product/${Device_Name}/OrangeFox-Unofficial-${Device_Name}.zip ${current_directory}
        
        elif [ -e "${di_build}/ofox/sync/fox_${Manifest_branch}/out/target/product/${Lunch}/OrangeFox-Unofficial-${Lunch}.img" ]; then
        cp ${di_build}/ofox/sync/fox_${Manifest_branch}/out/target/product/${Lunch}/OrangeFox-Unofficial-${Lunch}.img ${current_directory}
        cp ${di_build}/ofox/sync/fox_${Manifest_branch}/out/target/product/${Lunch}/OrangeFox-Unofficial-${Lunch}.zip ${current_directory}
           else
           echo " "
           echo "FILE HASIL BUILD TIDAK DITEMUKAN SEPERTINYA ADA MASALAH  "
           echo " "
           bot_error
            main
            fi   
        echo " "
        echo " DONE BUILD!!! "
cd ${current_directory}
echo " "
echo " Kompresi File menjadi lebih kecil ..."
xz OrangeFox*.img
mv OrangeFox*.xz OrangeFox-Unofficial_${Device_Name}.img.xz
mv OrangeFox*.zip OrangeFox_Installer_${Device_Name}.zip
echo " "

bot_offox
pix_ofox
main


}






##############################################################
##############################################################
##############################################################
##############################################################




reofox() {

source ${current_directory}/save_settings.txt
if [ -n "${Branch_manifest}" ] || [ "${Build_Status}" = "OrangeFox" ]; then
sed -i "s|Build_Status=.*|Build_Status=OrangeFox|" ${current_directory}/save_settings.txt
fi
# Permintaan Pilihan ke Pengguna
echo "Memanggil Konfigurasi yang Tersimpan"
source ${current_directory}/save_settings.txt
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

echo " "
echo " Memeriksa Ketersediaan Manifest"
sleep 1
    source
    # Menghapus Cloning device tree yang telah ada sebelumnya
    if [ -d ${di_build}/ofox ]; then
    echo " "
    echo " Manifest Tersedia. Menghapus beberapa file... "
    sleep 1
   if  [ -e "${current_directory}/OrangeFox-Unofficial_${Device_Name}.img.xz" ]; then
    rm -rf ${current_directory}/OrangeFox*.xz
    rm -rf ${current_directory}/OrangeFox*.zip
fi


    if [ -n "${Path_Common}" ]; then
rm -rf ${di_build}/ofox/sync/fox_${Manifest_branch}/${Path_Common}
fi
    rm -rf ${di_build}/ofox/sync/fox_${Manifest_branch}/${Device_Path}
   rm -rf ${di_build}/ofox/sync/fox_${Manifest_branch}/out/target/product/${Lunch}
   rm -rf ${di_build}/ofox/sync/fox_${Manifest_branch}/out/target/product/${Out}
   rm -rf ${di_build}/ofox/sync/fox_${Manifest_branch}/out/target/product/${Device_Name}
   else
   echo " "
   echo " Manifest Tidak Tersedia! Melakukan sync..."
   mkdir ${di_build}
   cd ${di_build}
   mkdir ofox
   cd ${di_build}/ofox
   git clone https://gitlab.com/OrangeFox/misc/scripts.git
        cd scripts
        sudo bash setup/android_build_env.sh
        cd ${di_build}/ofox
        
                
        
        
        
        git clone https://gitlab.com/OrangeFox/sync.git
        cd sync
        ./orangefox_sync.sh --branch ${Manifest_branch}
        
cd ${di_build}/ofox/sync/fox_${Manifest_branch}
   fi
   
   
# Memanggil Konfigurasi Yang tersimpan
    source ${current_directory}/save_settings.txt
    
# Cloning Device tree

cd ${di_build}/ofox/sync/fox_${Manifest_branch}
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
        cd ${di_build}/ofox/sync/fox_${Manifest_branch}
        clear
        echo " "
        echo " BUILDING TWRP "
        echo " "
        # Start Building 
        
         export ALLOW_MISSING_DEPENDENCIES=true; source build/envsetup.sh; cd ${di_build}/ofox/sync/fox_${Manifest_branch}/${Device_Path}; lunch twrp_${Lunch}-eng; mka ${Build_Target}image -j16

        # Menyalin hasil ke direktori saat ini
        
          
       if [ -e "${di_build}/ofox/sync/fox_${Manifest_branch}/out/target/product/${Out}/OrangeFox-Unofficial-${Out}.img" ]; then
         cp -r ${di_build}/ofox/sync/fox_${Manifest_branch}/out/target/product/${Out}/OrangeFox-Unofficial-${Out}.img ${current_directory}
            cp -r ${di_build}/ofox/sync/fox_${Manifest_branch}/out/target/product/${Out}/OrangeFox-Unofficial-${Out}.zip ${current_directory}
            
         elif [ -e "${di_build}/ofox/sync/fox_${Manifest_branch}/out/target/product/${Device_Name}/OrangeFox-Unofficial-${Device_Name}.img" ]; then
         
        cp ${di_build}/ofox/sync/fox_${Manifest_branch}/out/target/product/${Device_Name}/OrangeFox-Unofficial-${Device_Name}.img ${current_directory}
        cp ${di_build}/ofox/sync/fox_${Manifest_branch}/out/target/product/${Device_Name}/OrangeFox-Unofficial-${Device_Name}.zip ${current_directory}
        
        elif [ -e "${di_build}/ofox/sync/fox_${Manifest_branch}/out/target/product/${Lunch}/OrangeFox-Unofficial-${Lunch}.img" ]; then
        cp ${di_build}/ofox/sync/fox_${Manifest_branch}/out/target/product/${Lunch}/OrangeFox-Unofficial-${Lunch}.img ${current_directory}
        cp ${di_build}/ofox/sync/fox_${Manifest_branch}/out/target/product/${Lunch}/OrangeFox-Unofficial-${Lunch}.zip ${current_directory}
           else
           echo " "
           echo "FILE HASIL BUILD TIDAK DITEMUKAN SEPERTINYA ADA MASALAH  "
           echo " "
           bot_error
            main
            fi   
echo " "
        echo " DONE BUILD!!! "
cd ${current_directory}
echo " "
echo " Kompresi File menjadi lebih kecil ..."
xz OrangeFox*.img
mv OrangeFox*.xz OrangeFox-Unofficial_${Device_Name}.img.xz
mv OrangeFox*.zip OrangeFox_Installer_${Device_Name}.zip
echo " "

bot_offox
pix_ofox
main

######### END OF 1  ########


elif [ "${settings}" = 2 ]; then ## Awal Dari Pilihan 2 ##

# Memanggil konfigurasi yang tersimpan
echo " "
echo " Memeriksa Ketersediaan Manifest"
sleep 1
    
    # Menghapus Cloning device tree yang telah ada sebelumnya
    if [ -d ${di_build}/ofox ]; then
    echo " "
    echo " Manifest Tersedia. Menghapus beberapa file... "
    sleep 1
   if  [ -e "${current_directory}/OrangeFox-Unofficial_${Device_Name}.img.xz" ]; then
    rm -rf ${current_directory}/OrangeFox*.xz
    rm -rf ${current_directory}/OrangeFox*.zip
fi


    if [ -n "${Path_Common}" ]; then
rm -rf ${di_build}/ofox/sync/fox_${Manifest_branch}/${Path_Common}
fi
    rm -rf ${di_build}/ofox/sync/fox_${Manifest_branch}/${Device_Path}
   rm -rf ${di_build}/ofox/sync/fox_${Manifest_branch}/out/target/product/${Lunch}
   rm -rf ${di_build}/ofox/sync/fox_${Manifest_branch}/out/target/product/${Out}
   rm -rf ${di_build}/ofox/sync/fox_${Manifest_branch}/out/target/product/${Device_Name}
   else
   echo " "
   echo " Manifest Tidak Tersedia! Melakukan sync..."
   mkdir ${di_build}
   cd ${di_build}
   mkdir ofox
   cd ${di_build}ofox
   git clone https://gitlab.com/OrangeFox/misc/scripts.git
        cd scripts
        sudo bash setup/android_build_env.sh
        cd ${di_build}/ofox
        
                
        
        
        
        git clone https://gitlab.com/OrangeFox/sync.git
        cd sync
        ./orangefox_sync.sh --branch ${Manifest_branch}
        
cd ${di_build}/ofox/sync/fox_${Manifest_branch}
   fi
   
   
# Memanggil Konfigurasi Yang tersimpan
    source ${current_directory}/save_settings.txt
    
# Cloning Device tree

cd ${di_build}/ofox/sync/fox_${Manifest_branch}
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
        cd ${di_build}/ofox/sync/fox_${Manifest_branch}
        clear
        echo " "
        echo " BUILDING TWRP "
        echo " "
        # Start Building 
        
         export ALLOW_MISSING_DEPENDENCIES=true; source build/envsetup.sh; cd ${di_build}/ofox/sync/fox_${Manifest_branch}/${Device_Path}; lunch twrp_${Lunch}-eng; mka ${Build_Target}image -j16

        # Menyalin hasil ke direktori saat ini
        
          
       if [ -e "${di_build}/ofox/sync/fox_${Manifest_branch}/out/target/product/${Out}/OrangeFox-Unofficial-${Out}.img" ]; then
         cp -r ${di_build}/ofox/sync/fox_${Manifest_branch}/out/target/product/${Out}/OrangeFox-Unofficial-${Out}.img ${current_directory}
            cp -r ${di_build}/ofox/sync/fox_${Manifest_branch}/out/target/product/${Out}/OrangeFox-Unofficial-${Out}.zip ${current_directory}
            
         elif [ -e "${di_build}/ofox/sync/fox_${Manifest_branch}/out/target/product/${Device_Name}/OrangeFox-Unofficial-${Device_Name}.img" ]; then
         
        cp ${di_build}/ofox/sync/fox_${Manifest_branch}/out/target/product/${Device_Name}/OrangeFox-Unofficial-${Device_Name}.img ${current_directory}
        cp ${di_build}/ofox/sync/fox_${Manifest_branch}/out/target/product/${Device_Name}/OrangeFox-Unofficial-${Device_Name}.zip ${current_directory}
        
        elif [ -e "${di_build}/ofox/sync/fox_${Manifest_branch}/out/target/product/${Lunch}/OrangeFox-Unofficial-${Lunch}.img" ]; then
        cp ${di_build}/ofox/sync/fox_${Manifest_branch}/out/target/product/${Lunch}/OrangeFox-Unofficial-${Lunch}.img ${current_directory}
        cp ${di_build}/ofox/sync/fox_${Manifest_branch}/out/target/product/${Lunch}/OrangeFox-Unofficial-${Lunch}.zip ${current_directory}
           else
           echo " "
           echo "FILE HASIL BUILD TIDAK DITEMUKAN SEPERTINYA ADA MASALAH  "
           echo " "
           bot_error
            main
            fi   
echo " "
        echo " DONE BUILD!!! "
cd ${current_directory}
echo " "
echo " Kompresi File menjadi lebih kecil ..."
xz OrangeFox*.img
mv OrangeFox*.xz OrangeFox-Unofficial_${Device_Name}.img.xz
mv OrangeFox*.zip OrangeFox_Installer_${Device_Name}.zip
echo " "

bot_offox
pix_ofox
main


####### END OF 2 ###########


else ## Jika Pengguna Memasukkan Tidak sesuai dengan pilihan ##
echo " "
echo "Invalid Input!"
echo " "
main
fi


}







##############################################################
##############################################################
##############################################################
##############################################################






botconfig() {
source ${current_directory}/save_settings.txt

echo " ---- Notification / Upload Configuration ---- "
echo " "
echo "Token Bot Telegram Telah diatur default sebagai bot owner script"
echo "Chat id dan Apikey Pixeldrain blum di Atur!"
echo "1. Atur Ulang Token"
echo "2. Atur Chat id "
echo "3. Atur Apikey "
read -p " Pilih ( 1-3 ) : " setcon

if [ "${setcon}" = 1 ]; then
echo " "
read -p "Ketik Token Anda : " Token
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
read -p "Ketik Chat Id anda : " id_chat
read -p "ketik topik id anda (jika pesan bot ditujukan ke grup topik) : " id_topic
if [ -z "${id_chat}" ]; then
echo " "
echo " Id chat kosong ! "
main
elif [ -n "${id_topic}" ]; then
sed -i "s|id_chat=.*|id_chat=$id_chat|" ${current_directory}/save_settings.txt
sed -i "s|id_topic=.*|id_topic=$id_topic|" ${current_directory}/save_settings.txt
echo " "
echo " Id chat dan id topic disimpan!"
main
else
sed -i "s|id_chat=.*|id_chat=$id_chat|" ${current_directory}/save_settings.txt
echo " "
echo " Hanya id chat disimpan!"
main
fi
elif [ "${setcon}" = 3 ]; then
echo " "
read -p " Ketik Apikey anda : " api
if [ -z "${api}" ]; then
echo " "
echo " Apikey kosong ! "
main
else
sed -i "s|api=.*|api=$api|" ${current_directory}/save_settings.txt
echo " "
echo " Apikey disimpan! "
main
fi
else
echo " Invalid Input ! "
main
fi



}

###########################################################
###########################################################


deletesync() {
source ${current_directory}/save_settings.txt
echo " "
echo " Yakin Menghapus sync manifest? "
echo "Kamu harus melakukan sync manifest ulang jika ingin Rebuild/Reomni!"
echo "1. Ya"
echo "2. Tidak"
read -p "pilih (1-2) : " del
if [ "${del}" = 1 ]; then
echo " "


if [ -d "${di_build}" ]; then
echo "Menghapus Sync Manifest..."
rm -rf ${di_build}
rm -rf ${current_directory}/*.xz
echo "Done!"
main
elif [ -d "${di_build}/ofox" ]; then
echo " "
echo " Menghaous Sync Manifest..."
rm -rf ${di_build}/ofox
rm -rf ${current_directory}/*.xz
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

bot_offox() {

source ${current_directory}/save_settings.txt


if [ -z "${id_chat}" ]; then
echo " "
echo "id chat belum diatur, Melewati kirim Notifikasi"
echo " "
elif [ -n "${id_topic}" ]; then
curl -F "chat_id=${id_chat}" \
  -F "message_thread_id=${id_topic}" \
  -F "document=@${current_directory}/OrangeFox-Unofficial_${Device_Name}.img.xz" \
 https://api.telegram.org/bot${Token}/sendDocument
curl -F "chat_id=${id_chat}" \
  -F "message_thread_id=${id_topic}" \
  -F "document=@${current_directory}/OrangeFox_Installer_${Device_Name}.zip" \
 https://api.telegram.org/bot${Token}/sendDocument


else
echo " "
curl -F document=@"${current_directory}/OrangeFox-Unofficial_${Device_Name}.img.xz" https://api.telegram.org/bot${Token}/sendDocument?chat_id=${id_chat}
curl -F document=@"${current_directory}/OrangeFox_Installer_${Device_Name}.zip" https://api.telegram.org/bot${Token}/sendDocument?chat_id=${id_chat}
echo " "
fi


}

###########################################################
###########################################################


pix_ofox() {
 
source ${current_directory}/save_settings.txt

if [ -z "${api}" ]; then
echo " "
echo " ApiKey tidak diatur File tidak akan diUpload! "
echo " "
else
echo " "
echo " Mengupload ke Pixeldrain... "
echo " "
chmod a+x ${current_directory}/OrangeFox-Unofficial.img.xz
curl -T "${current_directory}/OrangeFox-Unofficial.img.xz" -u:${api} https://pixeldrain.com/api/file/
fi

}



###########################################################
###########################################################



upload() {

source ${current_directory}/save_settings.txt
if [ -z "${api}" ]; then
echo " "
echo " Kamu Tidak mengatur Api Key pixeldrain, Skip Upload! "
echo " "
else
echo " "
echo " Mengupload Ke Pixeldrain "
echo " "
if [ "${Build_Target}" = "vendorboot" ]; then
chmod a+x ${current_directory}/TWRP_${Device_Name}_vendor_boot.img.xz
curl -T "${current_directory}/TWRP_${Device_Name}_vendor_boot.img.xz" -u:${api} https://pixeldrain.com/api/file/
else
echo " "
chmod a+x ${current_directory}/TWRP_${Device_Name}_${Build_Target}.img.xz
curl -T "${current_directory}/TWRP_${Device_Name}_${Build_Target}.img.xz" -u:${api} https://pixeldrain.com/api/file/
fi
fi

}

###########################################################
###########################################################


bot_notif() {

source ${current_directory}/save_settings.txt

if [ -z "${id_chat}" ]; then
echo " "
echo " id chat Tidak diatur, Melewati kirim notifikasi !"
echo " "
elif [ -n "${id_chat}" ] && [ -n "${id_topic}" ]; then
curl -F "chat_id=${id_chat}" \
  -F "message_thread_id=${id_topic}" \
  -F "text=Start Creat Environment For Building ${Build_Status}_${Device_Name}" \
 https://api.telegram.org/bot${Token}/sendMessage
else
echo " "
echo " "
curl -X POST "https://api.telegram.org/bot${Token}/sendMessage" -d "chat_id=${id_chat}&text=Start Creat Environment For Building ${Build_Status}_${Device_Name}..."
echo " "
fi

}

###########################################################
###########################################################

bot_notif2() {
source ${current_directory}/save_settings.txt
if [ -z "${id_chat}" ]; then
echo " "
echo " id chat Tidak diatur, Melewati kirim notifikasi !"
echo " "
elif [ -n "${id_chat}" ] && [ -n "${id_topic}" ]; then
curl -F "chat_id=${id_chat}" \
  -F "message_thread_id=${id_topic}" \
  -F "text=Starting Building ${Build_Status}_${Device_Name}" \
 https://api.telegram.org/bot${Token}/sendMessage
else

echo " "
curl -X POST "https://api.telegram.org/bot${Token}/sendMessage" -d "chat_id=${id_chat}&text= Starting Building ${Build_Status}_${Device_Name}..."
echo " "
fi

}

###########################################################
###########################################################

bot_error() {
source ${current_directory}/save_settings.txt

if [ -z "${id_chat}" ]; then
echo " "
echo " id chat Tidak diatur, Melewati kirim notifikasi !"
echo " "
elif [ -n "${id_chat}" ] && [ -n "${id_topic}" ]; then
curl -F "chat_id=${id_chat}" \
  -F "message_thread_id=${id_topic}" \
  -F "text=ERROR BUILDING ${Build_Status}_${Device_Name} PLEASE CHECK ERROR ON TERMINAL!" \
 https://api.telegram.org/bot${Token}/sendMessage
else

echo " "
curl -X POST "https://api.telegram.org/bot${Token}/sendMessage" -d "chat_id=${id_chat}&text= ERROR BUILDING ${Build_Status}_${Device_Name} PLEASE CHECK ERROR !"
echo " "
fi

}

###########################################################
###########################################################

bot_file() {
source ${current_directory}/save_settings.txt

if [ -z "${id_chat}" ]; then
echo " "
echo " id chat tidak diatur, Melewati kirim Notifikasi ! "
echo " "
else
if [ "${Build_Target}" = "vendorboot" ]; then
chmod a+x ${current_directory}/TWRP_${Device_Name}_vendor_boot.img.xz
curl -X POST "https://api.telegram.org/bot${Token}/sendMessage" -d "chat_id=${id_chat}&text= BUILD SUCCESSFULLY SENDING FILE ${Build_Status}_${Device_Name}!"
echo " "
curl -F document=@"${current_directory}/TWRP_${Device_Name}_vendor_boot.img.xz" https://api.telegram.org/bot${Token}/sendDocument?chat_id=${id_chat}
echo " "
else
chmod a+x ${current_directory}/TWRP_${Device_Name}_${Build_Target}.img.xz
echo " "
curl -X POST "https://api.telegram.org/bot${Token}/sendMessage" -d "chat_id=${id_chat}&text= BUILD SUCCESSFULLY SENDING FILE ${Build_Status}_${Device_Name}!"
echo " "
curl -F document=@"${current_directory}/TWRP_${Device_Name}_${Build_Target}.img.xz" https://api.telegram.org/bot${Token}/sendDocument?chat_id=${id_chat}
echo " "
fi
fi

}

##############################################################
##############################################################



bot_file_topic() {
source ${current_directory}/save_settings.txt


if [ "${Build_Target}" = "vendorboot" ]; then
chmod a+x ${current_directory}/TWRP_${Device_Name}_vendor_boot.img.xz
curl -F "chat_id=${id_chat}" \
  -F "message_thread_id=${id_topic}" \
  -F "text=NEW BUILD ${Build_Status} ${Device_Name}" \
 https://api.telegram.org/bot${Token}/sendMessage
  echo " "
curl -F "chat_id=${id_chat}" \
  -F "message_thread_id=${id_topic}" \
  -F "document=@${current_directory}/TWRP_${Device_Name}_vendor_boot.img.xz" \
 https://api.telegram.org/bot${Token}/sendDocument

echo " "
else
chmod a+x ${current_directory}/TWRP_${Device_Name}_${Build_Target}.img.xz
echo " "
curl -F "chat_id=${id_chat}" \
  -F "message_thread_id=${id_topic}" \
  -F "text=NEW BUILD ${Build_Status} ${Device_Name}" \
 https://api.telegram.org/bot${Token}/sendMessage
echo " "
curl -F "chat_id=${id_chat}" \
  -F "message_thread_id=${id_topic}" \
  -F "document=@${current_directory}/TWRP_${Device_Name}_${Build_Target}.img.xz" \
 https://api.telegram.org/bot${Token}/sendDocument
echo " "
fi

}




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
    echo " "
    echo "Memulai Instalasi..."
    echo " "
    sleep 1
    sudo apt -y update
    sudo apt -y upgrade
 sudo apt -y install python2 gperf gcc-multilib gcc-10-multilib g++-multilib g++-10-multilib libc6-dev lib32ncurses5-dev x11proto-core-dev libx11-dev tree lib32z-dev libgl1-mesa-dev libxml2-utils xsltproc bc ccache lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libwxgtk3.0-gtk3-dev libxml2 lzop pngcrush schedtool squashfs-tools imagemagick libbz2-dev lzma ncftp qemu-user-static libstdc++-10-dev libncurses5 python3
   sudo apt -y install rsync
  sudo apt -y install repo
 # sudo apt-get install openjdk-8-jre -y
#  sudo apt-get install openjdk-8-jdk -y
 # JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
#export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
#export PATH=$JAVA_HOME/bin:$PATH
#source /etc/profile
cd /usr/bin
sudo ln -sf python2 python
# mkdir /usr/include/asm
#cp -r /usr/include/asm-generic/errno.h /usr/include/asm/
sleep 3
  fi
clear
cd ${current_directory}
git config --global user.name "Nico170420"
git config --global user.email "b170420nc@gmail.com"
main
exit 0

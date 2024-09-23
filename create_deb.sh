#!/bin/sh
osarch=$(dpkg --print-architecture)
cmode="light"
if [ $# -gt 0 ]; then
    if [ "$1" = "dark" ]; then
        cmode="dark"
    fi
fi
echo "---------------------------------------------------------------------------------------------------"
echo ">>     running configure"
echo
echo
./configure
echo "---------------------------------------------------------------------------------------------------"
echo ">>     cleaning folders"
echo
echo
make clean
rm -f PACKAGE/opt/trinity/lib/trinity/actioncenter_applet_panelapplet.la
rm -f PACKAGE/opt/trinity/lib/trinity/actioncenter_applet_panelapplet.so
rm -f PACKAGE/usr/lib/actioncenter/actioncenter_assets.tar.gz
echo "---------------------------------------------------------------------------------------------------"
echo ">>     compiling project ($osarch)"
echo
echo
make
if [ $? -eq 0 ]; then
echo "make ok."
echo
echo "---------------------------------------------------------------------------------------------------"
echo ">>     copying files for package"
echo
echo
echo ">     creating assets archive actioncenter_assets.tar.gz"
#cmd        PACKAGE/usr/lib/actioncenter/actioncenter_assets.tar.gz
cd assets
tar -czvf actioncenter_assets.tar.gz de_$cmode en_$cmode fr_$cmode ru_$cmode proj_$cmode scripts_de scripts_fr scripts_en scripts_ru actioncenter_icon_$cmode.png
cd ..
mv -f assets/actioncenter_assets.tar.gz PACKAGE/usr/lib/actioncenter/actioncenter_assets.tar.gz
echo
echo ">     copying lib & desktop file"
\cp src/actioncenter_applet.desktop PACKAGE/opt/trinity/share/apps/kicker/applets/
\cp src/.libs/actioncenter_applet_panelapplet.lai PACKAGE/opt/trinity/lib/trinity/actioncenter_applet_panelapplet.la
\cp src/.libs/actioncenter_applet_panelapplet.so PACKAGE/opt/trinity/lib/trinity/actioncenter_applet_panelapplet.so
strip --strip-unneeded PACKAGE/opt/trinity/lib/trinity/actioncenter_applet_panelapplet.so
echo
echo ">     setting arch $osarch in control file"
sed -i 's/^Architecture:.*/Architecture: '"$osarch"'/g' PACKAGE/DEBIAN/control
echo
echo
echo ">     setting postinst script with $cmode mode"
sed -i 's/^cmode=.*/cmode="'"$cmode"'"/' PACKAGE/DEBIAN/postinst
echo
echo
echo "---------------------------------------------------------------------------------------------------"
echo ">>     creating package"
echo
echo
dpkg-deb -b PACKAGE actioncenter_applet_$cmode.deb
echo
else
echo "make error."
fi



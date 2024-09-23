#!/bin/sh
osarch=$(dpkg --print-architecture)
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
\cp src/actioncenter_applet.desktop PACKAGE/opt/trinity/share/apps/kicker/applets/
\cp src/.libs/actioncenter_applet_panelapplet.lai PACKAGE/opt/trinity/lib/trinity/actioncenter_applet_panelapplet.la
\cp src/.libs/actioncenter_applet_panelapplet.so PACKAGE/opt/trinity/lib/trinity/actioncenter_applet_panelapplet.so
strip --strip-unneeded PACKAGE/opt/trinity/lib/trinity/actioncenter_applet_panelapplet.so
echo
echo ">     setting arch $osarch in control file"
sed -i 's/^Architecture:.*/Architecture: '"$osarch"'/g' PACKAGE/DEBIAN/control
cmode="light"
if [ $# -gt 0 ]; then
    if [ "$1" = "dark" ]; then
        cmode="dark"
    fi
fi
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



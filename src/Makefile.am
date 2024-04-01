INCLUDES= $(all_includes)
METASOURCES = AUTO

kde_module_LTLIBRARIES = actioncenter_applet_panelapplet.la

actioncenter_applet_panelapplet_la_SOURCES = actioncenter_applet.cpp
actioncenter_applet_panelapplet_la_LDFLAGS = -module -avoid-version $(all_libraries) $(LIB_TQT) $(LIB_TDECORE) $(LIB_TDEUI) $(LIB_TDEPARTS)
actioncenter_applet_panelapplet_la_LIBADD = $(LIB_TDEUI) 

actioncenter_applet_DATA = actioncenter_applet.desktop
actioncenter_appletdir = $(kde_datadir)/kicker/applets

messages: rc.cpp
	$(EXTRACTRC) `find . -name \*.ui -o -name \*.rc` > rc.cpp
	$(XGETTEXT) *.cpp -o $(podir)/actioncenter_applet.pot

// actioncenter_applet.h
#ifndef ACTIONCENTER_APPLET_H
#define ACTIONCENTER_APPLET_H

#include <kpanelapplet.h>
#include <tqstring.h>
#include <tqlayout.h> 
#include <tqpushbutton.h> 
#include <tqdialog.h>

class actioncenter_applet : public KPanelApplet
{
    TQ_OBJECT

public:
    actioncenter_applet(const TQString& configFile, Type t = Normal, int actions = 0, TQWidget *parent = 0, const char *name = 0);
    ~actioncenter_applet();
    virtual int widthForHeight(int height) const;
    virtual int heightForWidth(int width) const;

protected:
void resizeEvent(TQResizeEvent *);

private slots:
void iconClicked();
void button1Clicked();
void button2Clicked();
void button3Clicked();
void button4Clicked();
void button5Clicked();
void button6Clicked();
void button11Clicked();
void button12Clicked();
void button13Clicked();
void button14Clicked();

private:
bool button1State;
bool button2State;
TDEConfig *ksConfig;
TQWidget *mainView;
TQDialog *customDialog;
TQDialog *newDialog;
TQWidget *splitter;
TQWidget *internalSplitter1;
TQWidget *internalSplitter2;
int getScreenHeight() const;
void addImageButton(const char *imagePathOn, const char *imagePathOff, const char *slot, bool &buttonState, TQWidget *parentWidget);
void addButton(const char *imagePath, const char *slot, TQWidget *parentWidget);
void showNewPanel();

};

#endif
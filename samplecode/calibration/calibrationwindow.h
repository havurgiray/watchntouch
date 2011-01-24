#ifndef CALIBRATIONWINDOW_H
#define CALIBRATIONWINDOW_H

#include <QMainWindow>
#include <QPixmap>
#include <QDesktopWidget>

#include <stdio.h>
#include <stdlib.h>
#include <QWaitCondition>
#include <QMutex>

#ifndef WIN32
        #include <unistd.h>
#endif
#include "basedrawingwidget.h"
#include "wiiuse.h"
#include "inputcalibration.h"

#include <X11/X.h>
#include <X11/Xlib.h>
#include <X11/Xutil.h>

#define HEIGHT_FIX  20  // TODO set this according to platform
#define MAX_WIIMOTES    1
#define CLICK_POINT_THRESHOLD 50 // minimum Manhattan spacing for calibration points


namespace Ui {
    class CalibrationWindow;
}

class CalibrationWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit CalibrationWindow(QWidget *parent = 0);
    ~CalibrationWindow();

    void setCalibrationPointImages(QImage newImageInitial, QImage newImageTouched);
    void recalibrate();

    QWaitCondition wc;
    QMutex mutex;
    int calibrationPointTouchCount;

private:
    Ui::CalibrationWindow *ui;
    QPixmap calibrationPointImageInitial;
    QPixmap calibrationPointImageTouched;
    InputCalibration mapper;
    int calibrationPointWidth, calibrationPointHeight;    
    Window root_window;
    Display * dpy;
    QPoint prevPoint;
    BaseDrawingWidget *draw;


    void repositionItems();
    void setCalibrationPointTouchStatus(int touchedCount);
    void mouseMove(int button, QPoint p);
    void mousePress(int button, QPoint p);
    void mouseRelease(int button, QPoint p);

protected:
    bool event(QEvent *event);    

public slots:
    void inputReceived(int x,int y,int i,int type);
    void calibrationPointReceived(QPoint p);

};

#endif // CALIBRATIONWINDOW_H

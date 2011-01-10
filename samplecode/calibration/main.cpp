#include <QtGui/QApplication>
#include "calibrationwindow.h"
#include "irthread.h"


int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    IRThread thread;
    CalibrationWindow w;

    thread.start();

    QObject::connect(&thread,SIGNAL(IRInputReceived(int,int,int)),&w,SLOT(inputReceived(int,int,int)));

    w.show();

    return a.exec();
}

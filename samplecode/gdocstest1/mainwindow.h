#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include "googledocsaccess.h"

namespace Ui {
    class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();

private:
    Ui::MainWindow *ui;
    GoogleDocsAccess g;

private slots:
    void on_pushButton_5_clicked();
    void on_pushButton_4_clicked();
};

#endif // MAINWINDOW_H
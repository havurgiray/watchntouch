/******************************************************************************
**
** Copyright (C) 2011, Yaman Umuroglu, Utku Sirin, Giray Havur, Melike Ercan.
** All rights reserved.
** This program is distributed under the terms of the GNU General Public License
**
*******************************************************************************/

#ifndef SKETCHINGTASK_H
#define SKETCHINGTASK_H

#include "contentdisplaytask.h"
#include "sketchingwidget.h"
#include "contextmenu.h"
#include <QVBoxLayout>
#include "contentmatcher.h"

class SketchingTask : public ContentDisplayTask
{
    Q_OBJECT
public:
    explicit SketchingTask(QWidget *parent = 0);

    void newSketch(QString id);
    void sketchFromImage(QString id, QPixmap img);
    int getTaskType();

protected:
    void showHidePanel(bool show);

    QVBoxLayout m_layout;
    SketchingWidget *m_sketchingWidget;
    ContentMatcher m_matcher;

signals:

public slots:

};

#endif // SKETCHINGTASK_H

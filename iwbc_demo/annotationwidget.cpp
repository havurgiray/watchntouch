#include "annotationwidget.h"

#include <QFile>

AnnotationWidget::AnnotationWidget(QWidget *parent) :
    BaseDrawingWidget(parent)
{
    currentContentDisplay = NULL;

    setHorizontalScrollBarPolicy(Qt::ScrollBarAlwaysOff);
    setVerticalScrollBarPolicy(Qt::ScrollBarAlwaysOff);
}

void AnnotationWidget::contentChanged(QString newContent)
{
    if(currentContent != "" && getDrawingData()->isModified())
        getDrawingData()->saveSVG(getCurrentAnnotation());

    currentContent = newContent;    // set new content identifier
    currentSize = currentContentDisplay->getContentSize();  // set the content size
    currentContext = "";    // context is initially empty for new content
}

void AnnotationWidget::contextChanged(QString newContext)
{
    if(currentContent != "" && getDrawingData()->isModified())
        getDrawingData()->saveSVG(getCurrentAnnotation());

    currentContext = newContext;

    // attempt to load existing annotation for the new context
    if(QFile::exists(getCurrentAnnotation())) {
        getDrawingData()->loadSVG(getCurrentAnnotation());
    } else {
        getDrawingData()->clear();
    }
}

QString AnnotationWidget::getCurrentAnnotation()
{
    return matcher.matchingAnnotation(currentContent, currentContext);
}

void AnnotationWidget::attachToContentDisplay(ContentDisplay *display)
{
    if(currentContentDisplay) {
        // remove the connections to the old widget
        disconnect(currentContentDisplay,SIGNAL(contentChanged(QString)), this, SLOT(contentChanged(QString)));
        disconnect(currentContentDisplay,SIGNAL(contextChanged(QString)), this, SLOT(contextChanged(QString)));
    }

    currentContentDisplay = display;

    contentChanged(display->getContentIdentifier());
    contextChanged(display->getContentContext());

    // establish the new connections
    connect(currentContentDisplay,SIGNAL(contentChanged(QString)), this, SLOT(contentChanged(QString)));
    connect(currentContentDisplay,SIGNAL(contextChanged(QString)), this, SLOT(contextChanged(QString)));
}
#include "contentmatcher.h"

#include <QDir>
#include <QApplication>

ContentMatcher::ContentMatcher()
{
    annotationDirPath = ANNOTATION_DIR;
    annotationPrefix = ANNOTATION_PREFIX;
    annotationExtension = ANNOTATION_EXTENSION;

    QDir annotationDir(annotationDirPath);
    // check if annotations directory exists
    if(!annotationDir.exists()) {
        // directory does not exist, create it
        annotationDir.mkdir(annotationDirPath);
    }
}


QString ContentMatcher::matchingAnnotation(QString contentId, QString context)
{
    QString contentDirPath = annotationDirPath + "/" + contentId;
    QDir contentDir(contentDirPath);
    // check if directory for given content ID exists
    if(!contentDir.exists()) {
        // directory does not exist, create it
        contentDir.mkdir(contentDirPath);
    }

    return contentDirPath + "/" + annotationPrefix + context + annotationExtension;
}
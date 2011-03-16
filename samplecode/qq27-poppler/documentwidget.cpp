/****************************************************************************
**
** Copyright (C) 2008 Nokia Corporation and/or its subsidiary(-ies).
** Contact: Qt Software Information (qt-info@nokia.com)
**
** This file is part of the documentation of Qt. It was originally
** published as part of Qt Quarterly.
**
** Commercial Usage
** Licensees holding valid Qt Commercial licenses may use this file in
** accordance with the Qt Commercial License Agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and Nokia.
**
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License versions 2.0 or 3.0 as published by the Free
** Software Foundation and appearing in the file LICENSE.GPL included in
** the packaging of this file.  Please review the following information
** to ensure GNU General Public Licensing requirements will be met:
** http://www.fsf.org/licensing/licenses/info/GPLv2.html and
** http://www.gnu.org/copyleft/gpl.html.  In addition, as a special
** exception, Nokia gives you certain additional rights. These rights
** are described in the Nokia Qt GPL Exception version 1.3, included in
** the file GPL_EXCEPTION.txt in this package.
**
** Qt for Windows(R) Licensees
** As a special exception, Nokia, as the sole copyright holder for Qt
** Designer, grants users of the Qt/Eclipse Integration plug-in the
** right for the Qt/Eclipse Integration to link to functionality
** provided by Qt Designer and its related libraries.
**
** If you are unsure which license is appropriate for your use, please
** contact the sales department at qt-sales@nokia.com.
**
****************************************************************************/

#include <QtGui>
#include <poppler-qt4.h>
#include "documentwidget.h"

#include <QDebug>

DocumentWidget::DocumentWidget(QWidget *parent)
    : QLabel(parent)
{
    currentPage = -1;
    doc = 0;
    rubberBand = 0;
    scaleFactor = 1.0;
    setAlignment(Qt::AlignCenter);
    pageImages.setCapacity(3);
}

DocumentWidget::~DocumentWidget()
{
    delete doc;
}

Poppler::Document *DocumentWidget::document()
{
    return doc;
}

QMatrix DocumentWidget::matrix() const
{
    return QMatrix(scaleFactor * physicalDpiX() / 72.0, 0,
                   0, scaleFactor * physicalDpiY() / 72.0,
                   0, 0);
}



qreal DocumentWidget::scale() const
{
    return scaleFactor;
}

void DocumentWidget::showPage(int page)
{
    if (page != -1 && page != currentPage + 1) {
        currentPage = page - 1;
        emit pageChanged(page);
    }

    QTime t;
    t.start();
    QImage image = getPageImage(currentPage);
    qWarning() << "elapsed during render: " << t.elapsed();
    if (!searchLocation.isEmpty()) {
        QRect highlightRect = matrix().mapRect(searchLocation).toRect();
        highlightRect.adjust(-2, -2, 2, 2);
        QImage highlight = image.copy(highlightRect);
        QPainter painter;
        painter.begin(&image);
        painter.fillRect(image.rect(), QColor(0, 0, 0, 32));
        painter.drawImage(highlightRect, highlight);
        painter.end();
    }

    t.restart();
    setPixmap(QPixmap::fromImage(image));
    qWarning() << "elapsed during setpixmap: " << t.elapsed();
}

QRectF DocumentWidget::searchBackwards(const QString &text)
{
    QRectF oldLocation = searchLocation;

    int page = currentPage;
    if (oldLocation.isNull())
        page -= 1;

    while (page > -1) {

        QList<QRectF> locations;
        searchLocation = QRectF();

        while (doc->page(page)->search(text, searchLocation,
            Poppler::Page::NextResult, Poppler::Page::CaseInsensitive)) {

            if (searchLocation != oldLocation)
                locations.append(searchLocation);
            else
                break;
        }

        int index = locations.indexOf(oldLocation);
        if (index == -1 && !locations.isEmpty()) {
            searchLocation = locations.last();
            showPage(page + 1);
            return searchLocation;
        } else if (index > 0) {
            searchLocation = locations[index - 1];
            showPage(page + 1);
            return searchLocation;
        }

        oldLocation = QRectF();
        page -= 1;
    }

    if (currentPage == doc->numPages() - 1)
        return QRectF();

    oldLocation = QRectF();
    page = doc->numPages() - 1;

    while (page > currentPage) {

        QList<QRectF> locations;
        searchLocation = QRectF();

        while (doc->page(page)->search(text, searchLocation,
            Poppler::Page::NextResult, Poppler::Page::CaseInsensitive)) {

            locations.append(searchLocation);
        }

        if (!locations.isEmpty()) {
            searchLocation = locations.last();
            showPage(page + 1);
            return searchLocation;
        }
        page -= 1;
    }

    return QRectF();
}

QRectF DocumentWidget::searchForwards(const QString &text)
{
    int page = currentPage;
    while (page < doc->numPages()) {

        if (doc->page(page)->search(text, searchLocation,
            Poppler::Page::NextResult, Poppler::Page::CaseInsensitive)) {
            if (!searchLocation.isNull()) {
                showPage(page + 1);
                return searchLocation;
            }
        }
        page += 1;
        searchLocation = QRectF();
    }

    page = 0;

    while (page < currentPage) {

        searchLocation = QRectF();

        if (doc->page(page)->search(text, searchLocation,
            Poppler::Page::NextResult, Poppler::Page::CaseInsensitive)) {
            if (!searchLocation.isNull()) {
                showPage(page + 1);
                return searchLocation;
            }
        }
        page += 1;
    }

    return QRectF();
}

void DocumentWidget::selectedText(const QRectF &rect)
{
    QRectF selectedRect = matrix().inverted().mapRect(rect);
    // QString text = doc->page(currentPage)->text(selectedRect);

    QString text;
    bool hadSpace = false;
    QPointF center;
    foreach (Poppler::TextBox *box, doc->page(currentPage)->textList()) {
        if (selectedRect.intersects(box->boundingBox())) {
            if (hadSpace)
                text += " ";
            if (!text.isEmpty() && box->boundingBox().top() > center.y())
                text += "\n";
            text += box->text();
            hadSpace = box->hasSpaceAfter();
            center = box->boundingBox().center();
        }
    }

    if (!text.isEmpty())
        emit textSelected(text);
}

bool DocumentWidget::setDocument(const QString &filePath)
{
    Poppler::Document *oldDocument = doc;

    doc = Poppler::Document::load(filePath);
    if (doc) {
        delete oldDocument;
        emit documentChanged(doc);
        doc->setRenderHint(Poppler::Document::Antialiasing);
        doc->setRenderHint(Poppler::Document::TextAntialiasing);
        searchLocation = QRectF();
        currentPage = -1;
        setPage(1);
    }
    return doc != 0;
}

void DocumentWidget::setPage(int page)
{
    if (page != currentPage + 1) {
        searchLocation = QRectF();
        showPage(page);
    }
}

void DocumentWidget::setScale(qreal scale)
{
    if (scaleFactor != scale) {
        scaleFactor = scale;
        showPage();
    }
}

QImage DocumentWidget::getPageImage(int pageNumber)
{
    // TODO for the given page number:
    // - retrieve the image if it exists in cache
    // insert it and the two surrounding page images if any of them don't

    if(pageNumber < 0 || pageNumber >= doc->numPages()) {
        // error, invalid page number
        // return a blank QImage
        return QImage();
    }

    if(pageNumber < doc->numPages() - 1) {
        while(pageNumber + 1 > pageImages.lastIndex())
            pageImages.append(doc->page(pageImages.lastIndex()+1)->renderToImage(scaleFactor * physicalDpiX(), scaleFactor * physicalDpiY()));

    }
    if(pageNumber > 0) {
        while(pageNumber - 1 < pageImages.firstIndex())
            pageImages.prepend(doc->page(pageImages.firstIndex()-1)->renderToImage(scaleFactor * physicalDpiX(), scaleFactor * physicalDpiY()));
    }

    return pageImages.at(pageNumber);
}
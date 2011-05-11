#include "webpagedisplaywidget.h"
#include <QCryptographicHash>
#include <QVBoxLayout>
#include <QWebFrame>
#include "recentlyused.h"

WebpageDisplayWidget::WebpageDisplayWidget(QWidget *parent) :
    ContentDisplay(parent)
{
    QVBoxLayout * layout = new QVBoxLayout();
    mWebView = new QWebView(this);
    layout->addWidget(mWebView);
    setLayout(layout);

    connect(mWebView, SIGNAL(loadFinished(bool)), this, SLOT(webPageLoadFinishedInternal(bool)));
    connect(mWebView, SIGNAL(loadProgress(int)), this, SIGNAL(webPageLoadProgress(int)));
    connect(mWebView, SIGNAL(loadStarted()), this, SIGNAL(webPageLoadStarted()));
    connect(mWebView, SIGNAL(loadFinished(bool)), this, SIGNAL(webPageLoadFinished(bool)));
    connect(mWebView, SIGNAL(urlChanged(QUrl)), this, SIGNAL(webPageUrlChanged(QUrl)));
    connect(mWebView, SIGNAL(loadStarted()), this, SLOT(webPageLoadStartInternal()));

    connect(mWebView->page(), SIGNAL(scrollRequested(int,int,QRect)), this, SLOT(scrollRequested(int,int,QRect)));
}

bool WebpageDisplayWidget::selectContent(QString location)
{
    // load the requested webpage
    mWebView->load(QUrl(location));
    // TODO we should actually return the value for the loadFinished OK parameter here
    return true;
}

void WebpageDisplayWidget::webPageLoadStartInternal()
{
    mUrlString = "";
    // emit empty content and context message since from this point on to when the loading is finished,
    // we're in limbo and should not really display any annotation
    emit contentChanged("");
}

QString WebpageDisplayWidget::getContentContext()
{
    // TODO currently each webpage is a single context - a more sophisticated system needed?
    return "1";
}

void WebpageDisplayWidget::generateContentIdentifier()
{
    contentMD5 = QString(QCryptographicHash::hash(mUrlString.toAscii(), QCryptographicHash::Md5).toHex().constData());
}

void WebpageDisplayWidget::loadWebPage(QUrl newLocation)
{
    selectContent(newLocation.toString());
}

void WebpageDisplayWidget::webPageLoadFinishedInternal(bool ok)
{
    if(ok) {
        recentlyUsed->addRecentItem(mWebView->title(), mWebView->url().toString());
        mUrlString = mWebView->url().toString();
        generateContentIdentifier();

        emit contentChanged(getContentIdentifier());
        // TODO currently each webpage is a single context - a more sophisticated system needed?
        emit contextChanged("1");
    } else {
        displayErrorMessage("Could not load requested web page");
        mUrlString = "";
    }
}

void WebpageDisplayWidget::setExternalViewportSize(QSize newSize)
{
    m_externalViewportSize = newSize;
}

void WebpageDisplayWidget::scrollRequested(int dx, int dy, const QRect &rectToScroll)
{
    qWarning() << "dx" << dx << "dy" << dy <<"rect" << rectToScroll;
}

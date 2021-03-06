/******************************************************************************
**
** Copyright (C) 2011, Yaman Umuroglu, Utku Sirin, Giray Havur, Melike Ercan.
** All rights reserved.
** This program is distributed under the terms of the GNU General Public License
**
*******************************************************************************/

import Qt 4.7

Rectangle {
    id: window
    z:-1
    width: 1024
    height: 600
    color: "transparent"


    property string activeFunction: ""

    signal mousePressed(int x, int y, int button, int buttons)
    signal mouseMoved(int x, int y, int buttons, int buttons)
    signal mouseReleased(int x, int y, int buttons, int buttons)

    function taskManagerPreparation(rectColor, highlightColor, taskType){
        console.log("taskmanagerprep " + taskType + " " + taskManagerRect.taskManagerTaskType + " " + taskManagerRect.opacity);
        if((taskManagerRect.opacity==1 && taskManagerRect.taskManagerTaskType!=taskType)) {

            taskManagerRect.opacity=0;
        }

        taskManagerRect.color = rectColor;
        taskManagerRect.taskManagerTaskType = taskType;
       // taskHighlightRect.color=  highlightColor;
    }

    function taskManagerShowHideExternal(showHide){
        if(!showHide){
            hideMenus.target=taskManagerRect;
            hideMenus.running=true;

            presInterface.anchors.bottom = bottomMenu.top;
            webInterface.anchors.bottom = bottomMenu.top;
            multInterface.anchors.bottom = bottomMenu.top;
        }
        else{
            showMenus.target=taskManagerRect;
            showMenus.running=true;

            presInterface.anchors.bottom = taskManagerRect.top;
            webInterface.anchors.bottom = taskManagerRect.top;
            multInterface.anchors.bottom = taskManagerRect.top;
        }
    }

    function taskManagerShowHide(){
        if(taskManagerRect.opacity==1){
            hideMenus.target=taskManagerRect;
            hideMenus.running=true;

            presInterface.anchors.bottom = bottomMenu.top;
            webInterface.anchors.bottom = bottomMenu.top;
            multInterface.anchors.bottom = bottomMenu.top;
        }
        else if(taskManagerRect.opacity==0){
            showMenus.target=taskManagerRect;
            showMenus.running=true;

            presInterface.anchors.bottom = taskManagerRect.top;
            webInterface.anchors.bottom = taskManagerRect.top;
            multInterface.anchors.bottom = taskManagerRect.top;
        }
    }

    function showHideCollaboration(showHide){
        if(showHide){
            showMenus.target=colInterface;
            showMenus.running=true;

        }
        else{
            hideMenus.target=colInterface;
            hideMenus.running=true;
        }
    }

    function showHideSketch(showHide){
        if(showHide){
            showMenus.target=sketchInterface;
            showMenus.running=true;

        }
        else{
            hideMenus.target=sketchInterface;
            hideMenus.running=true;
        }
    }

    function showHidePresentation(showHide){
        if(showHide){
            showMenus2.target=presInterface;
            hideMenus2.target=presInterface;

            showMenus.target=presInterface;
            showMenus.running=true;



        }
        else{
            hideMenus.target=presInterface;
            hideMenus.running=true;
        }
    }

    function showHideWeb(showHide){
        if(showHide){
            showMenus2.target=webInterface;
            hideMenus2.target=webInterface;

            showMenus.target=webInterface;
            showMenus.running=true;


        }
        else{
            hideMenus.target=webInterface;
            hideMenus.running=true;
        }
    }

    function showHideMultimedia(showHide){
        if(showHide){
            showMenus2.target=multInterface;
            hideMenus2.target=multInterface;

            showMenus.target=multInterface;
            showMenus.running=true;



        }
        else{
            hideMenus.target=multInterface;
            hideMenus.running=true;
        }
    }

    function webLoadingBar(percent){
        webLoadingImg.width = (percent * (window.width/1.79))/100;
        if(percent==100 || percent==0){
            webLoadingHide.running=true;
        }
        else if(webLoadingImg.opacity!=1){
            webLoadingImg.opacity=1;
        }
    }



    //BOTTOM MENU SIGNALS AND FUNCTIONS

    signal mainMenuShowHide(bool newStatus)
    signal exitPressed()
    signal recordPressed(bool newStatus)
    signal collaborationPressed()
    signal notificationsPressed()
    signal presentationPressed()
    signal webPressed()
    signal multimediaPressed()
    signal sketchPressed()
    signal fullscreenStateChange()

    function fullscreenImgOn(){
        fullscreenImg.source = "images/mainmenu/fullscreenOn.png";
    }

    function fullscreenImgOff(){
        fullscreenImg.source = "images/mainmenu/fullscreenOff.png";
    }

    function taskTypeCounterIncrementOne(type){ //taskType: 0-collaboration 1-sketch 2-presentation 3-web 4-multimedia
        switch(type){
        case 0:{
            textColl.no++;
            if(textColl.no>0){
                textCollBackgroundCircle.visible = true;
                textColl.visible = true;
            }
        }
        break;
        case 1:{
            textSketch.no++;
            if(textSketch.no>0){
                textSketchBackgroundCircle.visible = true;
                textSketch.visible = true;
            }
        }
        break;
        case 2:{
            textPres.no++;
            if(textPres.no>0){
                textPresBackgroundCircle.visible = true;
                textPres.visible = true;
            }
        }
        break;
        case 3:{
             textWeb.no++;
            if(textWeb.no>0){
                textWebBackgroundCircle.visible = true;
                textWeb.visible = true;
            }
        }
        break;
        case 4:{
             textMM.no++;
            if(textMM.no>0){
                textMMBackgroundCircle.visible = true;
                textMM.visible = true;
            }
        }
        break;
        }
    }

    function taskTypeCounterDecrementOne(type){ //taskType: 0-collaboration 1-sketch 2-presentation 3-web 4-multimedia
        switch(type){
        case 0:{
            textColl.no--;
            if(textColl.no==0){
                textCollBackgroundCircle.visible = false;
                textColl.visible = false;
            }
        }
        break;
        case 1:{
            textSketch.no--;
            if(textSketch.no==0){
                textSketchBackgroundCircle.visible = false;
                textSketch.visible = false;
            }
        }
        break;
        case 2:{
            textPres.no--;
            if(textPres.no==0){
                textPresBackgroundCircle.visible = false;
                textPres.visible = false;
            }
        }
        break;
        case 3:{
             textWeb.no--;
            if(textWeb.no==0){
                textWebBackgroundCircle.visible = false;
                textWeb.visible = false;
            }
        }
        break;
        case 4:{
             textMM.no--;
            if(textMM.no==0){
                textMMBackgroundCircle.visible = false;
                textMM.visible = false;
            }
        }
        break;
        }
    }

    //MULTIMEDIA SIGNALS AND FUNCTIONS

    signal playPause(bool playpause)
    signal gotoPrevAnnotation()
    signal gotoNextAnnotation()


    signal sliderMouseDown(int timelineSizeInPixels, int relativePositionOfTimeIndicatorInPixels )
    signal sliderMouseUp( int timelineSizeInPixels, int relativePositionOfTimeIndicatorInPixels )
    signal sliderMouseMove( int timelineSizeInPixels, int relativePositionOfTimeIndicatorInPixels )

    signal volumeMouseDown(int volume)
    signal volumeMouseUp(int volume)
    signal volumeMouseMove(int volume)


    //int timelineSizeInPixels, int relativePositionOfTimeIndicatorInPixels

    function setSliderPosition(a){
        timelineDotImage.x=a*window.width/1.25;
    }

    function setVideoTime(a, b){
        passingTime.pt=a;
        remainingTime.rt=b;
    }

    function setVolume(a){
        volumeControlIndicatorImage.x=(a*(window.width/9.54))/100;
    }

    //WEB SIGNALS AND FUNCTIONS

    signal back()
    signal next()
    signal refresh()
    signal bookmarkRequest(string URL)
    signal gotoBookmark(string URL)
    signal deleteBookmarkRequest(string URL, int index)
    signal bookmarkMenuShowHide(bool showhide)
    signal webAnnotationStatus(bool onOff)
    signal gotoURL(string URL)

    function setURLText(URL) {
        webTextInput.text = URL;
    }


    function addBookmark(URL){
        weblistModelSketch.append({"val": URL});
    }

    function deleteBookmark(index){
        weblistModelSketch.remove(index);
    }

    function clearBookmarkList() {
        weblistModelSketch.clear();
    }

    function closeBookmarkList(){
        favListHide.running=true;
    }

    function setWebReadOnlyStatus(readOnly) {
        console.log("QML::setWebReadOnlyStatus " + readOnly);
        if (readOnly){
            webAnnoImg.webReadOnly = 1;
            webAnnoImg.source = "images/webImages/annooff.png";
        } else {
            webAnnoImg.webReadOnly = 0;
            webAnnoImg.source = "images/webImages/annoon.png"
        }
    }


    //PRESENTATION SIGNALS AND FUNCTIONS

    signal goToFirstPage()
    signal goToPrevPage()
    signal goToNextPage()
    signal goToLastPage()
    signal goToPageNumber(string no)
    signal presZoomIn()
    signal presZoomOut()
    signal fitPageWidthToScreenSize();
    signal fitPageHeighttoScreenSize();


    function setSlideNumber(no){
        presPageNumber.text=no;
    }

    function addToPageScroller(pathOfTheImage, pageNo){

        presPagingVisualsListModel.append({"name": pageNo, "pageNo": pageNo, "file": pathOfTheImage })
    }

    function clearPageScroller(){
        presPagingVisualsListModel.clear();
    }

    function alignPageScrollerToPageNumber(pageNo){
        presPagingVisualsView.positionViewAtIndex(pageNo - 1,ListView.Center);
        presPagingVisualsView.currentIndex = pageNo-1;
    }

    //TASK MANAGER SIGNALS AND FUNCTIONS

    signal newTask(int taskType);  //taskType: 0-collaboration 1-sketch 2-presentation 3-web 4-multimedia
    signal switchToTask(string taskId);
    signal killTask(string taskId);
    signal openTaskManager(int taskType);


    function alignTaskScrollerToSelectedTask(taskID){

        var i = 0;
        for(i = 0; i < taskPagingVisualsListModel.count; i++)
        {
            if(taskPagingVisualsListModel.get(i).taskId == taskID) {
                taskPagingVisualsView.currentIndex = i;
                taskPagingVisualsView.positionViewAtIndex(i,ListView.Center);
            }
        }


    }

    function addToTaskManagerScroller(pathOfTheImage, taskId){
        taskPagingVisualsListModel.append({"name": taskId, "taskId": taskId,"file": pathOfTheImage})
    }

    function clearTaskManagerScroller(){
        taskPagingVisualsListModel.clear();
    }

    function removeTaskFromScroller(taskID) {
        var i = 0;
        for(i = 0; i < taskPagingVisualsListModel.count; i++)
        {
            if(taskPagingVisualsListModel.get(i).taskId == taskID)
                taskPagingVisualsListModel.remove(i);
        }
    }

    function isTaskScrollerVisible() {
        return taskManagerRect.opacity;
    }

    PropertyAnimation { id: showMenus; target: []; property: "opacity"; to: 1; duration: 300 }
    PropertyAnimation { id: hideMenus; target: []; property: "opacity"; to: 0; duration: 300 }
    PropertyAnimation { id: showMenus2; target: []; property: "opacity"; to: 1; duration: 300 }
    PropertyAnimation { id: hideMenus2; target: []; property: "opacity"; to: 0.01; duration: 300 }

    Timer {
        id:showHideTimer
        interval: 2000; running: false; repeat: true
             onTriggered: {
                 hideMenus2.running = true;
             }
         }

    Rectangle{      // TASK MANAGER
         id: taskManagerRect
         anchors.bottom: bottomMenu.top
         anchors.bottomMargin: -1
         opacity: 0
         width: window.width
         height: window.width/7.2
         clip: true;
         color: "#f9d299"


         property int taskManagerTaskType:0

         VisualDataModel {               //TODO: ListElement'ten File system'e gecir
             id: taskPagingVisualsImgs
             model: ListModel {
                 id: taskPagingVisualsListModel
                 ListElement { name: "1"; taskId: "1"; file: "images/presImages/pages/1.png" }
                 ListElement { name: "2"; taskId: "2"; file: "images/presImages/pages/2.png" }
                 ListElement { name: "3"; taskId: "3"; file: "images/presImages/pages/3.png" }
                 ListElement { name: "4"; taskId: "4"; file: "images/presImages/pages/4.png" }
                 ListElement { name: "5"; taskId: "5"; file: "images/presImages/pages/5.png" }
                 ListElement { name: "6"; taskId: "6"; file: "images/presImages/pages/6.png" }
                 ListElement { name: "7"; taskId: "7"; file: "images/presImages/pages/7.png" }
                 ListElement { name: "8"; taskId: "8"; file: "images/presImages/pages/8.png" }
                 ListElement { name: "9"; taskId: "9"; file: "images/presImages/pages/9.png" }
             }

             delegate:Image {
                 id: name
                 source: file
                 visible: true
                 height: window.width/8.192
                 width: height*(sourceSize.width/sourceSize.height)
                 //width: name.paintedWidth
                 //fillMode: Image.PreserveAspectCrop
                 smooth: true
                 anchors.bottom: parent.bottom
                 anchors.bottomMargin: window.width/120

                 MouseArea {
                     anchors.fill: parent

                     onClicked: {
                         console.log("Switch to task "+ taskId);
                         switchToTask(taskId);
                         alignTaskScrollerToSelectedTask(index);
                     }
                 }

                 Image{
                     anchors.right: parent.right
                     anchors.top: parent.top
                     anchors.topMargin: window.width/341.3
                     anchors.rightMargin: window.width/341.3
                        // CALCULATION: width: window.width/ (1024/ImageWidth)
                     width: window.width/25.6; height: window.width/25.6
                     fillMode: Image.PreserveAspectFit
                     smooth: true
                     source: "images/mainmenu/menuClose3.png"
                     MouseArea {
                         anchors.fill: parent
                         onClicked: {            // TODO: AIT OLAN PENCEREYI KAPATACAK
                             taskPagingVisualsListModel.remove(index);
                             killTask(taskId);
                         }
                     }
                 }

            }

         }

         Component {
             id: taskHighlight
             Rectangle {
                 id: taskHighlightRect
                 width: list.currentItem.width
                 height: window.width/7.2
                 color: "red"; radius: 5
                 //anchors.centerIn: list.currentItem
                 //y: list.currentItem.y

             }

         }

         Row{
             id: taskManagerRow
             width: window.width
             height: window.width/7.2
             //color: "transparent"

             Rectangle{
                 width: window.width/10.24
                 height: window.width/7.2
                 color:"transparent"
                 Image{
                     id: newTaskButtonImg
                     width: window.width/20
                     height: window.width/20
                     anchors.centerIn: parent
                     smooth: true
                     source: "images/mainmenu/menuNew3.png"
                     MouseArea{
                         anchors.fill: parent
                         onClicked: {
                             console.log("New task "+ taskManagerRect.taskManagerTaskType);
                             newTask(taskManagerRect.taskManagerTaskType);
                     }
                 }
                 }
             }

             Rectangle{
                 width: window.width/1.108
                 height: window.width/7.2
                 clip: true
                 color: "transparent"

                 ListView {

                     id: taskPagingVisualsView

                     anchors.fill: parent
                     model: taskPagingVisualsImgs
                     orientation: ListView.Horizontal
                     spacing: window.width/51.2

                     highlight: taskHighlight
                     highlightFollowsCurrentItem: true
                     highlightMoveDuration: 1
                     highlightResizeDuration: 1
                     focus: true
                     //preferredHighlightBegin: 50
                     snapMode: ListView.SnapToItem

                 }
             }


         }


    }

Rectangle{      //PRES INTERFACE


         id: presInterface
         width: window.width
         height: presButtons.height;
         objectName: "presInterface"
         anchors.bottom: bottomMenu.top
         opacity: 0


         MouseArea{
             id: presShowHideMouseArea
             hoverEnabled : true
             anchors.fill: parent
             property int presHover:0
             onHoveredChanged: {
                 if(presHover%2==0){
                     console.log("TIMER STOPPED");
                     showHideTimer.stop();
                     showMenus2.running=true;
                 }
                 else{
                     console.log("TIMER STARTED");
                     showHideTimer.restart();
                 }
                 presHover++;
             }
         }


    Rectangle{      //buttons
        id: presButtons
        anchors.bottom: presInterface.bottom
        opacity: 1
        width: window.width
        height: window.width/15.0
        color: "#dbdea5"



        PropertyAnimation { id: presVisualsReveal; target:presPagingVisualsRect; property: "opacity"; to: 1; duration: 300 }
        PropertyAnimation { id: presVisualsHide; target:presPagingVisualsRect; property: "opacity"; to: 0; duration: 300 }

        Rectangle{
            id: presShowPages
            width: window.width/6.20
            height: window.width/20.07
            anchors.right: presMainButtonRow.left;
            anchors.rightMargin: window.width/12.80;
            anchors.verticalCenter:parent.verticalCenter;
            color: "transparent" //TODO: onclicked: color=e4f87e

            Image{
                id: presShowPagesImg
                anchors.centerIn: parent
                width: window.width/6.20; height: window.width/20.07   // CALCULATION: width: window.width/ (1024/ImageWidth)
                fillMode: Image.PreserveAspectFit
                smooth: true
                source: "images/presImages/showPages.png"
            }
            MouseArea {
                property int presShowPagesInt: 0;
                anchors.fill: parent
                onClicked:{

                console.log("Presentation Paging");
                presShowPagesInt = presShowPagesInt+1;
                    if (presShowPagesInt%2==0){
                        presInterface.height-=window.width/7.2;
                        presShowPagesImg.source = "images/presImages/showPages.png";
                        presVisualsHide.running=true;
                    }
                    if (presShowPagesInt%2==1){
                        presInterface.height+=window.width/7.2;
                        presShowPagesImg.source = "images/presImages/showPagesOn.png";
                        presVisualsReveal.running=true
                    }
                }
            }
        }


        Row{
            id: presMainButtonRow
            spacing: window.width/60.0
            anchors.centerIn: parent;
            Rectangle{
                id: presGotoFirstPage
                width: window.width/16.25
                height: window.width/24.97
                color: "transparent" //TODO: onclicked: color=e4f87e

                Image{

                    anchors.centerIn: parent
                    width: window.width/16.25; height: window.width/24.97   // CALCULATION: width: window.width/ (1024/ImageWidth)
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    source: "images/presImages/gotoFirstPage.png"
                }
                MouseArea {
                    property int presShowPagesInt: 0;
                    anchors.fill: parent
                    onClicked:{
                        goToFirstPage();
                        console.log("Presentation Goto First Page");
                    }
                }
            }

            Rectangle{
                id: presGotoPrevPage
                anchors.verticalCenter: parent
                width: window.width/20.07
                height: window.width/26.25
                color: "transparent"
                Image{
                    anchors.centerIn: parent
                    width: window.width/20.07; height: window.width/26.25 // CALCULATION: width: window.width/ (1024/ImageWidth)
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    source: "images/presImages/previousPage.png"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        goToPrevPage();
                        console.log("Presentation Goto Previous Page");
                    }
                }
            }

            Text{
                id: presPageNumber
                text: "1/9"
                font.family: "Ubuntu"
                font.pointSize: window.width/50
                color: "black"
            }

            Rectangle{
                id: presGotoNextPage
                anchors.verticalCenter: parent
                width: window.width/20.07
                height: window.width/26.25
                color: "transparent"
                Image{
                    anchors.centerIn: parent
                    width: window.width/20.07; height: window.width/26.25   // CALCULATION: width: window.width/ (1024/ImageWidth)
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    source: "images/presImages/nextPage.png"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        goToNextPage();
                        console.log("Presentation Goto Next Page");
                    }
                }
            }

            Rectangle{
                id: presGotoLastPage
                anchors.verticalCenter: parent
                width: window.width/16.25
                height: window.width/24.97
                color: "transparent"
                Image{
                    anchors.centerIn: parent
                    width: window.width/16.25; height: window.width/24.97   // CALCULATION: width: window.width/ (1024/ImageWidth)
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    source: "images/presImages/gotoLastPage.png"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        goToLastPage();
                        console.log("Presentation Goto Last Page");
                    }
                }
            }

        }

        Row{

            spacing: window.width/100.0
            anchors.left: presMainButtonRow.right;
            anchors.leftMargin: window.width/17.0
            anchors.verticalCenter:parent.verticalCenter;
            opacity: 0

            Rectangle{
                id: presFitHeight
                anchors.verticalCenter: parent
                width: window.width/21.78
                height: window.width/20.89
                color: "transparent"
                Image{
                    anchors.centerIn: parent
                    width: window.width/21.78; height: window.width/20.89 // CALCULATION: width: window.width/ (1024/ImageWidth)
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    source: "images/presImages/fitPageToHeight.png"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        fitPageHeighttoScreenSize();
                        console.log("Presentation Fit Page To Height");
                    }
                }
            }

            Rectangle{
                id: presFitWidth
                anchors.verticalCenter: parent
                width: window.width/21.78
                height: window.width/20.89
                color: "transparent"
                Image{
                    anchors.centerIn: parent
                    width: window.width/21.78; height: window.width/20.89   // CALCULATION: width: window.width/ (1024/ImageWidth)
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    source: "images/presImages/fitPageToWidth.png"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        fitPageWidthToScreenSize();
                        console.log("Presentation Fit Page To Width");
                    }
                }
            }

            Rectangle{
                id: presZoomIn
                anchors.verticalCenter: parent
                width: window.width/21.78
                height: window.width/20.89
                color: "transparent"
                Image{
                    anchors.centerIn: parent
                    width: window.width/21.78; height: window.width/20.89    // CALCULATION: width: window.width/ (1024/ImageWidth)
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    source: "images/presImages/zoomIn.png"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        presZoomIn();
                        console.log("Presentation Zoom In");
                    }
                }
            }

            Rectangle{
                id: presZoomOut
                anchors.verticalCenter: parent
                width: window.width/21.78
                height: window.width/20.89
                color: "transparent"
                Image{
                    anchors.centerIn: parent
                    width: window.width/21.78; height: window.width/20.89   // CALCULATION: width: window.width/ (1024/ImageWidth)
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    source: "images/presImages/zoomOut.png"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                         presZoomOut();

                         console.log("Presentation Zoom Out");
                    }
                }
            }

        }
    }

    Rectangle{ // paging visuals
         id: presPagingVisualsRect
         anchors.bottom: presButtons.top
         opacity: 0
         width: window.width
         height: window.width/7.2
         clip: true;
         color: "#e5f97e"

         VisualDataModel {               //TODO: ListElement'ten File system'e gecir
             id: presPagingVisualsImgs
             model: ListModel {
                 id: presPagingVisualsListModel
                 ListElement { name: "1"; pageNo: "1"; file: "images/presImages/pages/1.png" }
                 ListElement { name: "2"; pageNo: "2"; file: "images/presImages/pages/2.png" }
                 ListElement { name: "3"; pageNo: "3"; file: "images/presImages/pages/3.png" }
                 ListElement { name: "4"; pageNo: "4"; file: "images/presImages/pages/4.png" }
                 ListElement { name: "5"; pageNo: "5"; file: "images/presImages/pages/5.png" }
                 ListElement { name: "6"; pageNo: "6"; file: "images/presImages/pages/6.png" }
                 ListElement { name: "7"; pageNo: "7"; file: "images/presImages/pages/7.png" }
                 ListElement { name: "8"; pageNo: "8"; file: "images/presImages/pages/8.png" }
                 ListElement { name: "9"; pageNo: "9"; file: "images/presImages/pages/9.png" }
             }

             /*
                                      }
                                  }
                                  Text{
                                      text: pageNo
                                      anchors.horizontalCenter: parent.horizontalCenter
                                      width: window.width/15.6
                                      font.family: "Ubuntu"
                                      font.pointSize: window.width/50
                                      color: "black"
                                  }
                              }
             */

             delegate:Image {
                 id: name
                 source: file
                 visible: true
                 height: window.width/8.192
                 width: height*(sourceSize.width/sourceSize.height)
                 //width: name.paintedWidth
                 //fillMode: Image.PreserveAspectCrop
                 smooth: true
                 anchors.bottom: parent.bottom
                 anchors.bottomMargin: window.width/120

                 MouseArea {
                     anchors.fill: parent

                     onClicked: {
                         console.log("Goto page "+ pageNo);
                         goToPageNumber(pageNo);
                         alignPageScrollerToPageNumber(pageNo);
                     }
                 }



                 Image{
                     anchors.centerIn: parent
                     height: window.width/42.6
                     width: height*(sourceSize.width/sourceSize.height)
                     //width: height*(Image.width/Image.height)
                     //fillMode: Image.PreserveAspectCrop
                     smooth: true
                     source: if(pageNo<999) "images/presImages/noFrame.png"
                             else "images/presImages/noFrameLarge.png"

                     Text{
                         text: pageNo
                         anchors.centerIn: parent
                         //font.bold: true
                         font.family: "Ubuntu"
                         font.pointSize: window.width/70
                         color: "black"
                     }

                 }
            }

         }

         Component {
             id: presHighlight
             Rectangle {
                 width: list.currentItem.width; height: window.width/7.2
                 color: "#5d5526"; radius: 5
                 //anchors.centerIn: list.currentItem
                 //y: list.currentItem.y

             }

         }


         ListView {
             id: presPagingVisualsView
             anchors.fill: parent
             model: presPagingVisualsImgs
             orientation: ListView.Horizontal
             spacing: window.width/51.2

             highlight: presHighlight
             highlightFollowsCurrentItem: true
             highlightMoveDuration: 1
             highlightResizeDuration: 1
             focus: true
             //preferredHighlightBegin: 50
             snapMode: ListView.SnapToItem

         }

/*
         PathView {
             id: presPagingVisualsView
             anchors.fill: parent
             //anchors.topMargin:70


             //dragMargin : 90

             model: presPagingVisualsImgs
             path: Path {

                 startX: 80; startY: 0;
                 PathLine { x: window.width*1.2; y: 0; }
                 PathPercent {value: 0.8;}

             }


         }
 */
    }
}

Rectangle{          //MM INTERFACE

        function playPause(){


        }

        id: multInterface
        opacity: 0
        width: window.width
        height: window.width/15.0
        color: "#a2d6d8"
        anchors.bottom: bottomMenu.top
        property int fullLength: 1123;   //TODO: Assign video length in sec.

        MouseArea{
            id: multShowHideMouseArea
            hoverEnabled : true
            anchors.fill: parent
            property int presHover:0
            onHoveredChanged: {
                if(presHover%2==0){
                    console.log("TIMER STOPPED");
                    showHideTimer.stop();
                    showMenus2.running=true;
                }
                else{
                    console.log("TIMER STARTED");
                    showHideTimer.restart();
                }
                presHover++;
            }
        }



        Image{
            anchors.horizontalCenter: multInterface.horizontalCenter
            anchors.bottom: multInterface.top
            anchors.bottomMargin:-2
            width: window.width/2.375
            height: window.width/20.89
            smooth: true
            source: "images/MMImages/MMBarTop.png"
        }

        Row{
            id: mMbuttons
            anchors.horizontalCenter: multInterface.horizontalCenter
            anchors.bottom: multInterface.top
            anchors.bottomMargin:-window.width/80
            spacing: window.width/51.2

            MouseArea {
                id: volumeControlArea
                width: window.width/8.53
                height: window.width/29.25
                y: window.width/266
                property int volume: 70; //TODO: Volume'e bagla: 100 uzerinden, 70/100 baslangic degeri?
                drag.target : volumeControlIndicatorImage
                drag.axis : Drag.XAxis
                drag.minimumX : 0
                drag.maximumX : window.width/9.54

                Image {
                    id: volumeControlImage
                    width: window.width/8.53
                    height: window.width/29.25
                    smooth: true
                    source: "images/MMImages/MMVolume.png"
                }
                Image{
                    id: volumeControlIndicatorImage
                    width: window.width/64
                    height: window.width/24.38
                    x: window.width/14.1        //TODO: 70/100 baslangic degeri
                    y:-window.width/256
                    smooth: true
                    source: "images/MMImages/MMVolumeIndicator.png"
                }

                onPositionChanged:{
                    volumeMouseMove((volumeControlIndicatorImage.x*100)/(window.width/9.54));
                    console.log((volumeControlIndicatorImage.x*100)/(window.width/9.54));
                }

                onPressed: {
                    volumeControlIndicatorImage.x = mouseX-window.width/130;
                    volumeMouseDown((volumeControlIndicatorImage.x*100)/(window.width/9.54));
                    console.log((volumeControlIndicatorImage.x*100)/(window.width/9.54));
                }

                onReleased: {
                    volumeMouseUp((volumeControlIndicatorImage.x*100)/(window.width/9.54));
                    console.log((volumeControlIndicatorImage.x*100)/(window.width/9.54));
                }

             }
            MouseArea {
                id: playPauseArea
                width: window.width/21.33
                height: window.width/21.33
                y: -window.width/266
                property int videoPlayPauseNo: 0

                Image {
                    id: playPauseImage
                    width: window.width/21.33
                    height: window.width/21.33
                    smooth: true
                    source: "images/MMImages/MMPlay.png"
                }

                onClicked: {
                    console.log("Play-Pause Video");
                    videoPlayPauseNo = videoPlayPauseNo+1;
                        if (videoPlayPauseNo%2==0){
                            playPauseImage.source = "images/MMImages/MMPlay.png";
                            window.playPause(false);
                        }
                        if (videoPlayPauseNo%2==1){
                            playPauseImage.source = "images/MMImages/MMPause.png";
                            window.playPause(true);
                        }
                }
             }
            MouseArea {
                id: prevAnnoArea
                width: window.width/19.32
                height: window.width/24.97

                //contentWidth: image.width; contentHeight: image.height
                Image {
                    id: prevAnnoImage
                    width: window.width/19.32
                    height: window.width/24.97
                    smooth: true
                    source: "images/MMImages/MMPrevAnnotation.png"
                }
                onClicked: {
                    window.gotoPrevAnnotation();
                    console.log("Goto Previous Video Annotation");
                }
             }

            MouseArea {
                id: nextAnnoArea
                width: window.width/19.32
                height: window.width/24.97

                //contentWidth: image.width; contentHeight: image.height
                Image {
                    id: nextAnnoImage
                    width: window.width/19.32
                    height: window.width/24.97
                    smooth: true
                    source: "images/MMImages/MMNextAnnotation.png"
                }
                onClicked: {
                    window.gotoNextAnnotation();
                    console.log("Goto Next Video Annotation");
                }
             }

        }

        Row{
            id: timeline
            anchors.centerIn: parent;
            spacing: window.width/50.0

            Text{
                id: passingTime
                property string pt: "00.00"
                text: pt
                width: window.width/15.6
                font.family: "Ubuntu"
                font.pointSize: window.width/55
                color: "black"
            }

            Rectangle{
                id: line
                y: window.width/90
                width: window.width/1.25
                height: window.width/102
                color: "#dcdcdc"
            }



            Text{
                width: window.width/15.6
                id: remainingTime
                property string rt: "00.00"
                text: rt
                font.family: "Ubuntu"
                font.pointSize: window.width/55
                color: "black"
            }

        }


        MouseArea {
            id: timelineDotArea
            width: window.width/1.20
            height: window.width/30
            x: window.width/12
            y: window.width/64
            clip:true
            drag.target : timelineDotImage
            drag.axis : Drag.XAxis
            drag.minimumX : 0
            drag.maximumX : window.width/1.26

           onPositionChanged:{
                window.sliderMouseMove(window.width/1.20, timelineDotImage.x);
                console.log(timelineDotImage.x);
            }

            onPressed: {
                timelineDotImage.x=mouseX-window.width/70;
                window.sliderMouseDown(window.width/1.20, timelineDotImage.x);
                console.log(timelineDotImage.x);
            }

            onReleased: {
                window.sliderMouseUp(window.width/1.20, timelineDotImage.x);
            }


            Image {
                id: timelineDotImage
                width: window.width/30.11
                height: window.width/30.11
                source: "images/MMImages/MMTimeIndicator.png"
                smooth: true

            }
         }



}

Rectangle{          //WEB INTERFACE
    id: webInterface
    opacity: 0
    width: window.width
    height: window.width/20.0
    color: "#a8b3c7"
    anchors.bottom: bottomMenu.top

    MouseArea{
        id: webShowHideMouseArea
        hoverEnabled : true
        anchors.fill: parent
        property int presHover:0
        onHoveredChanged: {
            if(presHover%2==0){
                console.log("TIMER STOPPED");
                showHideTimer.stop();
                showMenus2.running=true;
            }
            else{
                console.log("TIMER STARTED");
                showHideTimer.restart();
            }
            presHover++;
        }
    }

        PropertyAnimation { id: favListReveal; targets: [favsBackgroundImg, favListContent]; property: "opacity"; to: 1; duration: 300 }
        PropertyAnimation { id: favListHide; targets: [favsBackgroundImg, favListContent]; property: "opacity"; to: 0; duration: 300 }

        VisualDataModel {               //TODO: ListElement'ten File system'e gecir
            id: webVisualDataModel
            model: ListModel {
                id: weblistModelSketch
                ListElement { name: "0";  val: "www.googleasdasdasdsadasdasd.com" }
                ListElement { name: "1";  val: "www.moogle.com" }
                ListElement { name: "2";  val: "www.noogle.com" }
                ListElement { name: "3";  val: "www.noonle.com" }
                ListElement { name: "4";  val: "www.moonle.com" }
                ListElement { name: "5";  val: "www.google.com" }
                ListElement { name: "6";  val: "www.moogle.com" }
                ListElement { name: "7";  val: "www.noogle.com" }
                ListElement { name: "8";  val: "www.noonle.com" }
                ListElement { name: "9";  val: "www.moonle.com" }
            }

            delegate: Row {
                id: webFavouritesRow
                spacing: window.width/80.0

                    Flickable {
                        width: window.width/4.26
                        height: window.width/34.13
                        clip: true
                        flickableDirection :Flickable.HorizontalFlick


                        Text{
                            text: val
                            font.family: "Ubuntu"
                            font.pointSize: window.width/80
                            color: "black"
                        }

                    }




                Image{
                    width: window.width/31.03
                    height: window.width/31.03
                    source: "images/webImages/gotoPage.png"

                    visible: true
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            gotoBookmark(val);
                            console.log("Goto "+ val);
                        }
                    }
                }

                Image{
                    width: window.width/31.03
                    height: window.width/31.03
                    source: "images/webImages/deleteFav.png"

                    visible: true
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            deleteBookmarkRequest(val, index);
                            console.log("Remove "+ index);
                        }
                    }
                }

            }

        }

        Image{
            id:favsBackgroundImg
            objectName: "favsBackgroundImg"
            opacity:0
            width: window.width/2.89
            height: window.width/4.76
            source: "images/webImages/favsBackground.png"

            anchors.bottom: webRow.top;
            anchors.bottomMargin: window.width/160
            x: window.width-window.width/2.95
            }

Rectangle{
    id: favListContent
    opacity:0
    height: window.width/5.12
    width: window.width/3.01
    color:"transparent"
    //color:"black"
    anchors.bottom: webRow.top;
    anchors.bottomMargin: window.width/128
    x: window.width-window.width/3.1
        ListView {              // TODO: butonun altina giriyor, bug var
            clip: true
            spacing: window.width/128
            id: webFavListView
            anchors.fill: parent
            model: webVisualDataModel
        }
    }

        Row{
            id: webRow
            spacing: window.width/60.0
            anchors.centerIn: parent;

            PropertyAnimation { id: webLoadingShow; target: webLoadingImg; property: "opacity"; to: 1; duration: 300 }
            PropertyAnimation { id: webLoadingHide; target: webLoadingImg; property: "opacity"; to: 0; duration: 300 }

            Image{

                width: window.width/1.79; height: window.width/26.94   // CALCULATION: width: window.width/ (1024/ImageWidth)
                fillMode: Image.PreserveAspectFit
                smooth: true
                source: "images/webImages/addressbar.png"


                Image{
                    id: webLoadingImg
                    width: 0; height: window.width/26.94
                    smooth: true
                    source: "images/webImages/addressbarloading.png"
                    opacity:1
                }

                TextInput {
                    id: webTextInput
                    anchors.verticalCenter:parent.verticalCenter
                    x: window.width/102
                     text: ""
                     width: window.width/1.9
                     cursorVisible: false
                     font.family: "Ubuntu"
                     font.pointSize: window.width/68
                     color: "black"

                     onAccepted: {
                        gotoURL(webTextInput.text);
                     }

                 }
            }


            Row{

                spacing: window.width/90.0




                Image{
                    width: window.width/26.94; height: window.width/26.94   // CALCULATION: width: window.width/ (1024/ImageWidth)
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    source: "images/webImages/prev.png"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            back();
                            console.log("Web Goto Previous Page");
                        }
                    }
                }

                Image{
                    width: window.width/26.94; height: window.width/26.94   // CALCULATION: width: window.width/ (1024/ImageWidth)
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    source: "images/webImages/next.png"
                    MouseArea {
                        property int a:0
                        anchors.fill: parent
                        onClicked: {
                            next();
                            console.log("Web Goto Next Page");
                        }
                    }
                }

                Image{
                    width: window.width/26.94; height: window.width/26.94   // CALCULATION: width: window.width/ (1024/ImageWidth)
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    source: "images/webImages/refresh.png"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            refresh();
                            console.log("Web Refresh");
                        }
                    }
                }





            }

            Row{

                spacing: window.width/90.0




                Image{
                    width: window.width/26.94; height: window.width/26.94   // CALCULATION: width: window.width/ (1024/ImageWidth)
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    source: "images/webImages/fav.png"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            bookmarkRequest(webTextInput.text);
                            console.log("Web Add to Favourites");
                        }
                    }
                }

                Image{
                    id: webFavImg
                    width: window.width/26.94; height: window.width/26.94   // CALCULATION: width: window.width/ (1024/ImageWidth)
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    source: "images/webImages/favList.png"
                    MouseArea {
                        anchors.fill: parent
                        property int webFavNo: 0
                        onClicked: {

                            webFavNo = webFavNo+1;
                            if (webFavNo%2==0){
                                webFavImg.source = "images/webImages/favList.png";
                                console.log("Web Close Favourites List");
                                //console.log(webFavImg.mapToItem(window,0,0).x);
                                //console.log(webFavImg.mapToItem(window,0,0).y);
                                favListHide.running = true;
                                bookmarkMenuShowHide(false);
                            }

                            if (webFavNo%2==1){
                                webFavImg.source = "images/webImages/favListOn.png"
                                console.log("Web Open Favourites List");
                                favListReveal.running = true;
                                bookmarkMenuShowHide(true);
                            }
                        }
                    }

                }
            }

            Row{

                spacing: window.width/90.0




                Image{
                    id: webAnnoImg
                    width: window.width/26.94; height: window.width/26.94   // CALCULATION: width: window.width/ (1024/ImageWidth)
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    source: "images/webImages/annoon.png"
                    property int webReadOnly: 0
                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            console.log("Web Annotation On-Off");

                            if (webAnnoImg.webReadOnly == 0){
                                webAnnoImg.webReadOnly = 1;
                                webAnnoImg.source = "images/webImages/annooff.png";
                                webAnnotationStatus(true);
                            } else {
                                webAnnoImg.webReadOnly = 0;
                                webAnnoImg.source = "images/webImages/annoon.png"
                                webAnnotationStatus(false);
                            }
                        }
                    }
                }

            }


        }



    }


Rectangle{ // MENU UP
    id: upButtonRect
    objectName: "upButtonRect"
    anchors.bottom: parent.bottom
    anchors.right: parent.right
    color: "transparent"
    opacity: 1
    z:10
    width: window.width/18
    height: window.width*0.04
    Image{
        id: upButtonImg
        opacity: 1
        z:10
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        width: window.width/18.96; height: window.width/24.97    // CALCULATION: width: window.width/ (1024/ImageWidth)
        fillMode: Image.PreserveAspectFit
        smooth: true
        source: "images/mainmenu/up.png"

        MouseArea {
            anchors.fill: parent
            onClicked:{
                menuUpAnimation.running = true
                upButtonDisappearAnimation.running = true
                mainMenuShowHide(true);
            }
        }
    }

}


Row{                //BOTTOM MENU
        id: bottomMenu
        y: window.height
        spacing: window.width/50.0



        Rectangle {      //NOTIFICATION BUTTON
            id: rectNotification
            color: "#edec99";
            width: window.width/17       //TODO: DAHA INCE OLSUN
            height: (width/60)*137
            Image{
                anchors.centerIn: parent
                width: window.width/44.52; height: window.width/11.63    // CALCULATION: width: window.width/ (1024/ImageWidth)
                fillMode: Image.PreserveAspectFit
                smooth: true
                source: "images/mainmenu/notificationOff.png" //TODO: NOTIFICATION ON/OFF
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    notificationsPressed()
                }
            }
        }

        Rectangle {      // RECORD BUTTON
            id: rectRec
            color: "#e199aa";
            width: window.width/17
            height: (width/60)*137
            Image{
                id: recId
                anchors.centerIn: parent
                width: window.width/21.33; height: window.width/19.3    // CALCULATION: width: window.width/ (1024/ImageWidth)
                fillMode: Image.PreserveAspectFit
                smooth: true
                source: "images/mainmenu/recOff.png" //TODO: NOTIFICATION ON/OFF
            }
            MouseArea {
                anchors.fill: parent
                property int recordNo: 0
                onClicked: {
                    recordNo = recordNo+1;
                    if (recordNo%2==1) {
                        recId.source = "images/mainmenu/recOn.png";
                        recordPressed(true);
                    }
                    if (recordNo%2==0) {
                        recId.source = "images/mainmenu/recOff.png";
                        recordPressed(false);
                    }
                }
            }

        }

        Row {           // FUNCTION BUTTONS
            //anchors.bottom: window.bottom
            spacing: 0

            Rectangle {                     // COLLABORATION BUTTON
                id: rectCollaboration
                color: "#de9ce4"
                width: window.width/7.11
                height: (width/144)*137
                Image{
                    anchors.top: rectCollaboration.top
                    anchors.topMargin: window.width/68.2
                    anchors.horizontalCenter: rectCollaboration.horizontalCenter
                    width: window.width/12.8; height: window.width/11.77    // CALCULATION: width: window.width/ (1024/ImageWidth)
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    source: "images/mainmenu/collaboration.png"
                }
                Text{
                    anchors.bottom: rectCollaboration.bottom
                    anchors.horizontalCenter: rectCollaboration.horizontalCenter
                    text: "collaboration"
                    font.family: "Ubuntu"
                    font.pointSize: window.width/68
                    color: "black"
                }

                Image{
                    id: textCollBackgroundCircle
                    visible: false
                    x: window.width/11.37
                    y: window.width/204.8
                    //anchors.horizontalCenter: rectCollaboration.horizontalCenter
                    width: window.width/21.33; height: window.width/19.32    // CALCULATION: width: window.width/ (1024/ImageWidth)
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    source: "images/mainmenu/noBackground.png"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        window.activeFunction = "collaboration"
                        collaborationPressed()
                        //taskManagerPreparation("#de9ce4","#a900bd",0 );
                        //openTaskManager(0);
                        //taskManagerShowHide();
                        //textColl.no=textColl.no+1;
                    }
                }
                Text{
                    id: textColl
                    visible: false
                    anchors.centerIn: textCollBackgroundCircle
                    property int no: 0
                    text: no
                    font.family: "Ubuntu"
                    font.pointSize: window.width/45
                    color: "black"
                }
                Rectangle{
                    id: activeCollaboration
                    visible: false;
                    anchors.bottom: parent.top
                    color: "#a900bd"
                    width: window.width/7.11
                    height: (width/30)
                }

                //DONGERI
            }

            Rectangle {                     // SKETCH BUTTON
                id: rectSketch
                property bool isMenuOn: false
                color: "#f9d299"
                width: window.width/7.11
                height: (width/144)*137
                Image{
                    anchors.top: rectSketch.top
                    anchors.topMargin: window.width/68.2
                    anchors.horizontalCenter: rectSketch.horizontalCenter
                    width: window.width/8.98; height: window.width/14.2;         // CALCULATION: width: window.width/ (1024/ImageWidth)
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    source: "images/mainmenu/sketch.png"
                }
                Text{
                    anchors.bottom: rectSketch.bottom
                    anchors.horizontalCenter: rectSketch.horizontalCenter
                    text: "sketch"
                    font.family: "Ubuntu"
                    font.pointSize: window.width/68
                    color: "black"
                }
                Image{
                    id: textSketchBackgroundCircle
                    visible: false
                    x: window.width/11.37
                    y: window.width/204.8
                    //anchors.horizontalCenter: rectCollaboration.horizontalCenter
                    width: window.width/21.33; height: window.width/19.32    // CALCULATION: width: window.width/ (1024/ImageWidth)
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    source: "images/mainmenu/noBackground.png"
                }
                MouseArea {
                    id: sketchButtonMouseArea
                    anchors.fill: parent


                    onClicked: {
                        sketchPressed();
                        taskManagerPreparation("#f9d299","#f18e00",1 );
                        taskManagerShowHide();
                        openTaskManager(1);
                    }
                }


                Text{
                    id: textSketch
                    visible: false
                    anchors.centerIn: textSketchBackgroundCircle
                    property int no: 0
                    text: no
                    font.family: "Ubuntu"
                    font.pointSize: window.width/45
                    color: "black"
                }
                Rectangle{
                    id: activeSketch
                    visible: false;
                    anchors.bottom: parent.top
                    color: "#f18e00"
                    width: window.width/7.11
                    height: (width/30)
                }

            }

            Rectangle {                     // PRESENTATION BUTTON
                id: rectPres
                z: -1
                color: "#dbdea7"
                width: window.width/7.11
                height: (width/144)*137
                Image{
                    anchors.top: rectPres.top
                    anchors.topMargin: window.width/68.2
                    anchors.horizontalCenter: rectPres.horizontalCenter
                    width: window.width/11.5; height: window.width/11.63;         // CALCULATION: width: window.width/ (1024/ImageWidth)
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    source: "images/mainmenu/presentation.png"
                }
                Text{
                    anchors.bottom: rectPres.bottom
                    anchors.horizontalCenter: rectPres.horizontalCenter
                    text: "presentation"
                    font.family: "Ubuntu"
                    font.pointSize: window.width/68
                    color: "black"
                }
                Image{
                    id: textPresBackgroundCircle
                    visible: false
                    x: window.width/11.37
                    y: window.width/204.8
                    //anchors.horizontalCenter: rectCollaboration.horizontalCenter
                    width: window.width/21.33; height: window.width/19.32    // CALCULATION: width: window.width/ (1024/ImageWidth)
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    source: "images/mainmenu/noBackground.png"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {                        
                        presentationPressed();
                        taskManagerPreparation("#dbdea5","#a8ad25",2 );
                        openTaskManager(2);
                        taskManagerShowHide();
                    }
                }
                Text{
                    id: textPres
                    visible: false
                    anchors.centerIn: textPresBackgroundCircle
                    property int no: 0
                    text: no
                    font.family: "Ubuntu"
                    font.pointSize: window.width/45
                    color: "black"
                }
                Rectangle{
                    id: activePresentation
                    visible: false;
                    anchors.bottom: parent.top
                    color: "#a8ad25"
                    width: window.width/7.11
                    height: (width/30)
                }
            }

            Rectangle {                     // WEB BUTTON
                id: rectWeb
                color: "#a8b3c7"
                width: window.width/7.11
                height: (width/144)*137
                Image{
                    anchors.top: rectWeb.top
                    anchors.topMargin: window.width/68.2
                    anchors.horizontalCenter: rectWeb.horizontalCenter
                    width: window.width/11.63; height: window.width/11.5;         // CALCULATION: width: window.width/ (1024/ImageWidth)
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    source: "images/mainmenu/web.png"
                }
                Text{
                    anchors.bottom: rectWeb.bottom
                    anchors.horizontalCenter: rectWeb.horizontalCenter
                    text: "web"
                    font.family: "Ubuntu"
                    font.pointSize: window.width/68
                    color: "black"
                }
                Image{
                    id: textWebBackgroundCircle
                    visible: false
                    x: window.width/11.37
                    y: window.width/204.8
                    //anchors.horizontalCenter: rectCollaboration.horizontalCenter
                    width: window.width/21.33; height: window.width/19.32    // CALCULATION: width: window.width/ (1024/ImageWidth)
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    source: "images/mainmenu/noBackground.png"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        webPressed()
                        taskManagerPreparation("#a8b3c7","#254273",3 );
                        openTaskManager(3);
                        taskManagerShowHide();
                    }
                }
                Text{
                    id: textWeb
                    visible: false
                    anchors.centerIn: textWebBackgroundCircle
                    property int no: 0
                    text: no
                    font.family: "Ubuntu"
                    font.pointSize: window.width/45
                    color: "black"
                }
                Rectangle{
                    id: activeWeb
                    visible: false;
                    anchors.bottom: parent.top
                    color: "#254273"
                    width: window.width/7.11
                    height: (width/30)
                }
            }

            Rectangle {                     // MULTIMEDIA BUTTON
                id: rectMM
                color: "#a3d6d9"
                width: window.width/7.11
                height: (width/144)*137
                Image{
                    anchors.top: rectMM.top
                    anchors.topMargin: window.width/68.2
                    anchors.horizontalCenter: rectMM.horizontalCenter
                    width: window.width/11.77; height: window.width/12.19;         // CALCULATION: width: window.width/ (1024/ImageWidth)
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    source: "images/mainmenu/multimedia.png"
                }
                Text{
                    anchors.bottom: rectMM.bottom
                    anchors.horizontalCenter: rectMM.horizontalCenter
                    text: "multimedia"
                    font.family: "Ubuntu"
                    font.pointSize: window.width/68
                    color: "black"
                }
                Image{
                    id: textMMBackgroundCircle
                    visible: false
                    x: window.width/11.37
                    y: window.width/204.8
                    //anchors.horizontalCenter: rectCollaboration.horizontalCenter
                    width: window.width/21.33; height: window.width/19.32    // CALCULATION: width: window.width/ (1024/ImageWidth)
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    source: "images/mainmenu/noBackground.png"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        multimediaPressed();
                        taskManagerPreparation("#a2d6d8","#17989d",4 );
                        openTaskManager(4);
                        taskManagerShowHide();
                    }
                }
                Text{
                    id: textMM
                    visible: false
                    anchors.centerIn: textMMBackgroundCircle
                    property int no: 0
                    text: no
                    font.family: "Ubuntu"
                    font.pointSize: window.width/45
                    color: "black"
                }
                Rectangle{
                    id: activeMultimedia
                    visible: false;
                    anchors.bottom: parent.top
                    color: "#17989d"
                    width: window.width/7.11
                    height: (width/30)
                }

            }

        }





        Rectangle {     // MENU DOWN
            id: menuUpDown
            color: "#bc9e7e"
            width: window.width/23
            height: window.width*0.134

            Image{
                anchors.centerIn: parent
                width: window.width/26.94; height: window.width/15.05    // CALCULATION: width: window.width/ (1024/ImageWidth)
                fillMode: Image.PreserveAspectFit
                smooth: true
                source: "images/mainmenu/down.png"
            }


            PropertyAnimation { id: menuDownAnimation; target: bottomMenu; property: "y"; to: window.height; duration: 250
                onCompleted: {
                    mainMenuShowHide(false);
                }
            }
            PropertyAnimation { id: menuUpAnimation; target: bottomMenu; property: "y"; to: window.height - bottomMenu.height; duration: 250 }

            PropertyAnimation { id: upButtonAppearAnimation; target: upButtonImg; property: "opacity"; to: 0.8; duration: 250 }
            PropertyAnimation { id: upButtonDisappearAnimation; target: upButtonImg; property: "opacity"; to: 0; duration: 250 }

            MouseArea {
                anchors.fill: parent
                onClicked:{         //TODO: button acilimlari kapanacak + - ler gibi
                    menuDownAnimation.running = true
                    upButtonAppearAnimation.running = true
                }
            }


            /*Rectangle{
            id: activeUpDown
                visible: false;
                anchors.bottom: parent.top
                color: "#342323"
                width: window.width/17
                height: (width/13)
           }*/
        }

        Rectangle {
            id: rectLast
            color: "transparent";
            width: window.width/23
            height: window.width*0.134

            Rectangle{
                id: rectExit
                color: "#f9bdbd";
                width: window.width/23
                height: window.width*0.067
                anchors.bottom: rectLast.bottom
                Image{
                    anchors.centerIn: parent
                    width: window.width/26.94; height: window.width/26.94    // CALCULATION: width: window.width/ (1024/ImageWidth)
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    source: "images/mainmenu/exit2.png"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        exitPressed()
                    }
                }

            }


            Rectangle{
                color: "#e6e8c2";
                width: window.width/23
                height: window.width*0.067
                anchors.bottom: rectExit.top
                Image{
                    id: fullscreenImg
                    anchors.centerIn: parent
                    width: window.width/26.94; height: window.width/26.94    // CALCULATION: width: window.width/ (1024/ImageWidth)
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    source: "images/mainmenu/fullscreenOff.png"
                    property bool fullscreenActive: true
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if(!fullscreenImg.fullscreenActive)
                                fullscreenImg.source = "images/mainmenu/fullscreenOff.png";
                        else
                                fullscreenImg.source = "images/mainmenu/fullscreenOn.png";
                                fullscreenImg.fullscreenActive = !fullscreenImg.fullscreenActive;
                        fullscreenStateChange();
                    }
                }

            }
        }

    }

MouseArea {
        anchors.fill: parent
        id: globalMouseArea
        z: -1
        acceptedButtons: Qt.LeftButton | Qt.RightButton


        onPressed: {
            mousePressed(mouseX, mouseY, mouse.button, mouse.buttons);
        }

        onMousePositionChanged: {
            mouseMoved(mouseX, mouseY, mouse.button, mouse.buttons);
        }

        onReleased:  {
            mouseReleased(mouseX, mouseY, mouse.button, mouse.buttons);
        }
    }

}

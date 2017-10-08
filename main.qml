import QtQuick 2.5
import QtQuick.Window 2.2
import QtMultimedia 5.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Accelerometer")
    color: "black"



    MouseArea {
        anchors.fill: parent
        onClicked: {
            Qt.quit();
        }
    }

    function getAccelData()
    {
        if(((root.ax + width/30) > ((root.width/2) + (root.width/4))) ||
                ((root.ax - width/30) < ((root.width/2) - (root.width/4))))
        {
            root.dx = -root.dx;
        }
        root.ax += (Math.floor(Math.random()+1) * root.dx);
//        console.log(root.ax)
        if(root.ax >= 319 && root.ax <= 321)
        {
            root.acclColor = "green"
            root.outColor = "green"
            root.hide = true;
        }
        else
        {
            root.acclColor = "red"
            root.outColor = "grey"
            root.hide = false;
        }
    }

    Item {
        id: root
        property color acclColor: "red"
        property color outColor: "grey"
        property alias ax:canvas.acclX
        property alias ay:canvas.acclY
        property int dx: 1
        property bool hide: canvas.hideCentre
        anchors.fill: parent


        Canvas {
          id:canvas
          width: parent.width
          height: parent.height
          property int acclX: width/2
          property int acclY: height/2
          property bool hideCentre: false

          onAcclXChanged: requestPaint()

          onPaint:{
             var ctx = canvas.getContext('2d');
             ctx.reset();

             var centreX = width / 2;
             var centreY = height / 2;

              //the big grey circle
             ctx.beginPath();
             ctx.strokeStyle = root.outColor;
             ctx.lineWidth = 2;
             ctx.arc(centreX, centreY, width / 4, 0, Math.PI * 2, false);
             ctx.stroke();

              //the small inner circle
              if(!hideCentre)
              {
                  ctx.beginPath();
                  ctx.strokeStyle = "grey";
                  ctx.lineWidth = 3;
                  ctx.arc(centreX, centreY, width / 110, 0, Math.PI * 2, false);
                  ctx.stroke();
              }

              //the accl position circle
              ctx.beginPath();
              ctx.strokeStyle = root.acclColor;
              ctx.lineWidth = 5;
//              ctx.arc(root.acclX, root.acclY, width / 30, 0, Math.PI * 2, false);
              ctx.arc(canvas.acclX, centreY, width / 30, 0, Math.PI * 2, false);
              ctx.stroke();
          }



        }

        Timer
        {
            id: timer
            interval: 5
            running: true
            repeat: true
            onTriggered:
            {
                getAccelData()

            }
        }

    }
}




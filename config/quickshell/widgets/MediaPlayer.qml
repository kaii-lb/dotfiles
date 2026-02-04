import "root:/config"
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Mpris

WrapperRectangle {
    id: root
    required property var activePlayer
    property double length: activePlayer.length
    property double position: activePlayer.position
    property list<string> longTitle: activePlayer.desktopEntry.split('.')

    implicitHeight: activePlayer != null ? 230 : -40
    visible: activePlayer != null
    Layout.fillWidth: true
    
    color: Appearance.colors.surfacePressed
    radius: Appearance.radii.large

    WrapperItem {
        margin: 12
        
        ColumnLayout {
            RowLayout {
                spacing: Appearance.spacing.xLarge
                Layout.alignment: Qt.AlignTop
                
                ClippingRectangle {
                    radius: Appearance.radii.large - 12
                    height: 128
                    width: 128

                    Image {
                        source: activePlayer.trackArtUrl
                        width: parent.width
                        height: parent.width
                        sourceSize.width: 256
                        sourceSize.height: 256
                        fillMode: Image.PreserveAspectCrop
                    }
                }

                WrapperItem {
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignVCenter
                    implicitWidth: 50
                    
                    ColumnLayout {
                        spacing: 1
                        implicitWidth: 150

                        Item {
                            height: titleText.height
                            width: titleText.width

                            Text {
                                id: titleText
                                text: activePlayer.trackTitle
                                color: Appearance.colors.text

                                font.pointSize: 16
                                font.weight: Font.Bold

                                width: 200
                                elide: Text.ElideRight
                            }
                        }

                        Item {
                            height: titleText.height
                            width: titleText.width
                        
                            Text {
                                text: activePlayer.trackArtist
                                color: Appearance.colors.textDim
                                
                                font.pointSize: 13
                                width: 200
                                elide: Text.ElideRight
                            }
                        }
                    }
                }

                WrapperRectangle {
                    Layout.alignment: Qt.AlignTop + Qt.AlignRight
                    color: Appearance.colors.primary
                    topMargin: 4
                    leftMargin: 8
                    bottomMargin: 4
                    rightMargin: 8
                    radius: Appearance.radii.full

                    Text {
                        id: mediaPlayerTitle
                        text: longTitle[longTitle.length - 1]
                        color: Appearance.colors.primaryText
                        
                        font.pointSize: 12
                        font.weight: Font.Bold
                        horizontalAlignment: Text.AlignRight
                    }
                }
            }

            RowLayout {
                spacing: 8

                Timer {
                    running: activePlayer.playbackState == MprisPlaybackState.Playing
                    
                    interval: 1000
                    repeat: true
                    
                    onTriggered: {
                        root.position = activePlayer.position

                        var date = new Date(0);
                        date.setSeconds(activePlayer.position);
                        var formattedTime = date.toLocaleTimeString(Qt.locale(), "mm:ss")
                        currentPosition.text = formattedTime
                    }
                }

                Text {
                    id: currentPosition
                    text: {
                        var date = new Date(0);
                        date.setSeconds(activePlayer.position);
                        date.toLocaleTimeString(Qt.locale(), "mm:ss")
                    }
                    color: Appearance.colors.textDim

                    Layout.minimumWidth: 50
                }

                Slider {
                    id: control
                    from: 0
                    to: root.length

                    value: root.position

                    Layout.fillWidth: true
                    implicitHeight: 16

                    onMoved: {
                        if (activePlayer.canSeek) {
                            var offset = value - root.position
                            activePlayer.seek(offset)
                        }
                    }

                    background: Rectangle {
                        x: control.leftPadding
                        y: control.topPadding + control.availableHeight / 2 - height / 2
                        implicitWidth: 200
                        implicitHeight: control.availableHeight


                        width: control.availableWidth
                        radius: Appearance.radii.full
                        color: Appearance.colors.surfaceDark

                        Rectangle {
                            width: control.visualPosition * parent.width
                            height: parent.height
                            color: Appearance.colors.primary
                            radius: Appearance.radii.full
                        }
                    }

                    handle: Rectangle {
                        implicitWidth: 0
                        implicitHeight: 0
                        color: "transparent"
                        border.color: "transparent"
                    }
                }

                Timer {
                    running: activePlayer.playbackState == MprisPlaybackState.Playing
                    
                    interval: 1000
                    repeat: true
                    
                    onTriggered: {
                        root.length = activePlayer.length

                        var date = new Date(0);
                        date.setSeconds(activePlayer.length);
                        var formattedTime = date.toLocaleTimeString(Qt.locale(), "mm:ss")
                        currentLength.text = formattedTime
                    }
                }

                Text {
                    id: currentLength
                    text: {
                        var date = new Date(0);
                        date.setSeconds(activePlayer.length);
                        date.toLocaleTimeString(Qt.locale(), "mm:ss")
                    }
                    color: Appearance.colors.textDim
                    horizontalAlignment: Text.AlignRight

                    Layout.minimumWidth: 50
                }
            }

            WrapperItem {
                topMargin: 8
                Layout.alignment: Qt.AlignHCenter
                
                RowLayout {
                    spacing: 8

                    Button {
                        id: skipBackButton
                        icon.source: "/home/kaii/.config/quickshell/assets/skip_backwards.svg"
                        icon.color: Appearance.colors.primaryText
                        icon.width: 20
                        icon.height: 20

                        onClicked: activePlayer.previous()

                        background: Rectangle {
                            implicitWidth: 24
                            implicitHeight: 24
                            color: skipBackButton.down ? Appearance.colors.primaryPressed : Appearance.colors.primary
                            radius: Appearance.radii.large
                        }

                        HoverHandler {
                            cursorShape: Qt.PointingHandCursor // Set the cursor shape when hovering
                        }
                    }

                    Button {
                        id: playPauseButton
                        icon.source: activePlayer.isPlaying ? "/home/kaii/.config/quickshell/assets/pause.svg" : "/home/kaii/.config/quickshell/assets/play.svg"
                        icon.color: Appearance.colors.primaryText
                        icon.width: 20
                        icon.height: 20

                        onClicked: activePlayer.togglePlaying()

                        background: Rectangle {
                            implicitWidth: 24
                            implicitHeight: 24
                            color: playPauseButton.down ? Appearance.colors.primaryPressed : Appearance.colors.primary
                            radius: Appearance.radii.large
                        }

                        HoverHandler {
                            cursorShape: Qt.PointingHandCursor // Set the cursor shape when hovering
                        }
                    }

                    Button {
                        id: skipForwardButton
                        icon.source: "/home/kaii/.config/quickshell/assets/skip_forwards.svg"
                        icon.color: Appearance.colors.primaryText
                        icon.width: 20
                        icon.height: 20

                        onClicked: activePlayer.next()

                        background: Rectangle {
                            implicitWidth: 24
                            implicitHeight: 24
                            color: skipForwardButton.down ? Appearance.colors.primaryPressed : Appearance.colors.primary
                            radius: Appearance.radii.large
                        }

                        HoverHandler {
                            cursorShape: Qt.PointingHandCursor // Set the cursor shape when hovering
                        }
                    }
                }
            }
        }
    }
}
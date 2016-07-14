/*
 *   Copyright (C) 2012 Aleix Pol Gonzalez <aleixpol@blue-systems.com>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library/Lesser General Public License
 *   version 2, or (at your option) any later version, as published by the
 *   Free Software Foundation
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU Library/Lesser General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 2.1
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1
import org.kde.kquickcontrolsaddons 2.0
import org.kde.discover.app 1.0
import QtQuick.Window 2.1
import org.kde.kcoreaddons 1.0
import "navigation.js" as Navigation
import org.kde.kirigami 1.0 as Kirigami

Kirigami.AbstractListItem
{
    id: delegateArea
    readonly property real contHeight: height*0.8

    onClicked: {
        view.currentIndex = index
        Navigation.openApplication(application)
    }

    RowLayout {
        id: lowLayout
        anchors {
            leftMargin: 2
            left: parent.left
            right: parent.right
        }

        QIconItem {
            id: resourceIcon
            icon: model.icon
            Layout.minimumWidth: contHeight
            Layout.minimumHeight: contHeight
            anchors.verticalCenter: parent.verticalCenter
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Item { height: 3; width: 3 }

            Label {
                Layout.fillWidth: true
                elide: Text.ElideRight
                text: name
            }
            Label {
                Layout.fillWidth: true

                elide: Text.ElideRight
                text: comment
                font.italic: true
                opacity: !Helpers.isCompact && delegateArea.containsMouse ? 1 : 0.5
                maximumLineCount: 1
                clip: true
            }

            Item { height: 3; width: 3 }
        }

        Item {
            Layout.fillHeight: true
            width: Helpers.isCompact ? installInfo.width : Math.max(installInfo.width, installButton.width)

            InstallApplicationButton {
                id: installButton
                anchors.verticalCenter: parent.verticalCenter
                application: model.application
                canUpgrade: false
                visible: !Helpers.isCompact && delegateArea.containsMouse
            }
            LabelBackground {
                progressing: installButton.isActive
                progress: installButton.progress/100

                id: installInfo
                anchors.centerIn: parent
                visible: Helpers.isCompact || !delegateArea.containsMouse
                text: Format.formatByteSize(size)
            }
        }

        ApplicationIndicator {
            id: indicator
            width: 5
            height: parent.height
            anchors.right: parent.right
        }
    }
}
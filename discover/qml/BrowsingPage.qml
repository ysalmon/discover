/*
 *   Copyright (C) 2015 Aleix Pol Gonzalez <aleixpol@blue-systems.com>
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

import QtQuick 2.4
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.1
import org.kde.discover 2.0
import org.kde.discover.app 1.0
import "navigation.js" as Navigation
import org.kde.kirigami 2.12 as Kirigami

DiscoverPage
{
    id: page
    title: i18n("Featured")
    leftPadding: 0
    rightPadding: 0
    topPadding: 0
    bottomPadding: 0

    readonly property bool isHome: true

    function searchFor(text) {
        if (text.length === 0)
            return;
        Navigation.openCategory(null, "")
    }

    ColumnLayout {
        anchors.centerIn: parent
        opacity: 0.5

        visible: apps.count === 0 && apps.model.isFetching

        Kirigami.Heading {
            level: 2
            Layout.alignment: Qt.AlignCenter
            text: i18n("Loading...")
        }
        BusyIndicator {
            id: indicator
            Layout.alignment: Qt.AlignCenter
            Layout.preferredWidth: Kirigami.Units.gridUnit * 4
            Layout.preferredHeight: Kirigami.Units.gridUnit * 4
        }
    }

    Kirigami.PlaceholderMessage {
        anchors.centerIn: parent
        width: parent.width - (Kirigami.Units.largeSpacing * 4)

        visible: apps.count === 0 && !apps.model.isFetching

        icon.name: "network-disconnect"
        text: xi18nc("@info", "Unable to load applications.<nl/>Please verify Internet connectivity.")
    }

    signal clearSearch()

    readonly property bool compact: page.width < 550 || !applicationWindow().wideScreen

    Kirigami.CardsListView {
        id: apps
        model: FeaturedModel {}
        currentIndex: -1
        delegate: ApplicationDelegate {
            application: model.application
            compact: page.compact
        }
    }
}

/*
 *   Copyright (C) 2020 Aleix Pol Gonzalez <aleixpol@kde.org>
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

#ifndef DISCOVERUPDATE_H
#define DISCOVERUPDATE_H

#include <QObject>
#include <QUrl>
#include <QSet>

#include <Transaction/Transaction.h>

class AbstractResource;
class ResourcesUpdatesModel;

class DiscoverUpdate : public QObject
{
    Q_OBJECT
    public:
        explicit DiscoverUpdate();
        ~DiscoverUpdate() override;

    private:
        void start();
        void transactionStatusChanged(Transaction::Status status);

        ResourcesUpdatesModel* const m_resourcesUpdatesModel;
        bool m_done = false;
};

#endif // DISCOVERUPDATE_H

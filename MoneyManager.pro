# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = MoneyManager

CONFIG += sailfishapp

SOURCES += src/MoneyManager.cpp

DISTFILES += qml/MoneyManager.qml \
    qml/cover/CoverPage.qml \
    qml/database.js \
    qml/database.py \
    qml/database_2024_08_19.js \
    qml/pages/DatePickerPage.qml \
    qml/pages/FirstPage.qml \
    qml/server.py \
    rpm/MoneyManager.changes.in \
    rpm/MoneyManager.changes.run.in \
    rpm/MoneyManager.spec \
    translations/*.ts \
    MoneyManager.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 172x172

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/MoneyManager-de.ts

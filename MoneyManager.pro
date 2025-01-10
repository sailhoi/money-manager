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

SUBDIRS += localstorage

SOURCES += src/MoneyManager.cpp \
    src/incomecategory.cpp

DISTFILES += qml/MoneyManager.qml \
    Database.js \
    qml/Accounts_Type_db.js \
    qml/Accounts_db.js \
    qml/Categories_Expenses_db.js \
    qml/Currencies_db.js \
    qml/JS/AccountTypes_db.js \
    qml/Setting_db.js \
    qml/Transations_Expenses_db.js \
    qml/Transations_Income_db.js \
    qml/Transations_Transfer_db.js \
    qml/cover/CoverPage.qml \
    qml/pages/AccountsPage.qml \
    qml/pages/EditAccountPage.qml \
    qml/pages/EditAccountTypePage.qml \
    qml/pages/EditTransationPage.qml \
    qml/pages/Expense_CategoriesPage.qml \
    qml/pages/Expense_CategoryPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/IncomeCategoriesPage.qml \
    qml/pages/IncomeCategoryPage.qml \
    qml/pages/ResetDatabasePage.qml \
    qml/pages/SettingPage.qml \
    qml/pages/account/AccountTypesPage.qml \
    qml/pages/currency/CurrenciesPage.qml \
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

HEADERS += \
    src/incomecategory.h

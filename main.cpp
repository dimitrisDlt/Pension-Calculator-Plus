#include <QApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    qputenv("QSG_RHI_BACKEND", "opengl");
    QApplication app(argc, argv);
    app.setOrganizationName("Dimitris Dlt");
    app.setOrganizationDomain("nomikipleusi.gr");
    app.setApplicationName("Pension Calculator Plus");

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("simplecrud", "Main");

    return app.exec();
}

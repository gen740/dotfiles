#include <QtWidgets/QApplication>
#include <QtWidgets/QStackedLayout>
#include <QLabel>
#include <QCheckBox>
#include <QtCharts/QtCharts>


int main(int argc, char *argv[]) {
    QApplication app(argc, argv);
    QWidget *window = new QWidget;

    QLabel *label = new QLabel("Hello World!");
    QCheckBox *checkbox = new QCheckBox("C&ase sensitive");

    QVBoxLayout *layout = new QVBoxLayout(window);

    label->setObjectName("test");
    layout->addWidget(label);
    layout->addWidget(checkbox);

    window->show();
    window->setStyleSheet("QLabel#est {background-color: yellow}");

    return app.exec();
}

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami
import org.kde.kcmutils as KCM
import org.kde.kquickcontrols as KQuickControls

KCM.SimpleKCM {
    id: configRoot

    property alias cfg_isEnabled: enabledCheck.checked
    property alias cfg_backgroundColor: colorButton.color
    property alias cfg_backgroundOpacity: opacitySlider.value

    Kirigami.FormLayout {
        id: formLayout

        QQC2.CheckBox {
            id: enabledCheck
            Kirigami.FormData.label: i18n("Panel Customization:")
            text: i18n("Enable")
        }

        RowLayout {
            Kirigami.FormData.label: i18n("Background Color:")
            KQuickControls.ColorButton {
                id: colorButton
                showAlphaChannel: true
            }
        }

        QQC2.Slider {
            id: opacitySlider
            Kirigami.FormData.label: i18n("Background Opacity:")
            from: 0.0
            to: 1.0
            stepSize: 0.05
        }
    }
}

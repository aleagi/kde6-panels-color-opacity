import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore

PlasmoidItem {
    id: root

    property bool isEnabled: Plasmoid.configuration.isEnabled
    property color bgColor: Plasmoid.configuration.backgroundColor
    property real bgOpacity: Plasmoid.configuration.backgroundOpacity

    Plasmoid.backgroundHints: PlasmaCore.Types.NoBackground
    
    // Only show icon in edit mode
    property bool editMode: Plasmoid.containment.corona?.editMode ?? false

    // Size only > 0 when in edit mode so it normally takes 0 pixel space.
    Layout.preferredWidth: editMode ? 24 : 0
    Layout.preferredHeight: editMode ? 24 : 0
    Layout.minimumWidth: editMode ? 24 : 0
    Layout.minimumHeight: editMode ? 24 : 0
    
    // Fallback if not using a layout
    width: editMode ? 24 : 0
    height: editMode ? 24 : 0
    
    Image {
        anchors.fill: parent
        source: Qt.resolvedUrl("../images/icon.svg")
        visible: root.editMode
        sourceSize.width: 24
        sourceSize.height: 24
    }

    property var containmentItem: {
        let candidate = root.parent;
        while (candidate) {
            if (candidate.toString().indexOf("ContainmentItem_QML") > -1) {
                return candidate;
            }
            candidate = candidate.parent;
        }
        return null;
    }

    onContainmentItemChanged: {
        updateContainmentBackground();
    }
    
    onIsEnabledChanged: {
        updateContainmentBackground();
    }

    function updateContainmentBackground() {
        if (!containmentItem) return;
        containmentItem.Plasmoid.backgroundHints = isEnabled
            ? PlasmaCore.Types.NoBackground
            : PlasmaCore.Types.DefaultBackground;
    }

    property Item panelLayout: {
        let candidate = root.parent;
        while (candidate) {
            if (candidate instanceof GridLayout) {
                return candidate;
            }
            candidate = candidate.parent;
        }
        return null;
    }

    property Item panelLayoutContainer: {
        if (!panelLayout) return null;
        return panelLayout.parent;
    }

    property Item panelBg: {
        if (!panelLayoutContainer) return null;
        return panelLayoutContainer.parent;
    }

    Component {
        id: bgComponent
        Rectangle {
            id: bgRect
            color: root.bgColor
            opacity: root.bgOpacity
            visible: root.isEnabled

            anchors.fill: parent
            z: -1
        }
    }

    property var customBgObj: null

    onPanelBgChanged: {
        if (panelBg && !customBgObj) {
            customBgObj = bgComponent.createObject(panelBg);
        }
    }

    Component.onCompleted: {
        updateContainmentBackground();
    }

    Component.onDestruction: {
        if (customBgObj) customBgObj.destroy();
        if (containmentItem) containmentItem.Plasmoid.backgroundHints = PlasmaCore.Types.DefaultBackground;
    }
}

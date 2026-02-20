import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore

PlasmoidItem {
    id: root

    property bool isEnabled: Plasmoid.configuration.isEnabled
    property color bgColor: Plasmoid.configuration.backgroundColor
    property real bgOpacity: Plasmoid.configuration.backgroundOpacity
    property bool blurEnabled: Plasmoid.configuration.blurEnabled
    property real blurAmount: Plasmoid.configuration.blurAmount

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

    onBlurEnabledChanged: {
        updateContainmentBackground();
    }

    function updateContainmentBackground() {
        if (!containmentItem) return;
        
        if (!isEnabled) {
            containmentItem.Plasmoid.backgroundHints = PlasmaCore.Types.DefaultBackground;
            return;
        }

        // To have blur in Plasma 6, we usually need TranslucentBackground.
        // If we use NoBackground, we lose the compositor-side blur.
        containmentItem.Plasmoid.backgroundHints = blurEnabled
            ? PlasmaCore.Types.TranslucentBackground
            : PlasmaCore.Types.NoBackground;
        
        // Try to find and hide the original background SVG if blur is enabled
        // so only our custom rectangle (and the system blur) is visible.
        if (panelBg) {
            panelBg.visible = !blurEnabled;
        }
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
            // If blur is enabled, we multiply by blurAmount to simulate intensity
            opacity: root.blurEnabled ? root.bgOpacity * (0.5 + root.blurAmount * 0.5) : root.bgOpacity
            visible: root.isEnabled

            anchors.fill: parent
            z: -1
        }
    }

    property var customBgObj: null

    onPanelBgChanged: {
        if (panelBg && !customBgObj) {
            // Parent to panelBg's parent so we can hide panelBg without hiding our custom rect
            customBgObj = bgComponent.createObject(panelBg.parent);
            customBgObj.anchors.fill = panelBg;
            updateContainmentBackground();
        }
    }

    Component.onCompleted: {
        updateContainmentBackground();
    }

    Component.onDestruction: {
        if (customBgObj) customBgObj.destroy();
        if (containmentItem) {
            containmentItem.Plasmoid.backgroundHints = PlasmaCore.Types.DefaultBackground;
            if (panelBg) panelBg.visible = true;
        }
    }
}

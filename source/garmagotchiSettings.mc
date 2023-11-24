import Toybox.WatchUi;
using Toybox.Application.Storage;

class GarmagotchiSettings extends WatchUi.Menu2 {
  function initialize() {
    Menu2.initialize(null);
    Menu2.setTitle("Settings");
    Menu2.addItem(
      new MenuItem(
        "Switch Character",
        "Current: " + Storage.getValue("garmagotchiCharacter"),
        "switchCharacter",
        {}
      )
    );
  }
}

class GarmagotchiSettingsDelegate extends WatchUi.Menu2InputDelegate {
  function initialize() {
    Menu2InputDelegate.initialize();
  }

  function onSelect(item) {
    var id = item.getId();
    if (id.equals("switchCharacter")) {
      var switchCharacterMenu = new SwitchCharacterMenu();
      var delegate = new SwitchCharacterMenuDelegate();
      WatchUi.pushView(switchCharacterMenu, delegate, WatchUi.SLIDE_IMMEDIATE);
    }
  }

  function onBack() {
    WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
  }
}

class SwitchCharacterMenu extends WatchUi.Menu2 {
  function initialize() {
    Menu2.initialize(null);
    Menu2.setTitle("Switch Character");
    Menu2.addItem(new MenuItem("Red Panda", "", "redPanda", {}));
    Menu2.addItem(new MenuItem("Axolotl", "", "axolotl", {}));
    Menu2.addItem(new MenuItem("Penguin", "", "penguin", {}));
  }
}

class SwitchCharacterMenuDelegate extends WatchUi.Menu2InputDelegate {
  function initialize() {
    Menu2InputDelegate.initialize();
  }

  function onSelect(item) {
    var id = item.getId();
    Storage.setValue("garmagotchiCharacter", id);
    onBack();
  }

  function onBack() {
    WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
  }
}

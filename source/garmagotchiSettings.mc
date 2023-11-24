import Toybox.WatchUi;
using Toybox.Application.Storage;

class GarmagotchiSettings extends WatchUi.Menu2 {
  function initialize() {
    Menu2.initialize(null);
    Menu2.setTitle("Switch Character");
    Menu2.addItem(new MenuItem("Red Panda", "", "redPanda", {}));
    Menu2.addItem(new MenuItem("Axolotl", "", "axolotl", {}));
    Menu2.addItem(new MenuItem("Penguin", "", "penguin", {}));
    Menu2.addItem(new MenuItem("Me", "", "me", {}));
  }
}

class GarmagotchiSettingsDelegate extends WatchUi.Menu2InputDelegate {
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

import Toybox.WatchUi;
using Toybox.Application.Storage;

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

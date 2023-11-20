import Toybox.WatchUi;

class GarmagotchiSettings extends WatchUi.Menu2 {
  function initialize() {
    Menu2.initialize(null);
    Menu2.setTitle("Settings");
    Menu2.addItem(
      new MenuItem("Switch Character", "Red Panda", "redPanda", {})
    );
    Menu2.addItem(new MenuItem("Switch Character", "Axolotl", "axolotl", {}));
    Menu2.addItem(new MenuItem("Switch Character", "Penguin", "penguin", {}));
    Menu2.addItem(new MenuItem("Switch Character", "Walker", "walker", {}));
    Menu2.addItem(new MenuItem("Switch Character", "Ashley", "ashley", {}));
    //other things
  }
}

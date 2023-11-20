import Toybox.WatchUi;

class garmagotchiSettings extends WatchUi.Menu2 {
  function initialize() {
    Menu2.initialize(null);
    Menu2.setTitle("Settings");
    Menu2.addItem(
      new MenuItem("Switch Character", "Red Panda", "redPanda", {})
    );
    Menu2.addItem(new MenuItem("Switch Character", "Axolotyl", "axolotyl", {}));
    Menu2.addItem(new MenuItem("Switch Character", "Penguin", "penguin", {}));
    //other things
  }
}

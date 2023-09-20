import Toybox.Application;
import Toybox.WatchUi;
import Toybox.Graphics;

class BitmapAsset {
  private var image as Graphics.BitmapReference;
  
  function initialize(chosenCharacter as Character, ashleyAsset, walkerAsset) {
    switch (chosenCharacter.name) {
      case "Walker":
        self.image = Application.loadResource(walkerAsset);
        break;
      case "Ashley":
        self.image = Application.loadResource(ashleyAsset);
        break;
      default:
        self.image = Application.loadResource(ashleyAsset);
    }
  }

  function draw(dc as Dc) {
    var screenWidth = dc.getWidth();
    var screenHeight = dc.getHeight();
    dc.drawBitmap(
      screenWidth / 2 - self.image.getWidth() / 2,
      screenHeight - self.image.getHeight(),
      self.image
    );
  }
}

import Toybox.Application;
import Toybox.WatchUi;
import Toybox.Graphics;

class BitmapAsset {
  private var image as Graphics.BitmapReference;

  function initialize(asset) {
    self.image = Application.loadResource(asset);
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

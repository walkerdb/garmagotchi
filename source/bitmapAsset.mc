import Toybox.Application;
import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;

class BitmapAsset {
  private var size200 as Graphics.BitmapReference;
  private var size300 as Graphics.BitmapReference;
  private var size400 as Graphics.BitmapReference;

  function initialize(asset) {
    self.size200 = Application.loadResource(asset.get("200"));
    self.size300 = Application.loadResource(asset.get("300"));
    self.size400 = Application.loadResource(asset.get("400"));
  }

  function draw(dc as Dc) {
    var screenWidth = dc.getWidth();
    var screenHeight = dc.getHeight();
    if (screenWidth >= 200 && screenWidth < 300) {
      dc.drawBitmap(
        screenWidth / 2 - self.size200.getWidth() / 2,
        screenHeight - self.size200.getHeight(),
        self.size200
      );
    } else if (screenWidth >= 300 && screenWidth < 400) {
      dc.drawBitmap(
        screenWidth / 2 - self.size300.getWidth() / 2,
        screenHeight - self.size300.getHeight(),
        self.size300
      );
    } else {
      dc.drawBitmap(
        screenWidth / 2 - self.size400.getWidth() / 2,
        screenHeight - self.size400.getHeight(),
        self.size400
      );
    }
  }
}

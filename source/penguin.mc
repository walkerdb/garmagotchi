class Penguin {
  public var bodyImage;
  public var headImage;
  public var handsImage;
  public var expressionDefaultImage;
  public var expressionDefaultBlinkImage;
  public var expressionHighHRImage;
  public var expressionPastBedtimeImage;
  public var expressionHeh;
  public var accessoriesHotImage;
  public var accessoriesColdImage;

  function initialize() {
    self.bodyImage = new BitmapAsset(Rez.Drawables.PenguinBody);
    self.headImage = new BitmapAsset(Rez.Drawables.PenguinHead);
    self.handsImage = new BitmapAsset(Rez.Drawables.PenguinHands);
    self.expressionDefaultImage = new BitmapAsset(
      Rez.Drawables.PenguinExpressionDefault
    );
    self.expressionDefaultBlinkImage = new BitmapAsset(
      Rez.Drawables.PenguinExpressionDefaultBlink
    );
    self.expressionHighHRImage = new BitmapAsset(
      Rez.Drawables.PenguinExpressionHighHR
    );
    self.expressionPastBedtimeImage = new BitmapAsset(
      Rez.Drawables.PenguinExpressionPastBedtime
    );
    self.expressionHeh = new BitmapAsset(Rez.Drawables.PenguinExpressionHeh);
    self.accessoriesHotImage = new BitmapAsset(
      Rez.Drawables.PenguinAccessoriesHot
    );
    self.accessoriesColdImage = new BitmapAsset(
      Rez.Drawables.PenguinAccessoriesCold
    );
  }
}

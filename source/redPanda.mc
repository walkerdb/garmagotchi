class RedPanda {
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
    self.bodyImage = new BitmapAsset(Rez.Drawables.RedPandaBody);
    self.headImage = new BitmapAsset(Rez.Drawables.RedPandaHead);
    self.handsImage = new BitmapAsset(Rez.Drawables.RedPandaHands);
    self.expressionDefaultImage = new BitmapAsset(
      Rez.Drawables.RedPandaExpressionDefault
    );
    self.expressionDefaultBlinkImage = new BitmapAsset(
      Rez.Drawables.RedPandaExpressionDefaultBlink
    );
    self.expressionHighHRImage = new BitmapAsset(
      Rez.Drawables.RedPandaExpressionHighHR
    );
    self.expressionPastBedtimeImage = new BitmapAsset(
      Rez.Drawables.RedPandaExpressionPastBedtime
    );
    self.expressionHeh = new BitmapAsset(Rez.Drawables.RedPandaExpressionHeh);
    self.accessoriesHotImage = new BitmapAsset(
      Rez.Drawables.RedPandaAccessoriesHot
    );
    self.accessoriesColdImage = new BitmapAsset(
      Rez.Drawables.RedPandaAccessoriesCold
    );
  }
}

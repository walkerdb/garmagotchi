class Walker {
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
    self.bodyImage = new BitmapAsset(Rez.Drawables.WalkerBody);
    self.headImage = new BitmapAsset(Rez.Drawables.WalkerHead);
    self.handsImage = new BitmapAsset(Rez.Drawables.WalkerHands);
    self.expressionDefaultImage = new BitmapAsset(
      Rez.Drawables.WalkerExpressionDefault
    );
    self.expressionDefaultBlinkImage = new BitmapAsset(
      Rez.Drawables.WalkerExpressionDefaultBlink
    );
    self.expressionHighHRImage = new BitmapAsset(
      Rez.Drawables.WalkerExpressionHighHR
    );
    self.expressionPastBedtimeImage = new BitmapAsset(
      Rez.Drawables.WalkerExpressionPastBedtime
    );
    self.expressionHeh = new BitmapAsset(Rez.Drawables.WalkerExpressionHeh);
    self.accessoriesHotImage = new BitmapAsset(
      Rez.Drawables.WalkerAccessoriesHot
    );
    self.accessoriesColdImage = new BitmapAsset(
      Rez.Drawables.WalkerAccessoriesCold
    );
  }
}

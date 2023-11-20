class Ashley {
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
    self.bodyImage = new BitmapAsset(Rez.Drawables.AshleyBody);
    self.headImage = new BitmapAsset(Rez.Drawables.AshleyHead);
    self.handsImage = new BitmapAsset(Rez.Drawables.AshleyHands);
    self.expressionDefaultImage = new BitmapAsset(
      Rez.Drawables.AshleyExpressionDefault
    );
    self.expressionDefaultBlinkImage = new BitmapAsset(
      Rez.Drawables.AshleyExpressionDefaultBlink
    );
    self.expressionHighHRImage = new BitmapAsset(
      Rez.Drawables.AshleyExpressionHighHR
    );
    self.expressionPastBedtimeImage = new BitmapAsset(
      Rez.Drawables.AshleyExpressionPastBedtime
    );
    self.expressionHeh = new BitmapAsset(Rez.Drawables.AshleyExpressionHeh);
    self.accessoriesHotImage = new BitmapAsset(
      Rez.Drawables.AshleyAccessoriesHot
    );
    self.accessoriesColdImage = new BitmapAsset(
      Rez.Drawables.AshleyAccessoriesCold
    );
  }
}

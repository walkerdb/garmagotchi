class Axolotl {
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
    self.bodyImage = new BitmapAsset(Rez.Drawables.AxolotlBody);
    self.headImage = new BitmapAsset(Rez.Drawables.AxolotlHead);
    self.handsImage = new BitmapAsset(Rez.Drawables.AxolotlHands);
    self.expressionDefaultImage = new BitmapAsset(
      Rez.Drawables.AxolotlExpressionDefault
    );
    self.expressionDefaultBlinkImage = new BitmapAsset(
      Rez.Drawables.AxolotlExpressionDefaultBlink
    );
    self.expressionHighHRImage = new BitmapAsset(
      Rez.Drawables.AxolotlExpressionHighHR
    );
    self.expressionPastBedtimeImage = new BitmapAsset(
      Rez.Drawables.AxolotlExpressionPastBedtime
    );
    self.expressionHeh = new BitmapAsset(Rez.Drawables.AxolotlExpressionHeh);
    self.accessoriesHotImage = new BitmapAsset(
      Rez.Drawables.AxolotlAccessoriesHot
    );
    self.accessoriesColdImage = new BitmapAsset(
      Rez.Drawables.AxolotlAccessoriesCold
    );
  }
}

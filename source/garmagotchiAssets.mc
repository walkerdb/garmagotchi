class GarmagotchiAssets {
  public var characters;

  function initialize() {
    var redPandaAssets = {
      "bodyImage" => new BitmapAsset(Rez.Drawables.RedPandaBody),
      "headImage" => new BitmapAsset(Rez.Drawables.RedPandaHead),
      "handsImage" => new BitmapAsset(Rez.Drawables.RedPandaHands),
      "expressionDefaultImage" => new BitmapAsset(
        Rez.Drawables.RedPandaExpressionDefault
      ),
      "expressionDefaultBlinkImage" => new BitmapAsset(
        Rez.Drawables.RedPandaExpressionDefaultBlink
      ),
      "expressionHighHRImage" => new BitmapAsset(
        Rez.Drawables.RedPandaExpressionHighHR
      ),
      "expressionPastBedtimeImage" => new BitmapAsset(
        Rez.Drawables.RedPandaExpressionPastBedtime
      ),
      "expressionHeh" => new BitmapAsset(Rez.Drawables.RedPandaExpressionHeh),
      "accessoriesHotImage" => new BitmapAsset(
        Rez.Drawables.RedPandaAccessoriesHot
      ),
      "accessoriesColdImage" => new BitmapAsset(
        Rez.Drawables.RedPandaAccessoriesCold
      ),
    };

    var axolotlAssets = {
      "bodyImage" => new BitmapAsset(Rez.Drawables.AxolotlBody),
      "headImage" => new BitmapAsset(Rez.Drawables.AxolotlHead),
      "handsImage" => new BitmapAsset(Rez.Drawables.AxolotlHands),
      "expressionDefaultImage" => new BitmapAsset(
        Rez.Drawables.AxolotlExpressionDefault
      ),
      "expressionDefaultBlinkImage" => new BitmapAsset(
        Rez.Drawables.AxolotlExpressionDefaultBlink
      ),
      "expressionHighHRImage" => new BitmapAsset(
        Rez.Drawables.AxolotlExpressionHighHR
      ),
      "expressionPastBedtimeImage" => new BitmapAsset(
        Rez.Drawables.AxolotlExpressionPastBedtime
      ),
      "expressionHeh" => new BitmapAsset(Rez.Drawables.AxolotlExpressionHeh),
      "accessoriesHotImage" => new BitmapAsset(
        Rez.Drawables.AxolotlAccessoriesHot
      ),
      "accessoriesColdImage" => new BitmapAsset(
        Rez.Drawables.AxolotlAccessoriesCold
      ),
    };

    var penguinAssets = {
      "bodyImage" => new BitmapAsset(Rez.Drawables.PenguinBody),
      "headImage" => new BitmapAsset(Rez.Drawables.PenguinHead),
      "handsImage" => new BitmapAsset(Rez.Drawables.PenguinHands),
      "expressionDefaultImage" => new BitmapAsset(
        Rez.Drawables.PenguinExpressionDefault
      ),
      "expressionDefaultBlinkImage" => new BitmapAsset(
        Rez.Drawables.PenguinExpressionDefaultBlink
      ),
      "expressionHighHRImage" => new BitmapAsset(
        Rez.Drawables.PenguinExpressionHighHR
      ),
      "expressionPastBedtimeImage" => new BitmapAsset(
        Rez.Drawables.PenguinExpressionPastBedtime
      ),
      "expressionHeh" => new BitmapAsset(Rez.Drawables.PenguinExpressionHeh),
      "accessoriesHotImage" => new BitmapAsset(
        Rez.Drawables.PenguinAccessoriesHot
      ),
      "accessoriesColdImage" => new BitmapAsset(
        Rez.Drawables.PenguinAccessoriesCold
      ),
    };

    var ashleyAssets = {
      "bodyImage" => new BitmapAsset(Rez.Drawables.AshleyBody),
      "headImage" => new BitmapAsset(Rez.Drawables.AshleyHead),
      "handsImage" => new BitmapAsset(Rez.Drawables.AshleyHands),
      "expressionDefaultImage" => new BitmapAsset(
        Rez.Drawables.AshleyExpressionDefault
      ),
      "expressionDefaultBlinkImage" => new BitmapAsset(
        Rez.Drawables.AshleyExpressionDefaultBlink
      ),
      "expressionHighHRImage" => new BitmapAsset(
        Rez.Drawables.AshleyExpressionHighHR
      ),
      "expressionPastBedtimeImage" => new BitmapAsset(
        Rez.Drawables.AshleyExpressionPastBedtime
      ),
      "expressionHeh" => new BitmapAsset(Rez.Drawables.AshleyExpressionHeh),
      "accessoriesHotImage" => new BitmapAsset(
        Rez.Drawables.AshleyAccessoriesHot
      ),
      "accessoriesColdImage" => new BitmapAsset(
        Rez.Drawables.AshleyAccessoriesCold
      ),
    };

    var walkerAssets = {
      "bodyImage" => new BitmapAsset(Rez.Drawables.WalkerBody),
      "headImage" => new BitmapAsset(Rez.Drawables.WalkerHead),
      "handsImage" => new BitmapAsset(Rez.Drawables.WalkerHands),
      "expressionDefaultImage" => new BitmapAsset(
        Rez.Drawables.WalkerExpressionDefault
      ),
      "expressionDefaultBlinkImage" => new BitmapAsset(
        Rez.Drawables.WalkerExpressionDefaultBlink
      ),
      "expressionHighHRImage" => new BitmapAsset(
        Rez.Drawables.WalkerExpressionHighHR
      ),
      "expressionPastBedtimeImage" => new BitmapAsset(
        Rez.Drawables.WalkerExpressionPastBedtime
      ),
      "expressionHeh" => new BitmapAsset(Rez.Drawables.WalkerExpressionHeh),
      "accessoriesHotImage" => new BitmapAsset(
        Rez.Drawables.WalkerAccessoriesHot
      ),
      "accessoriesColdImage" => new BitmapAsset(
        Rez.Drawables.WalkerAccessoriesCold
      ),
    };

    self.characters = {
      "redPanda" => redPandaAssets,
      "axolotl" => axolotlAssets,
      "penguin" => penguinAssets,
      "ashley" => ashleyAssets,
      "walker" => walkerAssets,
    };
  }
}

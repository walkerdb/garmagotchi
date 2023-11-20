import Toybox.Graphics;
import Toybox.Lang;
using Toybox.Application.Storage;

class Garmagotchi {
  private var bodyImage;
  private var headImage;
  private var handsImage;
  private var expressionDefaultImage;
  private var expressionDefaultBlinkImage;
  private var expressionHighHRImage;
  private var expressionPastBedtimeImage;
  private var expressionHeh;
  private var accessoriesHotImage;
  private var accessoriesColdImage;

  function initialize() {
    setAssets();
  }

  function setAssets() {
    var character = Storage.getValue("garmagotchiCharacter").toString();

    if (character.equals("redPanda")) {
      bodyImage = new BitmapAsset(Rez.Drawables.RedPandaBody);
      headImage = new BitmapAsset(Rez.Drawables.RedPandaHead);
      handsImage = new BitmapAsset(Rez.Drawables.RedPandaHands);
      expressionDefaultImage = new BitmapAsset(
        Rez.Drawables.RedPandaExpressionDefault
      );
      expressionDefaultBlinkImage = new BitmapAsset(
        Rez.Drawables.RedPandaExpressionDefaultBlink
      );
      expressionHighHRImage = new BitmapAsset(
        Rez.Drawables.RedPandaExpressionHighHR
      );
      expressionPastBedtimeImage = new BitmapAsset(
        Rez.Drawables.RedPandaExpressionPastBedtime
      );
      expressionHeh = new BitmapAsset(Rez.Drawables.RedPandaExpressionHeh);
      accessoriesHotImage = new BitmapAsset(
        Rez.Drawables.RedPandaAccessoriesHot
      );
      accessoriesColdImage = new BitmapAsset(
        Rez.Drawables.RedPandaAccessoriesCold
      );
    } else if (character.equals("axolotl")) {
      bodyImage = new BitmapAsset(Rez.Drawables.AxolotlBody);
      headImage = new BitmapAsset(Rez.Drawables.AxolotlHead);
      handsImage = new BitmapAsset(Rez.Drawables.AxolotlHands);
      expressionDefaultImage = new BitmapAsset(
        Rez.Drawables.AxolotlExpressionDefault
      );
      expressionDefaultBlinkImage = new BitmapAsset(
        Rez.Drawables.AxolotlExpressionDefaultBlink
      );
      expressionHighHRImage = new BitmapAsset(
        Rez.Drawables.AxolotlExpressionHighHR
      );
      expressionPastBedtimeImage = new BitmapAsset(
        Rez.Drawables.AxolotlExpressionPastBedtime
      );
      expressionHeh = new BitmapAsset(Rez.Drawables.AxolotlExpressionHeh);
      accessoriesHotImage = new BitmapAsset(
        Rez.Drawables.AxolotlAccessoriesHot
      );
      accessoriesColdImage = new BitmapAsset(
        Rez.Drawables.AxolotlAccessoriesCold
      );
    } else if (character.equals("penguin")) {
      bodyImage = new BitmapAsset(Rez.Drawables.PenguinBody);
      headImage = new BitmapAsset(Rez.Drawables.PenguinHead);
      handsImage = new BitmapAsset(Rez.Drawables.PenguinHands);
      expressionDefaultImage = new BitmapAsset(
        Rez.Drawables.PenguinExpressionDefault
      );
      expressionDefaultBlinkImage = new BitmapAsset(
        Rez.Drawables.PenguinExpressionDefaultBlink
      );
      expressionHighHRImage = new BitmapAsset(
        Rez.Drawables.PenguinExpressionHighHR
      );
      expressionPastBedtimeImage = new BitmapAsset(
        Rez.Drawables.PenguinExpressionPastBedtime
      );
      expressionHeh = new BitmapAsset(Rez.Drawables.PenguinExpressionHeh);
      accessoriesHotImage = new BitmapAsset(
        Rez.Drawables.PenguinAccessoriesHot
      );
      accessoriesColdImage = new BitmapAsset(
        Rez.Drawables.PenguinAccessoriesCold
      );
    }
  }

  function draw(dc as Dc, stats) {
    bodyImage.draw(dc);
    headImage.draw(dc);
    drawExpression(dc, stats);
    drawAccessories(dc, stats);
    handsImage.draw(dc);
  }

  private function drawExpression(dc as Dc, stats) {
    var currentHour = System.getClockTime().hour;
    var currentSecond = System.getClockTime().sec;
    if (
      stats.heartRate == 69 ||
      stats.temperatureInF == 69 ||
      System.getSystemStats().battery == 69
    ) {
      expressionHeh.draw(dc);
    } else if (stats.heartRate != null && stats.heartRate >= 165) {
      expressionHighHRImage.draw(dc);
    } else if (currentHour >= 0 && currentHour <= 6) {
      expressionPastBedtimeImage.draw(dc);
    } else {
      if (currentSecond % 4 == 0) {
        expressionDefaultBlinkImage.draw(dc);
      } else {
        expressionDefaultImage.draw(dc);
      }
    }
  }

  private function drawAccessories(dc as Dc, stats) {
    var isHot = stats.temperatureInF >= 85;
    var isCold = stats.temperatureInF <= 40;
    if (isHot) {
      accessoriesHotImage.draw(dc);
    } else if (isCold) {
      accessoriesColdImage.draw(dc);
    }
  }
}

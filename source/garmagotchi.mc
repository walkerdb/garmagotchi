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

  private var assets;

  function initialize() {
    self.assets = new GarmagotchiAssets();
    setAssets();
  }

  function setAssets() {
    var character = Storage.getValue("garmagotchiCharacter").toString();

    var characterAssets = assets.characters.get(character);

    if (characterAssets != null) {
      bodyImage = characterAssets.get("bodyImage");
      headImage = characterAssets.get("headImage");
      handsImage = characterAssets.get("handsImage");
      expressionDefaultImage = characterAssets.get("expressionDefaultImage");
      expressionDefaultBlinkImage = characterAssets.get(
        "expressionDefaultBlinkImage"
      );
      expressionHighHRImage = characterAssets.get("expressionHighHRImage");
      expressionPastBedtimeImage = characterAssets.get(
        "expressionPastBedtimeImage"
      );
      expressionHeh = characterAssets.get("expressionHeh");
      accessoriesHotImage = characterAssets.get("accessoriesHotImage");
      accessoriesColdImage = characterAssets.get("accessoriesColdImage");
      return;
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

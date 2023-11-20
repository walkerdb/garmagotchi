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

  private var redPandaAssets;
  private var axolotlAssets;
  private var penguinAssets;
  private var ashleyAssets;
  private var walkerAssets;

  function initialize() {
    redPandaAssets = new RedPanda();
    axolotlAssets = new Axolotl();
    penguinAssets = new Penguin();
    ashleyAssets = new Ashley();
    walkerAssets = new Walker();
    setAssets();
  }

  function setAssets() {
    var character = Storage.getValue("garmagotchiCharacter").toString();

    if (character.equals("redPanda")) {
      bodyImage = redPandaAssets.bodyImage;
      headImage = redPandaAssets.headImage;
      handsImage = redPandaAssets.handsImage;
      expressionDefaultImage = redPandaAssets.expressionDefaultImage;
      expressionDefaultBlinkImage = redPandaAssets.expressionDefaultBlinkImage;
      expressionHighHRImage = redPandaAssets.expressionHighHRImage;
      expressionPastBedtimeImage = redPandaAssets.expressionPastBedtimeImage;
      expressionHeh = redPandaAssets.expressionHeh;
      accessoriesHotImage = redPandaAssets.accessoriesHotImage;
      accessoriesColdImage = redPandaAssets.accessoriesColdImage;
    } else if (character.equals("axolotl")) {
      bodyImage = axolotlAssets.bodyImage;
      headImage = axolotlAssets.headImage;
      handsImage = axolotlAssets.handsImage;
      expressionDefaultImage = axolotlAssets.expressionDefaultImage;
      expressionDefaultBlinkImage = axolotlAssets.expressionDefaultBlinkImage;
      expressionHighHRImage = axolotlAssets.expressionHighHRImage;
      expressionPastBedtimeImage = axolotlAssets.expressionPastBedtimeImage;
      expressionHeh = axolotlAssets.expressionHeh;
      accessoriesHotImage = axolotlAssets.accessoriesHotImage;
      accessoriesColdImage = axolotlAssets.accessoriesColdImage;
    } else if (character.equals("penguin")) {
      bodyImage = penguinAssets.bodyImage;
      headImage = penguinAssets.headImage;
      handsImage = penguinAssets.handsImage;
      expressionDefaultImage = penguinAssets.expressionDefaultImage;
      expressionDefaultBlinkImage = penguinAssets.expressionDefaultBlinkImage;
      expressionHighHRImage = penguinAssets.expressionHighHRImage;
      expressionPastBedtimeImage = penguinAssets.expressionPastBedtimeImage;
      expressionHeh = penguinAssets.expressionHeh;
      accessoriesHotImage = penguinAssets.accessoriesHotImage;
      accessoriesColdImage = penguinAssets.accessoriesColdImage;
    } else if (character.equals("ashley")) {
      bodyImage = ashleyAssets.bodyImage;
      headImage = ashleyAssets.headImage;
      handsImage = ashleyAssets.handsImage;
      expressionDefaultImage = ashleyAssets.expressionDefaultImage;
      expressionDefaultBlinkImage = ashleyAssets.expressionDefaultBlinkImage;
      expressionHighHRImage = ashleyAssets.expressionHighHRImage;
      expressionPastBedtimeImage = ashleyAssets.expressionPastBedtimeImage;
      expressionHeh = ashleyAssets.expressionHeh;
      accessoriesHotImage = ashleyAssets.accessoriesHotImage;
      accessoriesColdImage = ashleyAssets.accessoriesColdImage;
    } else if (character.equals("walker")) {
      bodyImage = walkerAssets.bodyImage;
      headImage = walkerAssets.headImage;
      handsImage = walkerAssets.handsImage;
      expressionDefaultImage = walkerAssets.expressionDefaultImage;
      expressionDefaultBlinkImage = walkerAssets.expressionDefaultBlinkImage;
      expressionHighHRImage = walkerAssets.expressionHighHRImage;
      expressionPastBedtimeImage = walkerAssets.expressionPastBedtimeImage;
      expressionHeh = walkerAssets.expressionHeh;
      accessoriesHotImage = walkerAssets.accessoriesHotImage;
      accessoriesColdImage = walkerAssets.accessoriesColdImage;
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

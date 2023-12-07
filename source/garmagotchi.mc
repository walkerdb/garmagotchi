import Toybox.Graphics;
import Toybox.Lang;
using Toybox.Application.Storage;

class Garmagotchi {
  private var body;
  private var head;
  private var hands;
  private var expressionDefault;
  private var expressionDefaultBlink;
  private var expressionHighHRImage;
  private var expressionPastBedtime;
  private var expressionHeh;
  private var accessoriesHot;
  private var accessoriesCold;

  private var assets;

  function initialize() {
    self.assets = new GarmagotchiAssets();
    setAssets();
  }

  function setAssets() {
    var character = Storage.getValue("garmagotchiCharacter").toString();

    var characterAssets = assets.characters.get(character);

    if (characterAssets != null) {
      body = characterAssets.get("body");
      head = characterAssets.get("head");
      hands = characterAssets.get("hands");
      expressionDefault = characterAssets.get("expressionDefault");
      expressionDefaultBlink = characterAssets.get("expressionDefaultBlink");
      expressionHighHRImage = characterAssets.get("expressionHighHR");
      expressionPastBedtime = characterAssets.get("expressionPastBedtime");
      expressionHeh = characterAssets.get("expressionHeh");
      accessoriesHot = characterAssets.get("accessoriesHot");
      accessoriesCold = characterAssets.get("accessoriesCold");
      return;
    }
  }

  function draw(dc as Dc, stats) {
    body.draw(dc);
    head.draw(dc);
    drawExpression(dc, stats);
    drawAccessories(dc, stats);
    hands.draw(dc);
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
      expressionPastBedtime.draw(dc);
    } else {
      if (currentSecond % 4 == 0) {
        expressionDefaultBlink.draw(dc);
      } else {
        expressionDefault.draw(dc);
      }
    }
  }

  private function drawAccessories(dc as Dc, stats) {
    var isHot = stats.temperatureInF >= 85;
    var isCold = stats.temperatureInF <= 40;
    if (isHot) {
      accessoriesHot.draw(dc);
    } else if (isCold) {
      accessoriesCold.draw(dc);
    }
  }
}

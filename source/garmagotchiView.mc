import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.ActivityMonitor;
import Toybox.Math;
import Toybox.Time;
import Toybox.Weather;

class garmagotchiView extends WatchUi.WatchFace {
  private var miniPartner;
  private var miniPartnerKiss;
  private var bodyImage;
  private var headImage;
  private var handsImage;
  private var expressionDefaultImage;
  private var expressionDefaultBlinkImage;
  private var expressionHighHRImage;
  private var expressionPastBedtimeImage;
  private var accessoriesHotImage;
  private var accessoriesColdImage;
  private var chosenCharacter;

  private var screenWidth;
  private var screenHeight;

  private var heartRate;
  private var temperatureInC;

  private var kissAnimationStartTime;

  function initialize() {
    WatchFace.initialize();
    chosenCharacter = new Character("Walker");
    miniPartner = new BitmapAsset(
      chosenCharacter,
      Rez.Drawables.AshleyMiniWalker,
      Rez.Drawables.WalkerMiniAshley
    );
    miniPartnerKiss = new BitmapAsset(
      chosenCharacter,
      Rez.Drawables.AshleyMiniWalkerKiss,
      Rez.Drawables.WalkerMiniAshleyKiss
    );
    bodyImage = new BitmapAsset(
      chosenCharacter,
      Rez.Drawables.AshleyBody,
      Rez.Drawables.WalkerBody
    );
    headImage = new BitmapAsset(
      chosenCharacter,
      Rez.Drawables.AshleyHead,
      Rez.Drawables.WalkerHead
    );
    handsImage = new BitmapAsset(
      chosenCharacter,
      Rez.Drawables.AshleyHands,
      Rez.Drawables.WalkerHands
    );
    expressionDefaultImage = new BitmapAsset(
      chosenCharacter,
      Rez.Drawables.AshleyExpressionDefault,
      Rez.Drawables.WalkerExpressionDefault
    );
    expressionDefaultBlinkImage = new BitmapAsset(
      chosenCharacter,
      Rez.Drawables.AshleyExpressionDefaultBlink,
      Rez.Drawables.WalkerExpressionDefaultBlink
    );
    expressionHighHRImage = new BitmapAsset(
      chosenCharacter,
      Rez.Drawables.AshleyExpressionHighHR,
      Rez.Drawables.WalkerExpressionHighHR
    );
    expressionPastBedtimeImage = new BitmapAsset(
      chosenCharacter,
      Rez.Drawables.AshleyExpressionPastBedtime,
      Rez.Drawables.WalkerExpressionPastBedtime
    );
    accessoriesHotImage = new BitmapAsset(
      chosenCharacter,
      Rez.Drawables.AshleyAccessoriesHot,
      Rez.Drawables.WalkerAccessoriesHot
    );
    accessoriesColdImage = new BitmapAsset(
      chosenCharacter,
      Rez.Drawables.AshleyAccessoriesCold,
      Rez.Drawables.WalkerAccessoriesCold
    );
  }

  // Load your resources here
  function onLayout(dc as Dc) as Void {
    setLayout(Rez.Layouts.WatchFace(dc));
    screenWidth = dc.getWidth();
    screenHeight = dc.getHeight();
  }

  // Called when this View is brought to the foreground. Restore
  // the state of this View and prepare it to be shown. This includes
  // loading resources into memory.
  function onShow() as Void {
    var currentSecond = System.getClockTime().sec;
    kissAnimationStartTime = currentSecond;
  }

  // Update the view
  function onUpdate(dc as Dc) as Void {
    // Call the parent onUpdate function to redraw the layout
    getHeartRate();
    getWeather();
    View.onUpdate(dc);
    setDayDisplay();
    setTimeDisplay();
    setWeatherDisplay();
    setHeartrateDisplay();
    setBatteryDisplay();
    drawGarmagotchi(dc);
    drawMiniPartner(dc);
  }

  // Called when this View is removed from the screen. Save the
  // state of this View here. This includes freeing resources from
  // memory.
  function onHide() as Void {
    kissAnimationStartTime = -1;
  }

  // The user has just looked at their watch. Timers and animations may be started here.
  function onExitSleep() as Void {
    var currentSecond = System.getClockTime().sec;
    kissAnimationStartTime = currentSecond;
  }

  // Terminate any active timers and prepare for slow updates.
  function onEnterSleep() as Void {
    kissAnimationStartTime = -1;
  }

  private function drawGarmagotchi(dc as Dc) {
    bodyImage.draw(dc);
    headImage.draw(dc);
    drawExpression(dc);
    drawAccessories(dc);
    handsImage.draw(dc);
  }

  private function drawMiniPartner(dc) {
    if (kissAnimationStartTime != -1) {
      var currentSecond = System.getClockTime().sec;
      if (
        currentSecond == kissAnimationStartTime + 1 ||
        currentSecond == kissAnimationStartTime + 3
      ) {
        miniPartner.draw(dc);
      } else if (currentSecond == kissAnimationStartTime + 2) {
        miniPartnerKiss.draw(dc);
      }
      if (currentSecond == kissAnimationStartTime + 4) {
        kissAnimationStartTime = -1;
      }
    }
  }

  private function drawAccessories(dc as Dc) {
    var isHot = temperatureInC >= 30;
    var isCold = temperatureInC <= 10;
    if (isHot) {
      accessoriesHotImage.draw(dc);
    } else if (isCold) {
      accessoriesColdImage.draw(dc);
    }
  }

  private function drawExpression(dc as Dc) {
    var currentHour = System.getClockTime().hour;
    var currentSecond = System.getClockTime().sec;
    if (heartRate != null && heartRate >= 165) {
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

  private function setDayDisplay() {
    var now = Time.now();
    var date = Time.Gregorian.info(now, Time.FORMAT_MEDIUM);
    var dateString = Lang.format("$1$, $2$ $3$", [
      date.day_of_week,
      date.month,
      date.day,
    ]);
    var view = View.findDrawableById("DateDisplay") as Text;
    view.setColor(0xdddddd);
    view.setText(dateString);
  }

  private function setTimeDisplay() {
    var timeFormat = "$1$:$2$ $3$";
    var clockTime = System.getClockTime();
    var hours = clockTime.hour;
    if (!System.getDeviceSettings().is24Hour) {
      if (hours > 12) {
        hours = hours - 12;
      }
      if (hours == 0) {
        hours = 12;
      }
    } else {
      if (Properties.getValue("UseMilitaryFormat")) {
        timeFormat = "$1$$2$";
        hours = hours.format("%02d");
      }
    }
    var timeString = Lang.format(timeFormat, [
      hours,
      clockTime.min.format("%02d"),
      clockTime.hour >= 12 ? "pm" : "am",
    ]);

    // Update the view
    var view = View.findDrawableById("TimeDisplay") as Text;
    view.setText(timeString);
  }

  private function cToF(temperatureInCelsius as Number) as Number {
    return 32 + (temperatureInCelsius * 9) / 5;
  }

  private function getWeather() {
    temperatureInC = Weather.getCurrentConditions().temperature;
  }

  private function setWeatherDisplay() {
    var view = View.findDrawableById("TempDisplay") as Text;
    var usesCelsius = System.getDeviceSettings().temperatureUnits == 0;
    var displayTemp = (
      usesCelsius ? temperatureInC : cToF(temperatureInC)
    ).toString();
    view.setText(displayTemp + "°");
  }

  private function getHeartRate() {
    heartRate = 0;
    var info = Activity.getActivityInfo();
    if (info != null) {
      heartRate = info.currentHeartRate;
    } else {
      var latestHeartRateSample = ActivityMonitor.getHeartRateHistory(
        1,
        true
      ).next();
      if (latestHeartRateSample != null) {
        heartRate = latestHeartRateSample.heartRate;
      }
    }
  }

  private function setHeartrateDisplay() {
    var view = View.findDrawableById("HeartrateDisplay") as Text;
    var heartRateText =
      heartRate == 0 || heartRate == null ? "--" : heartRate.format("%d");
    view.setText(heartRateText);
  }

  private function setBatteryDisplay() {
    var battery = System.getSystemStats().battery;
    var view = View.findDrawableById("BatteryDisplay") as Text;
    view.setText(battery.format("%d") + "%");
  }
}

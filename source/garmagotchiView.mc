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
  private var mode;

  private var partner;
  private var partnerKiss;
  private var partnerSparkle;
  private var partnerSquish;

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

  private var screenWidth;
  private var screenHeight;

  private var heartRate;
  private var temperatureInC;

  private var partnerAnimationStartTime;

  function initialize() {
    WatchFace.initialize();
    mode = "animal";

    partner = new BitmapAsset(Rez.Drawables.Partner);
    partnerKiss = new BitmapAsset(Rez.Drawables.PartnerKiss);
    partnerSparkle = new BitmapAsset(Rez.Drawables.PartnerSparkle);
    partnerSquish = new BitmapAsset(Rez.Drawables.PartnerSquish);
    bodyImage = new BitmapAsset(Rez.Drawables.Body);
    headImage = new BitmapAsset(Rez.Drawables.Head);
    handsImage = new BitmapAsset(Rez.Drawables.Hands);
    expressionDefaultImage = new BitmapAsset(Rez.Drawables.ExpressionDefault);
    expressionDefaultBlinkImage = new BitmapAsset(
      Rez.Drawables.ExpressionDefaultBlink
    );
    expressionHighHRImage = new BitmapAsset(Rez.Drawables.ExpressionHighHR);
    expressionPastBedtimeImage = new BitmapAsset(
      Rez.Drawables.ExpressionPastBedtime
    );
    expressionHeh = new BitmapAsset(Rez.Drawables.ExpressionHeh);
    accessoriesHotImage = new BitmapAsset(Rez.Drawables.AccessoriesHot);
    accessoriesColdImage = new BitmapAsset(Rez.Drawables.AccessoriesCold);
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
    partnerAnimationStartTime = currentSecond;
  }

  // Update the view
  function onUpdate(dc as Dc) as Void {
    // Call the parent onUpdate function to redraw the layout
    View.onUpdate(dc);
    getHeartRate();
    getWeather();
    setDayDisplay();
    setTimeDisplay();
    setWeatherDisplay();
    setHeartrateDisplay();
    setBatteryDisplay();
    drawGarmagotchi(dc);
    if (mode == "couple") {
      drawPartner(dc);
    }
  }

  // Called when this View is removed from the screen. Save the
  // state of this View here. This includes freeing resources from
  // memory.
  function onHide() as Void {
    partnerAnimationStartTime = -1;
  }

  // The user has just looked at their watch. Timers and animations may be started here.
  function onExitSleep() as Void {
    var currentSecond = System.getClockTime().sec;
    partnerAnimationStartTime = currentSecond;
  }

  // Terminate any active timers and prepare for slow updates.
  function onEnterSleep() as Void {
    partnerAnimationStartTime = -1;
  }

  private function drawGarmagotchi(dc as Dc) {
    bodyImage.draw(dc);
    headImage.draw(dc);
    drawExpression(dc);
    drawAccessories(dc);
    handsImage.draw(dc);
  }

  private function drawPartner(dc) {
    if (partnerAnimationStartTime != -1) {
      var currentSecond = System.getClockTime().sec;
      if (
        currentSecond == partnerAnimationStartTime + 1 ||
        currentSecond == partnerAnimationStartTime + 3
      ) {
        partner.draw(dc);
      } else if (currentSecond == partnerAnimationStartTime + 2) {
        var rand = Math.rand() % 3;
        if (rand == 0) {
          partnerSparkle.draw(dc);
        } else if (rand == 1) {
          partnerKiss.draw(dc);
        } else if (rand == 2) {
          partnerSquish.draw(dc);
        }
      }
      if (currentSecond == partnerAnimationStartTime + 4) {
        partnerAnimationStartTime = -1;
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
    if (
      heartRate == 69 ||
      cToF(temperatureInC) == 69 ||
      System.getSystemStats().battery == 69
    ) {
      expressionHeh.draw(dc);
    } else if (heartRate != null && heartRate >= 165) {
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
    heartRate = 166;
    // var info = Activity.getActivityInfo();
    // if (info != null) {
    //   heartRate = info.currentHeartRate;
    // } else {
    //   var latestHeartRateSample = ActivityMonitor.getHeartRateHistory(
    //     1,
    //     true
    //   ).next();
    //   if (latestHeartRateSample != null) {
    //     heartRate = latestHeartRateSample.heartRate;
    //   }
    // }
  }

  private function setHeartrateDisplay() {
    var view = View.findDrawableById("HeartrateDisplay") as Text;
    var heartRateText =
      heartRate == 0 || heartRate == null
        ? "-- bpm"
        : heartRate.format("%d") + " bpm";
    view.setText(heartRateText);
  }

  private function setBatteryDisplay() {
    var battery = System.getSystemStats().battery;
    var view = View.findDrawableById("BatteryDisplay") as Text;
    view.setText(battery.format("%d") + "%");
  }
}

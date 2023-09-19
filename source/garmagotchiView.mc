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
  private var togetherImage;
  private var heartImage;
  private var bodyImage;
  private var headImage;
  private var handsImage;
  private var expressionDefaultImage;
  private var expressionHighHRImage;
  private var expressionPastBedtimeImage;

  private var screenWidth;
  private var screenHeight;

  private var heartRate;

  function initialize() {
    WatchFace.initialize();
    togetherImage = Application.loadResource(Rez.Drawables.Together);
    // heartImage = Application.loadResource(Rez.Drawables.Heart);
    // bodyImage = Application.loadResource(Rez.Drawables.AshleyBody);
    // headImage = Application.loadResource(Rez.Drawables.AshleyHead);
    // handsImage = Application.loadResource(Rez.Drawables.AshleyHands);
    // expressionDefaultImage = Application.loadResource(
    //   Rez.Drawables.AshleyExpressionDefault
    // );
    bodyImage = Application.loadResource(Rez.Drawables.WalkerBody);
    headImage = Application.loadResource(Rez.Drawables.WalkerHead);
    handsImage = Application.loadResource(Rez.Drawables.WalkerHands);
    expressionDefaultImage = Application.loadResource(
      Rez.Drawables.WalkerExpressionDefault
    );
    expressionHighHRImage = Application.loadResource(
      Rez.Drawables.WalkerExpressionHighHR
    );
    expressionPastBedtimeImage = Application.loadResource(
      Rez.Drawables.WalkerExpressionPastBedtime
    );
  }

  // Load your resources here
  function onLayout(dc as Dc) as Void {
    setLayout(Rez.Layouts.WatchFace(dc));
    screenWidth = dc.getWidth();
    screenHeight = dc.getHeight();
    getHeartRate();
  }

  // Called when this View is brought to the foreground. Restore
  // the state of this View and prepare it to be shown. This includes
  // loading resources into memory.
  function onShow() as Void {}

  // Update the view
  function onUpdate(dc as Dc) as Void {
    // Call the parent onUpdate function to redraw the layout
    View.onUpdate(dc);
    setDayDisplay();
    setTimeDisplay();
    setWeatherDisplay();
    setHeartrateDisplay();
    setBatteryDisplay();
    drawGarmagotchi(dc);
  }

  // Called when this View is removed from the screen. Save the
  // state of this View here. This includes freeing resources from
  // memory.
  function onHide() as Void {}

  // The user has just looked at their watch. Timers and animations may be started here.
  function onExitSleep() as Void {}

  // Terminate any active timers and prepare for slow updates.
  function onEnterSleep() as Void {}

  private function drawGarmagotchi(dc as Dc) {
    dc.drawBitmap(
      screenWidth / 2 - bodyImage.getWidth() / 2,
      screenHeight - bodyImage.getHeight(),
      bodyImage
    );
    dc.drawBitmap(
      screenWidth / 2 - headImage.getWidth() / 2,
      screenHeight - headImage.getHeight(),
      headImage
    );
    dc.drawBitmap(
      screenWidth / 2 - handsImage.getWidth() / 2,
      screenHeight - handsImage.getHeight(),
      handsImage
    );
    drawExpression(dc);
  }

  private function drawExpression(dc as Dc) {
    var currentHour = System.getClockTime().hour;
    if (heartRate != null && heartRate >= 165) {
      dc.drawBitmap(
        screenWidth / 2 - expressionHighHRImage.getWidth() / 2,
        screenHeight - expressionHighHRImage.getHeight(),
        expressionHighHRImage
      );
    } else if (currentHour >= 0 && currentHour <= 6) {
      dc.drawBitmap(
        screenWidth / 2 - expressionDefaultImage.getWidth() / 2,
        screenHeight - expressionDefaultImage.getHeight(),
        expressionPastBedtimeImage
      );
    } else {
      dc.drawBitmap(
        screenWidth / 2 - expressionDefaultImage.getWidth() / 2,
        screenHeight - expressionDefaultImage.getHeight(),
        expressionDefaultImage
      );
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

  private function setWeatherDisplay() {
    var view = View.findDrawableById("TempDisplay") as Text;
    var temperatureInC = Weather.getCurrentConditions().temperature;
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

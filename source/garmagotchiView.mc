import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.ActivityMonitor;
import Toybox.Math;
import Toybox.Time;
import Toybox.Weather;
using Toybox.Application.Storage;

class GarmagotchiView extends WatchUi.WatchFace {
  private var character;
  private var partner;

  private var prevSelectedCharacter;

  private var heartRate;
  private var temperatureInC;

  function initialize() {
    WatchFace.initialize();
    character = new Garmagotchi();
    character.setAssets();
    partner = new Partner();
    prevSelectedCharacter = Storage.getValue("garmagotchiCharacter");
  }

  // Load your resources here
  function onLayout(dc as Dc) as Void {
    setLayout(Rez.Layouts.WatchFace(dc));
  }

  // Called when this View is brought to the foreground. Restore
  // the state of this View and prepare it to be shown. This includes
  // loading resources into memory.
  function onShow() as Void {
    var currentSecond = System.getClockTime().sec;
    partner.setAnimationStartTime(currentSecond);
  }

  // Update the view
  function onUpdate(dc as Dc) as Void {
    // Call the parent onUpdate function to redraw the layout
    var newCharacter = Storage.getValue("garmagotchiCharacter");
    View.onUpdate(dc);
    drawInfo();
    if (!prevSelectedCharacter.equals(newCharacter)) {
      character.setAssets();
      prevSelectedCharacter = newCharacter;
    }
    character.draw(dc, new Stats(heartRate, cToF(temperatureInC)));
    if (newCharacter.equals("me")) {
      partner.draw(dc);
    }
  }

  // Called when this View is removed from the screen. Save the
  // state of this View here. This includes freeing resources from
  // memory.
  function onHide() as Void {
    partner.setAnimationStartTime(-1);
  }

  // The user has just looked at their watch. Timers and animations may be started here.
  function onExitSleep() as Void {
    var currentSecond = System.getClockTime().sec;
    partner.setAnimationStartTime(currentSecond);
  }

  // Terminate any active timers and prepare for slow updates.
  function onEnterSleep() as Void {
    partner.setAnimationStartTime(-1);
  }

  private function drawInfo() {
    getHeartRate();
    getWeather();
    setDayDisplay();
    setTimeDisplay();
    setWeatherDisplay();
    setHeartrateDisplay();
    setBatteryDisplay();
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
    }
    var timeString = Lang.format(timeFormat, [
      hours,
      clockTime.min.format("%02d"),
      clockTime.hour >= 12 ? "pm" : "am",
    ]);

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

import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.ActivityMonitor;
import Toybox.Math;
using Toybox.Time.Gregorian as Date;
using Toybox.Time;

class garmagotchiView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        setHeartrateDisplay();
        setDateTimeDisplay();
        setBatteryDisplay();
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

    private function setDateTimeDisplay() {
        var now = Time.now();
        var date = Date.info(now, Time.FORMAT_MEDIUM);
        var dateString = Lang.format("$1$, $2$ $3$", [date.day_of_week, date.month, date.day]);
        
        var timeFormat = "$1$:$2$";
        var clockTime = System.getClockTime();
        var hours = clockTime.hour;
        if (!System.getDeviceSettings().is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
        } else {
            if (getApp().getProperty("UseMilitaryFormat")) {
                timeFormat = "$1$$2$";
                hours = hours.format("%02d");
            }
        } 
        var timeString = Lang.format(timeFormat, [hours, clockTime.min.format("%02d")]);

        // Update the view
        var view = View.findDrawableById("DateTimeDisplay") as Text;
        view.setColor(0xDDDDDD);
        view.setText(dateString + " " + timeString); 
    }

    private function setHeartrateDisplay() {
        var heartRate = 0;
        
        var info = Activity.getActivityInfo();
        if (info != null) {
            heartRate = info.currentHeartRate;
        } else {
            var latestHeartRateSample = ActivityMonitor.getHeartRateHistory(1, true).next();
            if (latestHeartRateSample != null) {
                heartRate = latestHeartRateSample.heartRate;
            }
        }

        var view = View.findDrawableById("HeartrateDisplay") as Text;  
        view.setText((heartRate == 0 || heartRate == null) ? "--" : heartRate.format("%d"));
    }
    private function setBatteryDisplay() {
        var battery = System.getSystemStats().battery;
        var view = View.findDrawableById("BatteryDisplay") as Text;  
        view.setText(battery.format("%d") + "%");
    }
}

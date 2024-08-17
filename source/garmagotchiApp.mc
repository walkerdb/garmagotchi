import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
using Toybox.Application.Storage;

class GarmagotchiApp extends Application.AppBase {
  function initialize() {
    AppBase.initialize();

    if (Storage.getValue("garmagotchiCharacter") == null) {
      Storage.setValue("garmagotchiCharacter", "redPanda");
    }
  }

  // onStart() is called on application start up
  function onStart(state as Dictionary?) as Void {}

  // onStop() is called when your application is exiting
  function onStop(state as Dictionary?) as Void {}

  // Return the initial view of your application here
  function getInitialView() {
    return [new GarmagotchiView()];
  }

  function getSettingsView() {
    return (
      [new GarmagotchiSettings(), new GarmagotchiSettingsDelegate()]
    );
  }

  function onSettingsChanged() as Void {
    WatchUi.requestUpdate();
  }
}

function getApp() as GarmagotchiApp {
  return Application.getApp() as GarmagotchiApp;
}

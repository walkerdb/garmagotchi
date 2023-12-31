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
  function getInitialView() as Array<Views or InputDelegates>? {
    return [new GarmagotchiView()] as Array<Views or InputDelegates>;
  }

  function getSettingsView() {
    return (
      [new GarmagotchiSettings(), new GarmagotchiSettingsDelegate()] as
      Array<Views or InputDelegates>
    );
  }

  function onSettingsChanged() as Void {
    WatchUi.requestUpdate();
  }
}

function getApp() as GarmagotchiApp {
  return Application.getApp() as GarmagotchiApp;
}

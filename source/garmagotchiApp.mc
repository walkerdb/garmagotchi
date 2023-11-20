import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
using Toybox.Application.Storage;

class garmagotchiApp extends Application.AppBase {
  function initialize() {
    AppBase.initialize();

    if (Storage.getValue("garmagotchiCharacter") == null) {
      Storage.setValue("garmagotchiCharacter", "redPanda");
    }
    if (Storage.getValue("garmagotchiMode") == null) {
      Storage.setValue("garmagotchiMode", "animal");
    }
  }

  // onStart() is called on application start up
  function onStart(state as Dictionary?) as Void {}

  // onStop() is called when your application is exiting
  function onStop(state as Dictionary?) as Void {}

  // Return the initial view of your application here
  function getInitialView() as Array<Views or InputDelegates>? {
    return [new garmagotchiView()] as Array<Views or InputDelegates>;
  }

  function getSettingsView() {
    return (
      [new garmagotchiSettings(), new garmagotchiSettingsDelegate()] as
      Array<Views or InputDelegates>
    );
  }

  // New app settings have been received so trigger a UI update
  function onSettingsChanged() as Void {
    WatchUi.requestUpdate();
  }
}

function getApp() as garmagotchiApp {
  return Application.getApp() as garmagotchiApp;
}

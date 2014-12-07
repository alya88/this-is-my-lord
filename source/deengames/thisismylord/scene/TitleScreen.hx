package deengames.thisismylord.scene;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;
import flixel.FlxGame;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.plugin.MouseEventManager;

import deengames.io.GestureManager;
import deengames.beyondbooks.Scene;
import deengames.thisismylord.scene.DarknessScene;

class TitleScreen extends Scene
{
  /**
  * Function that is called up when to state is created to set it up.
  */
  override public function create():Void
  {
    var title:FlxSprite = this.addAndCenter('assets/images/titlescreen.png');
    super.create();
  }

  /**
  * Function that is called when this state is destroyed - you might want to
  * consider setting all objects this state uses to null to help garbage collection.
  */
  override public function destroy():Void
  {
    super.destroy();
  }

  /**
  * Function that is called once every frame.
  */
  override public function update():Void
  {
    this.gestureManager.update();
    super.update();
  }

  private function onClick(sprite:FlxSprite) : Void
  {
    FlxG.camera.fade(FlxColor.BLACK, .5, false, onFadedOut);
  }

  private function onFadedOut() : Void {
    FlxG.switchState(new DarknessScene());
  }
}

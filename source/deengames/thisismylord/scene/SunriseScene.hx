package deengames.thisismylord.scene;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;
import flixel.FlxGame;
import flixel.FlxState;
import flixel.FlxSprite;
import deengames.beyondbooks.Scene;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.plugin.MouseEventManager;

class SunriseScene extends Scene
{
  /**
  * Function that is called up when to state is created to set it up.
  */
  override public function create():Void
  {
    var title:FlxSprite = this.addAndCenter('assets/images/scene-7-sunrise.jpg');
    this.previousScene = new deengames.thisismylord.scene.MoonSetsScene();
    this.nextScene = new deengames.thisismylord.scene.FreeOfYouScene();
    this.loadAndPlay('assets/audio/speech/scene-7-sunrise');

    var gif = this.addAndCenterAnimatedGif('assets/images/sunset.gif');
    gif.x = 0;
    gif.y = 0;
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
    super.update();
  }
}

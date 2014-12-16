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

class CreatedMeScene extends Scene
{
  /**
  * Function that is called up when to state is created to set it up.
  */
  override public function create():Void
  {
    var title:FlxSprite = this.addAndCenter('assets/images/scene-10-created-me.jpg');
    this.previousScene = new deengames.thisismylord.scene.CreatorOfUniverseScene();
    this.nextScene = new deengames.thisismylord.scene.GuidesMeScene();
    this.loadAndPlay('assets/audio/speech/scene-10-created-me.mp3');
    var heartbeat:FlxSprite = addAndCenterAnimation('assets/images/beating-heart.jpg', 457, 341, 6, 8);

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

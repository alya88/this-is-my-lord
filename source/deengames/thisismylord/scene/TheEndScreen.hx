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

class TheEndScreen extends Scene
{
  /**
  * Function that is called up when to state is created to set it up.
  */
  override public function create():Void
  {
    var title:FlxSprite = this.addAndCenter('assets/images/the-end.png');
    this.previousScene = new deengames.thisismylord.scene.ForgivenessScene();
    this.nextScene = new deengames.thisismylord.scene.DarknessScene();

    var restart:FlxSprite = this.addAndCenter('assets/images/restart.png');
    restart.y = FlxG.height - restart.height - 32;
    MouseEventManager.add(restart, null, restartGame, null, null);

    deengames.io.AudioManager.play('assets/audio/speech/the-end.mp3');
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

  private function restartGame(sprite:FlxSprite) : Void
  {
    FlxG.switchState(this.nextScene);
  }
}

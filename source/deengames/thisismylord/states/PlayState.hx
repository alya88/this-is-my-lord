package deengames.thisismylord.states;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import flixel.plugin.MouseEventManager;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
  /**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
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

	private function scaleToFitNonUniform(sprite:FlxSprite) : Void
	{
	  // scale to fit
    var scaleW = FlxG.width / sprite.width;
    var scaleH = FlxG.height / sprite.height;
    //  non-uniform scale
    sprite.scale.set(scaleW, scaleH);
	}

  private function scaleToFitUniform(sprite:FlxSprite) : Void
  {
    var scaleW = FlxG.width / sprite.width;
    var scaleH = FlxG.height / sprite.height;
    var scale = Math.min(scaleW, scaleH);
    //  uniform scale
    sprite.scale.set(scale, scale);
  }

	private function centerOnScreen(sprite:FlxSprite) : Void
	{
  	sprite.x = (FlxG.width - sprite.width) / 2;
	  sprite.y = (FlxG.height - sprite.height) / 2;
	}
}

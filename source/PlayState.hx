package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import flixel.plugin.MouseEventManager;

import ui.BladeStreak;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
  private var title:FlxSprite;
  private var lastMousePosition:FlxPoint;
  private var streak:BladeStreak = new BladeStreak();

  /**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
	  var bg = addSprite("assets/images/background.jpg");
    scaleToFit(bg);

    this.title = addSprite("assets/images/title.png");
    centerOnScreen(title);

    dieOnSlice(title);

    add(this.streak.surface);

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
    if (FlxG.mouse.pressed) {
      this.lastMousePosition = FlxG.mouse.getScreenPosition();
      this.streak.addPoint(this.lastMousePosition);
    } else {
      this.streak.removeOldestPoint();
    }

    super.update();
	}

	private function scaleToFit(sprite:FlxSprite) : Void
	{
	  // scale to fit
    var scaleW = FlxG.width / sprite.width;
    var scaleH = FlxG.height / sprite.height;
    //  non-uniform scale
    sprite.scale.set(scaleW, scaleH);
    trace("Scaled to w=" + scaleW + " h=" + scaleH);
    trace("Derp? w=" + FlxG.width + " h=" + FlxG.height);
	}

	// Makes a sprite that dies when you slice (touch) it.
	private function dieOnSlice(sprite:FlxSprite)
	{
  	MouseEventManager.add(sprite, null, null, onMouseOver, null);
	}

	private function onMouseOver(sprite:FlxSprite)
	{
	  // kill() keeps it in memory
    var currentPosition = FlxG.mouse.getScreenPosition();
    if (this.lastMousePosition != null && (currentPosition.x != this.lastMousePosition.x ||
       currentPosition.y != this.lastMousePosition.y)) {
  	  sprite.destroy();
      // Special case for new game
  	  if (sprite == this.title) {
  	    startGame();
      }
    }
	}

	private function startGame() {
	  var masjid = this.addSprite("assets/images/masjid.png");
	  centerOnScreen(masjid);
	}

	/*** framework code? ***/

	private function addSprite(filename:String) : FlxSprite
	{
	  var sprite = new FlxSprite();
    sprite.loadGraphic(filename);
    add(sprite);
    return sprite;
	}

	private function centerOnScreen(sprite:FlxSprite) : Void
	{
  	sprite.x = (FlxG.width - sprite.width) / 2;
	  sprite.y = (FlxG.height - sprite.height) / 2;
	}
}

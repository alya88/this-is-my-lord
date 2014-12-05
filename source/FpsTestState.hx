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
import flixel.system.FlxSound;
import flixel.ui.FlxButton;

/**
 * FPS test. On my low-end Android phone, I don't get any stuttering or slowdown,
 * even with a tremendous amount of stars. That "proves" that my blade streak
 * drawing, which is slow, needs some sort of optimization/tweakage.
 */
class FpsTestState extends FlxState
{

	private var stars:List<Star> = new List<Star>();

  /**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		var sprite = new FlxSprite();
		sprite.loadGraphic("assets/images/background.jpg");
		var scaleW = FlxG.width / sprite.width;
		var scaleH = FlxG.height / sprite.height;
		//  non-uniform scale
		sprite.scale.set(scaleW, scaleH);
		trace("w=" + scaleW + " h=" + scaleH);
		add(sprite);

    addStar();
		var sound:FlxSound = FlxG.sound.load("assets/audio/titlescreen.ogg");
		sound.play();

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
      addStar();
    }

		for (star in this.stars) {
			star.y += 10;
			if (star.y >= FlxG.height) {
				this.stars.remove(star);
			}
		}

    super.update();
	}

  private function addStar() : Void {
    var s:Star = new Star(Std.random(FlxG.width - 192), -192);
		this.stars.add(s);
		add(s);
		s.animate();
		s.scale.set(0.5, 0.5);
  }
}

class Star extends FlxSprite {
  public function new(x:Float=0, y:Float=0)
  {
    super(x, y);
    loadGraphic("assets/images/stars.png", true, 192, 192);
    animation.add("twirl", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 10, false);
    width = 192;
    height = 192;
  }

	public function animate() : Void {
		animation.play('twirl');
	}
}

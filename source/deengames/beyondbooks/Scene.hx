package deengames.beyondbooks;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import flixel.util.FlxColor;
import flixel.plugin.MouseEventManager;
import deengames.io.GestureManager;

/**
* A common base state used for all scenes.
*/
class Scene extends FlxState
{
  private var gestureManager:GestureManager = new GestureManager();
  private var nextScene:Scene;
  private var previousScene:Scene;

  /**
  * Function that is called up when to state is created to set it up.
  */
  override public function create():Void
  {
    this.gestureManager.onGesture(Gesture.Swipe, onSwipe);
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

  public function addAndCenter(fileName:String) : FlxSprite
  {
    var sprite = this.addSprite(fileName);
    centerOnScreen(sprite);
    return sprite;
  }

  private function addSprite(fileName:String) : FlxSprite
  {
    var sprite = new FlxSprite();
    sprite.loadGraphic(fileName);
    add(sprite);
    return sprite;
  }

  private function scaleToFitNonUniform(sprite:FlxSprite) : Void
  {
    // scale to fit
    var scaleW = FlxG.width / sprite.width;
    var scaleH = FlxG.height / sprite.height;
    //  non-uniform scale
    sprite.scale.set(scaleW, scaleH);
  }

  private function scaleToFit(sprite:FlxSprite) : Void
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

  private function onSwipe(direction:SwipeDirection) : Void
  {
    if (direction == SwipeDirection.Left && this.nextScene != null) {
      //FlxG.camera.fade(FlxColor.BLACK, 0.5, false, showNextScene);
      showNextScene();
    } else if (direction == SwipeDirection.Right && this.previousScene != null) {
      //FlxG.camera.fade(FlxColor.BLACK, 0.5, false, showPreviousScene);
      showPreviousScene();
    }
  }

  private function showNextScene() : Void {
    FlxG.switchState(this.nextScene);
  }

  private function showPreviousScene() : Void {
    FlxG.switchState(this.previousScene);
  }  
}

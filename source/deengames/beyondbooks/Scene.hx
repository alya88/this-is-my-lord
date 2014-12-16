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
import flixel.system.FlxSound;

import deengames.io.GestureManager;

// The below block is for animated GIFs (yagp)
import com.yagp.GifDecoder;
import com.yagp.Gif;
import com.yagp.GifPlayer;
import com.yagp.GifPlayerWrapper;
import com.yagp.GifRenderer;
import openfl.Assets;

/**
* A common base state used for all scenes.
*/
class Scene extends FlxState
{
  private var gestureManager:GestureManager = new GestureManager();
  private var nextScene:Scene;
  private var previousScene:Scene;
  private var audio:FlxSound;
  private var audioButton:FlxSprite;
  private var showAudioButton:Bool = true;

  /**
  * Function that is called up when to state is created to set it up.
  */
  override public function create():Void
  {
    this.gestureManager.onGesture(Gesture.Swipe, onSwipe);
    if (this.showAudioButton) {
      this.audioButton = this.addAndCenter('assets/images/play-sound.png');
      audioButton.y = FlxG.height - audioButton.height - 32;
      MouseEventManager.add(audioButton, null, clickedAudioButton);
    }
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

  private function addAndCenterAnimation(spriteSheet:String, width:Int, height:Int, frames:Int, fps:Int) : FlxSprite
  {
    var sprite:FlxSprite = new FlxSprite();
    sprite.loadGraphic(spriteSheet, true, width, height);
    var range = [for (i in 0 ... frames) i];
    sprite.animation.add('loop', range, fps, true);
    sprite.animation.play('loop');
    add(sprite);
    centerOnScreen(sprite);
    return sprite;
  }

  private function addAndCenterAnimatedGif(file:String) {
    var gif:Gif = GifDecoder.parseByteArray(Assets.getBytes(file));
    // Gif is null? Make sure in Project.xml, you specify *.gif as type=binary
    var player:GifPlayer = new GifPlayer(gif);
    var wrapper:GifPlayerWrapper = new GifPlayerWrapper(player);
    FlxG.addChildBelowMouse(wrapper);
    wrapper.x = (FlxG.width - wrapper.width) / 2;
    wrapper.y = (FlxG.height - wrapper.height) / 2;
    // wrapper.scaleX/scaleY
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

  // Called by clicking on button
  private function clickedAudioButton(sprite:FlxSprite) : Void {
    playAudio();
  }

  // Called from subclass scenes
  private function loadAndPlay(file:String) : Void
  {
    if (this.audio != null) {
      this.audio.stop();
    }

    this.audio = FlxG.sound.load(file);
    this.playAudio();
  }

  // Called in scenes
  private function playAudio() : Void {
    if (this.audio != null) {
      this.audio.stop();
      this.audio.play(true); // force restart
    }
  }

  private function hideAudioButton() : Void
  {
    this.showAudioButton = false; // if constructor wasn't called yet
    if (this.audioButton != null) {
      this.audioButton.destroy();
    }
  }
}

package deengames.io;

import flixel.system.FlxSound;
import flixel.FlxG;

class AudioManager {
  private function new() { } // static class

  public static function play(name:String) : Void {
    FlxG.sound.load(name).play();
  }
}

package ui;

import flixel.FlxG;
import flixel.util.FlxPoint;
import flixel.FlxSprite;

import flixel.util.FlxColor;
using flixel.util.FlxSpriteUtil;

class BladeStreak {

  public var surface(default, null):FlxSprite = new FlxSprite(0, 0);
  private var previousPoints:List<FlxPoint> = new List<FlxPoint>();

  private static inline var MAX_POINTS:Int = 9; // consts
  private static inline var MAX_RADIUS = 11;

  public function new() {
  }

  public function addPoint(point:FlxPoint) {
    previousPoints.push(point);
    if (previousPoints.length > MAX_POINTS) {
      this.removeOldestPoint();
    } else {
      // Comment this line out to make points stick so you can debug this.
      redrawSurface();
    }
  }

  public function removeOldestPoint() : Void {
    previousPoints.remove(previousPoints.last());
    redrawSurface();
  }

  private function redrawSurface() {
    this.surface.makeGraphic(FlxG.width, FlxG.height, 0, true);
    var i:Int = 0;
    var lastPointSeen:FlxPoint = null;
    var colour:Int = 0x80FFFFFF;

    for (point in this.previousPoints) {
      var radius:Int = MAX_RADIUS - i;

      this.surface.drawCircle(point.x, point.y, radius, colour);

      if (lastPointSeen != null) {
        drawLine(point, lastPointSeen, radius, colour);
      }

      i++;
      lastPointSeen = point;
    }
  }

  // Bresenham's algorithm: http://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm
  private function drawLine(from:FlxPoint, to:FlxPoint, radius:Int, colour:Int) {
    var deltaX:Int = Std.int(to.x - from.x);
    var deltaY:Int = Std.int(to.y - from.y);

    // Short circuit on small distances
    if (Math.abs(deltaX + deltaY) <= radius) {
      return;
    }

    if (Math.abs(deltaX) >= Math.abs(deltaY)) {
      drawHorizontalLine(from, to, deltaX, deltaY, radius, colour);
    } else {
      drawVerticalLine(from, to, deltaX, deltaY, radius, colour);
    }
  }

  // Same as drawVerticalLine with x/y switched
  private function drawHorizontalLine(from:FlxPoint, to:FlxPoint, deltaX:Int, deltaY:Int, radius:Int, colour:Int) {
    var x:Int = Std.int(from.x);
    var y:Int = Std.int(from.y);

    var error:Float = 0;
    var deltaErr:Float = Math.abs(deltaY / deltaX);
    var gapBetweenPoints:Int = 3;

    var xIncrement:Int = deltaX > 0 ? gapBetweenPoints : -gapBetweenPoints;
    var yIncrement:Int = deltaY > 0 ? gapBetweenPoints : -gapBetweenPoints;

    // Can't rely on precision that x = to.x. Use approximation.
    while (Math.abs(x - to.x) >= gapBetweenPoints) {
      this.surface.drawCircle(x, y, radius, colour);
      error += deltaErr;
      if (error >= 0.5) {
        y += yIncrement;
        error -= 1.0;
      }
      x += xIncrement;
    }
  }

  // Same as drawHorizontalLine with x/y switched
  private function drawVerticalLine(from:FlxPoint, to:FlxPoint, deltaX:Int, deltaY:Int, radius:Int, colour:Int) {
    var x:Int = Std.int(from.x);
    var y:Int = Std.int(from.y);

    var error:Float = 0;
    var deltaErr:Float = Math.abs(deltaX / deltaY);
    var gapBetweenPoints:Int = Std.int(radius / 2);

    var xIncrement:Int = deltaX > 0 ? gapBetweenPoints : -gapBetweenPoints;
    var yIncrement:Int = deltaY > 0 ? gapBetweenPoints : -gapBetweenPoints;

    // Can't rely on precision that x = to.x. Use approximation.
    while (Math.abs(y - to.y) >= Math.abs(yIncrement)) {
      this.surface.drawCircle(x, y, radius, colour);
      error += deltaErr;
      if (error >= 0.5) {
        x += xIncrement;
        error -= 1.0;
      }
      y += yIncrement;
    }
  }
}

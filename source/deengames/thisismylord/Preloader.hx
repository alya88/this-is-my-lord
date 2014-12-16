package deengames.thisismylord;

import flash.Lib;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flixel.system.FlxPreloader;
import flash.events.Event;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;

// Adapted from https://gist.github.com/steverichey/8027205
class Preloader extends FlxPreloader
{
	// will only need to call this one item more than once
	private var _progressBar:Bitmap;
	static inline var BAR_HEIGHT:Int = 32;
	static inline var BAR_WIDTH:Int = 632;

	public function new()
	{
  	super(0, null);
		minDisplayTime = 1;
	}


	// this class mimics the look of the levelup bar from playstate but is drawn programmatically.
	// this is to prevent importing anything unnecessary, like PNG files.
	// as a result, everything is hand-coded to use 4x pixels, like the rest of the game.
	override private function create():Void
	{
		var _min = 0;
		#if FLX_NO_DEBUG
		_min = Std.int( minDisplayTime * 1000 );
		#end
		var border1:Bitmap = new Bitmap( new BitmapData( BAR_WIDTH - 8, 4, false, 0xff949494 ) );
		var border2:Bitmap = new Bitmap( new BitmapData( 4, BAR_HEIGHT - 8, false, 0xff949494 ) );
		var border3:Bitmap = new Bitmap( new BitmapData( 4, BAR_HEIGHT - 8, false, 0xff545454 ) );
		var border4:Bitmap = new Bitmap( new BitmapData( BAR_WIDTH - 8, 4, false, 0xff545454 ) );
		_progressBar = new Bitmap( new BitmapData( 1, BAR_HEIGHT - 8, false, 0xffE5240F ) );
		var progressBarShine = new Bitmap( new BitmapData( BAR_WIDTH - 16, 4, false ) );
		_progressBar.x = border4.x = border1.x = Std.int( Lib.current.stage.stageWidth / 2 ) - Std.int( border1.width / 2 );
		border1.y = Std.int( Lib.current.stage.stageHeight / 2 ) - Std.int( BAR_HEIGHT / 2 );
		border2.x = border1.x - 4;
		_progressBar.y = border3.y = border2.y = border1.y + 4;
		border3.x = border1.x + border1.width;
		border4.y = border2.y + border2.height;
		progressBarShine.x = border4.x + 4;
		progressBarShine.y = border3.y + 4;
		addChild( border1 );
		addChild( border2 );
		addChild( border3 );
		addChild( border4 );
		addChild( _progressBar );
		addChild( progressBarShine );

		var text = new TextField();
		text.defaultTextFormat = new TextFormat("Arial", 24, 0xffffff, false, false, false, "", "");
		text.embedFonts = false;
		text.selectable = false;
		text.multiline = false;
		text.x = border1.x + (BAR_WIDTH - text.width) / 2;
		text.y = border1.y - 48;
		text.width = 400;
		text.text = "Loading ...";
		addChild(text);
	}

	// fill the bar as progress continues. note that it only updates every 4 pixels, mimicking the 4x resolution
	// of the rest of the game.
	override public function update( Percent:Float ):Void
	{
		_progressBar.width = Std.int( Percent * ( BAR_WIDTH - 8 ) / 4 ) * 4;
	}
}

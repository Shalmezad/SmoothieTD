package ;
import flixel.FlxSprite;
import flixel.util.FlxPoint;
import flixel.util.FlxPath;

/**
 * ...
 * @author Shalmezad
 */
class Enemy extends FlxSprite
{
	public var path:FlxPath;
	public function new() 
	{
		super();
	}
	
	public function resetEnemy(type:String, x:Int, y:Int)
	{
		var size:FlxPoint = getSpriteSize(type);
		var graphicLoc:String = "assets/images/" + type + ".png";
		loadGraphic(graphicLoc, true, true, Std.int(size.x), Std.int(size.y));
		this.animation.add("walk", [0, 1], 5, true);
		this.animation.play("walk");
		this.health = getHealthForWave(Reg.PS.currentWave);
		reset(x - this.width/2, y - this.height/2);
	}
	
	public static function getHealthForWave(wave:Int)
	{
		return wave;
	}
	
	public function getSpriteSize(type:String):FlxPoint
	{
		if (type == "strawberry")
		{
			return new FlxPoint(16, 12);
		}
		else if (type == "banana")
		{
			//32x6
			return new FlxPoint(16, 6);
		}
		else if (type == "blueberry")
		{
			//20x8
			return new FlxPoint(10, 8);
		}
		else if (type == "peanutbutter")
		{
			//32x10
			return new FlxPoint(16, 10);
		}
		else if (type == "rasberry")
		{
			//32x10
			return new FlxPoint(16, 10);
		}
		else
		{
			return new FlxPoint(4, 4);
		}
	}
	
	override public function update()
	{
		super.update();
		if (path != null && alive && path.finished)
		{
			kill();
			//TODO: Bad stuff to player here.
			Reg.PS.killLife();
		}
	}
	
}
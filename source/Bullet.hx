package ;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxVelocity;

/**
 * ...
 * @author Shalmezad
 */
class Bullet extends FlxSprite
{
	private var _target:Enemy;
	public function new(target:Enemy) 
	{
		super();
		makeGraphic(3, 3, 0xFFDD0000);
		_target = target;
	}
	
	public function init(x:Float, y:Float, target:Enemy):Void
	{
		reset(x, y);
		_target = target;
	}
	
	override public function update():Void
	{
		if (!isOnScreen(FlxG.camera))
		{
			kill();
		}	
		if (_target.alive)
		{
			FlxVelocity.moveTowardsObject(this, _target, 200);
		}

		super.update();
	}
	
}
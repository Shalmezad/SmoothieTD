package ;
import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxPoint;
import flixel.util.FlxMath;

/**
 * ...
 * @author Shalmezad
 */
class Tower extends FlxSprite
{
	private var COOLDOWN_MAX:Int = 10;
	private var cooldown:Int;
	private var range:Int = 40;
	public function new() 
	{
		super();
		cooldown = COOLDOWN_MAX;
		loadGraphic("assets/images/tower1.png");
	}
	
	override public function update():Void
	{
		super.update();
		if (cooldown > 0)
		{
			cooldown--;
		}
		if (cooldown <= 0)
		{
			//see if there's an enemy nearby to shoot.
			var enemy:Enemy = Reg.PS.spawner.getNearest(x,y,range);
			if (enemy != null)
			{
				shoot(enemy);
			}
		}
	}
	
	private function shoot(enemy:Enemy):Void
	{
		cooldown = COOLDOWN_MAX;
		var bullet:Bullet = Reg.PS.bullets.recycle(Bullet);
		bullet.init(x, y, enemy);
	}
	

	
}
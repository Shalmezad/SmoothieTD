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
	private var fire_delay:Int = 40;
	private var cooldown:Int;
	public var rangeLevel:Int = 0;
	public function new() 
	{
		super();
		cooldown = fire_delay;
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
			var enemy:Enemy = Reg.PS.spawner.getNearest(x,y,GameCalculations.towerRange(this));
			if (enemy != null)
			{
				shoot(enemy);
			}
		}
	}
	
	
	
	private function shoot(enemy:Enemy):Void
	{
		cooldown = fire_delay;
		var bullet:Bullet = Reg.PS.bullets.recycle(Bullet);
		bullet.init(x, y, enemy);
	}
	

	
}
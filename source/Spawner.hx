package ;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxPoint;
import flixel.util.FlxPath;
import flixel.util.FlxMath;

/**
 * ...
 * @author Shalmezad
 */
class Spawner extends FlxTypedGroup<Enemy>
{
	var START_TILE_X:Int = 0;
	var START_TILE_Y:Int = 2;
	var END_TILE_X:Int = 15;
	var END_TILE_Y:Int = 5;
	
	private var MAX_COOLDOWN = 50;
	private var cooldown:Int;
	
	public function new() 
	{
		super();
		cooldown = MAX_COOLDOWN;
	}
	
	override public function update():Void
	{
		super.update();
		cooldown--;
		if (cooldown <= 0)
		{
			spawn();
		}
	}
	
	private function spawn():Void
	{		
		var enemy:Enemy = new Enemy();
		var startX:Int = START_TILE_X * Reg.PS.TILE_WIDTH;
		var startY:Int = START_TILE_Y * Reg.PS.TILE_HEIGHT;
		var endX:Int = END_TILE_X * Reg.PS.TILE_WIDTH;
		var endY:Int = END_TILE_Y * Reg.PS.TILE_HEIGHT;
		enemy.x = startX;
		enemy.y = startY;
		var path:Array<FlxPoint> = Reg.PS.tileMap.findPath(new FlxPoint(startX, startY), new FlxPoint(endX, endY));
		if (path == null) 
		{
			throw("No valid path! Does the tilemap provide a valid path from start to finish?");
		}
		FlxPath.start(enemy, path, 50, 0, true);
		add(enemy);
		
		cooldown = MAX_COOLDOWN;
	}
	
	public function getNearest(X:Float, Y:Float, range:Int):Enemy
	{
		var firstEnemy:Enemy = null;
		var myPoint = new FlxPoint(X, Y);
		var enemyPoint = new FlxPoint(0, 0);
		for (enemy in this.members)
		{
			if (enemy != null && enemy.alive)
			{
				enemyPoint.set(enemy.x, enemy.y);
				var distance:Float = FlxMath.getDistance(myPoint, enemyPoint);

				if (distance <= range)
				{
					firstEnemy = enemy;
					break;
				}
			}
		}

		return firstEnemy;
	}
	
}
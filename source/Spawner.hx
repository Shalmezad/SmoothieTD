package ;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxPoint;
import flixel.util.FlxPath;
import flixel.util.FlxMath;
import flixel.util.FlxRandom;
import flixel.FlxG;
import openfl.Assets;

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
	
	private var WAVES_DATA:Xml;
	private var currentWave:Xml;
	
	public function new() 
	{
		super();
		cooldown = MAX_COOLDOWN;
		WAVES_DATA = Xml.parse(Assets.getText("assets/data/waves.xml"));
		for (wave in WAVES_DATA.firstElement().elements())
		{
			//trace(wave);
			trace("Name: " + wave.get("name"));
			trace("Color: " + wave.get("color"));
			trace("___________________");
		}
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
		var enemy:Enemy = this.recycle(Enemy);// = new Enemy();
		var startX:Int = START_TILE_X * Reg.PS.TILE_WIDTH;
		var startY:Int = START_TILE_Y * Reg.PS.TILE_HEIGHT;
		var endX:Int = END_TILE_X * Reg.PS.TILE_WIDTH;
		var endY:Int = END_TILE_Y * Reg.PS.TILE_HEIGHT;
		var t:Int = FlxRandom.intRanged(0, 4);
		if (t == 0)
		{
			enemy.resetEnemy("banana",startX,startY);
		}
		else if(t == 1)
		{
			enemy.resetEnemy("blueberry",startX,startY);
		}
		else if(t == 2)
		{
			enemy.resetEnemy("peanutbutter",startX,startY);
		}
		else if(t == 3)
		{
			enemy.resetEnemy("rasberry",startX,startY);
		}
		else
		{
			enemy.resetEnemy("strawberry",startX,startY);
		}
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
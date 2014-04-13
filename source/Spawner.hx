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

enum SpawnerState {
	PRESPAWN;
	SPAWNING;
	WAITING_FOR_DEAD;
	COMPLETE;
}
	
class Spawner extends FlxTypedGroup<Enemy>
{
	var START_TILE_X:Int = 0;
	var START_TILE_Y:Int = 2;
	var END_TILE_X:Int = 15;
	var END_TILE_Y:Int = 5;
	
	private var WAVE_COOLDOWN = 60 * 3;
	private var MAX_COOLDOWN = 50;
	private var numToSpawn:Int;
	private var cooldown:Int;
	public var currentState:SpawnerState;
	
	private var WAVES_DATA:Xml;
	private var currentWave:Xml;
	
	public function new() 
	{
		super();
		cooldown = WAVE_COOLDOWN;
		numToSpawn = 12;
		currentState = PRESPAWN;
		WAVES_DATA = Xml.parse(Assets.getText("assets/data/waves.xml"));

		pickWave();
	}
	
	private function pickWave():Void
	{
		var waveCount:Int = 0;
		for (wave in WAVES_DATA.firstElement().elements())
		{
			waveCount++;
		}
		var waveChoice:Int = FlxRandom.intRanged(0, waveCount-1);
		for (wave in WAVES_DATA.firstElement().elements())
		{
			if (waveChoice == 0)
			{
				currentWave = wave;
			}
			waveChoice--;
		}
		trace(currentWave);
	}
	
	private function startWave():Void
	{
		pickWave();
		currentState = SPAWNING;
		cooldown = MAX_COOLDOWN;
		numToSpawn = 12;
	}
	
	override public function update():Void
	{
		super.update();
		if (currentState == PRESPAWN)
		{
			cooldown--;
			if (cooldown == 0)
			{
				startWave();
			}
		}
		else if (currentState == SPAWNING)
		{
			cooldown--;
			if (cooldown <= 0 && numToSpawn > 0)
			{
				spawn();
			}
		}
		else if (currentState == WAITING_FOR_DEAD)
		{
			if (countLiving() == 0)
			{
				currentState = COMPLETE;
				cooldown = WAVE_COOLDOWN;
			}
		}
		
	}
	
	private function pickEnemy():String
	{
		var enemyCount:Int = 0;
		for (enemy in currentWave.elements())
		{
			enemyCount++;
		}
		var enemyChoice:Int = FlxRandom.intRanged(0, enemyCount-1);
		trace(enemyChoice);
		
		for (enemy in currentWave.elements())
		{
			if (enemyChoice == 0)
			{
				return enemy.get("type");
			}
			enemyChoice--;
		}
		return "";
	}
	
	private function spawn():Void
	{		
		var enemy:Enemy = this.recycle(Enemy);// = new Enemy();
		var startX:Int = Std.int(START_TILE_X * Reg.PS.TILE_WIDTH + Reg.PS.TILE_WIDTH/2);
		var startY:Int = Std.int(START_TILE_Y * Reg.PS.TILE_HEIGHT + Reg.PS.TILE_HEIGHT/2);
		var endX:Int = Std.int(END_TILE_X * Reg.PS.TILE_WIDTH + Reg.PS.TILE_WIDTH/2);
		var endY:Int = Std.int(END_TILE_Y * Reg.PS.TILE_HEIGHT + Reg.PS.TILE_HEIGHT / 2);
		var enemyType:String = pickEnemy();
		enemy.resetEnemy(enemyType, startX, startY);

		var path:Array<FlxPoint> = Reg.PS.tileMap.findPath(new FlxPoint(startX, startY), new FlxPoint(endX, endY));
		if (path == null) 
		{
			throw("No valid path! Does the tilemap provide a valid path from start to finish?");
		}
		enemy.path = FlxPath.start(enemy, path, 50, 0, true);
		add(enemy);
		numToSpawn--;
		cooldown = MAX_COOLDOWN;
		if (numToSpawn == 0)
		{
			currentState = WAITING_FOR_DEAD;
		}
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
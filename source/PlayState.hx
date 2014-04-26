package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import flixel.util.FlxPath;
import openfl.Assets;
import flixel.group.FlxTypedGroup;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{

	public var TILE_WIDTH:Int = 20;
	public var TILE_HEIGHT:Int = 20;
	
	//TODO: Convert modes to enum if haXe allows it.
	var MODE_BUILD:Int = 1;		//attempting to build a tower
	var MODE_SELECTED:Int = 2;	//selected a tower (to upgrade/sell)
	var MODE_NONE:Int = 3; 		//No extra.
	var mouse_mode:Int;
	
	var TILE_BUILDABLE:Int = 2;
	
	public var tileMap:FlxTilemap;
	private var gui:GUI;
	
	var towers:FlxTypedGroup<Tower>;
	public var selectedTower:Tower;
	public var bullets:FlxTypedGroup<Bullet>;
	
	public var spawner:Spawner;
	
	public var lives:Int;
	
	public var currentWave:Int;
	
	public var currentScore:Int;
	
	public var money:Int;
	
	override public function create():Void
	{
		super.create();
		Reg.PS = this;
		
		lives = 3;
		currentWave = 0;
		currentScore = 0;
		money = 0;
		
		mouse_mode = MODE_BUILD;
		tileMap = new FlxTilemap();
		towers = new FlxTypedGroup<Tower>();
		bullets = new FlxTypedGroup<Bullet>();
		spawner = new Spawner();
		gui = new GUI();
		
		tileMap.loadMap(Assets.getText("assets/data/map1.csv"), "assets/images/tileset.png",TILE_WIDTH,TILE_HEIGHT,0,0,1,2);
		add(tileMap);
		add(towers);
		add(bullets);
		add(spawner);
		add(gui);
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		super.update();
		handleInput();
		handleLogic();
	}	
	
	private function handleInput():Void
	{
		if (FlxG.mouse.justReleased)
		{
			//get the tileX/Y.
			var tileX:Int = Std.int(FlxG.mouse.x / TILE_WIDTH);
			var tileY:Int = Std.int(FlxG.mouse.y / TILE_HEIGHT);
			if (mouse_mode == MODE_BUILD)
			{
				var success:Bool = attemptBuild(tileX, tileY,FlxG.mouse.x, FlxG.mouse.y);
				if (!success)
				{
					//we didn't build. Attempt selection.
					attemptSelection(FlxG.mouse.x, FlxG.mouse.y);
				}
			}
		}
	}
	
	private function handleLogic():Void
	{
		FlxG.overlap(bullets, spawner, bulletEnemyOverlap);
		if (spawner.currentState == COMPLETE)
		{
			spawner.currentState = PRESPAWN;
		}
	}
	
	private function bulletEnemyOverlap(bullet:Dynamic, enemy:Dynamic):Void
	{
		enemy.hurt(1);
		if (!enemy.alive)
		{
			currentScore += currentWave * 100;
			money += currentWave;
		}
		bullet.kill();
	}
	
	private function attemptBuild(tileX:Int, tileY:Int, mX:Float, mY:Float):Bool
	{
		//Check to see if the tile is BUILDABLE.
		var mouseArea:FlxSprite = new FlxSprite(mX, mY);
		if (tileMap.getTile(tileX, tileY) == TILE_BUILDABLE && !FlxG.overlap(mouseArea,towers))
		{
			//Add the tower here.
			var tower:Tower = new Tower();
			tower.x = tileX * TILE_WIDTH;
			tower.y = tileY * TILE_HEIGHT;
			towers.add(tower);
			return true;
		}
		return false;
	}
	
	private function attemptSelection(mX:Float, mY:Float):Bool
	{
		var mouseArea:FlxSprite = new FlxSprite(mX, mY);
		return FlxG.overlap(mouseArea,towers,selectTower);
	}
	
	public function selectTower(a:FlxObject, b:FlxObject)
	{
		if (Std.is(a, Tower))
		{
			selectedTower = cast(a,Tower);
		}
		else
		{
			selectedTower = cast(b,Tower);
		}
	}
	
	public function killLife():Void
	{
		if (lives > 0)
		{
			lives--;
			if (lives == 0)
			{
				//GAME OVER
				gameOver();
			}
		}
	}
	
	private function gameOver():Void
	{
		FlxG.switchState(new MenuState());
	}
}
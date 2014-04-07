package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import flixel.util.FlxPath;
import openfl.Assets;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	var START_TILE_X:Int = 0;
	var START_TILE_Y:Int = 2;
	var END_TILE_X:Int = 15;
	var END_TILE_Y:Int = 5;
	var TILE_WIDTH:Int = 20;
	var TILE_HEIGHT:Int = 20;
	
	//TODO: Convert modes to enum if haXe allows it.
	var MODE_BUILD:Int = 1;
	var mouse_mode:Int;
	
	var TILE_BUILDABLE:Int = 2;
	
	var tileMap:FlxTilemap;
	
	override public function create():Void
	{
		super.create();
		mouse_mode = MODE_BUILD;
		tileMap = new FlxTilemap();
		
		tileMap.loadMap(Assets.getText("assets/data/map1.csv"), "assets/images/tileset.png",TILE_WIDTH,TILE_HEIGHT,0,0,1,2);
		add(tileMap);
		
		var enemy:Enemy = new Enemy();
		var startX:Int = START_TILE_X * TILE_WIDTH;
		var startY:Int = START_TILE_Y * TILE_HEIGHT;
		var endX:Int = END_TILE_X * TILE_WIDTH;
		var endY:Int =END_TILE_Y * TILE_HEIGHT;
		enemy.x = startX;
		enemy.y = startY;
		var path:Array<FlxPoint> = tileMap.findPath(new FlxPoint(startX, startY), new FlxPoint(endX, endY));
		if (path == null) {
			throw("No valid path! Does the tilemap provide a valid path from start to finish?");
		}
		FlxPath.start(enemy, path, 50, 0, true);
		add(enemy);
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
		if (FlxG.mouse.justReleased)
		{
			if (mouse_mode == MODE_BUILD)
			{
				//get the tileX/Y.
				var tileX:Int = Std.int(FlxG.mouse.x / TILE_WIDTH);
				var tileY:Int = Std.int(FlxG.mouse.y / TILE_HEIGHT);
				//Check to see if the tile is BUILDABLE.
				if (tileMap.getTile(tileX, tileY) == TILE_BUILDABLE)
				{
					//Add the tower here.
					var tower:Tower = new Tower();
					tower.x = tileX * TILE_WIDTH;
					tower.y = tileY * TILE_HEIGHT;
					add(tower);
				}
			}
		}
	}	
}
package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.tile.FlxTilemap;
import openfl.Assets;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	public var TILE_WIDTH:Int = 20;
	public var TILE_HEIGHT:Int = 20;
	public var tileMap:FlxTilemap;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		tileMap = new FlxTilemap();
		tileMap.loadMap(Assets.getText("assets/data/menumap.csv"), "assets/images/tileset.png",TILE_WIDTH,TILE_HEIGHT,0,0,1,2);
		add(tileMap);
		
		//Add some branding text
		var brandText:FlxText = new FlxText(20, 20, 200, "Smoothie TD", 24);
		var brandText2:FlxText = new FlxText(21, 21, 200, "Smoothie TD", 24);
		brandText.color = 0xFF22EEEE;
		brandText2.color = 0xFF000000;
		add(brandText2);
		add(brandText);
		
		var startBtn:FlxButton = new FlxButton(50, 100, "Start Game!", startGame);
		add(startBtn);
	}
	
	private function startGame():Void
	{
		FlxG.switchState(new PlayState());
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
	}	
}
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
		
		var brandRect:FlxSprite = new FlxSprite(0, FlxG.height - 20);
		brandRect.makeGraphic(FlxG.width, 20, 0xFF000033);
		add(brandRect);
		var branding:FlxText = new FlxText(5, FlxG.height - 15, 200, "Shalmezad");
		branding.color = 0xFF00DDAA;
		add(branding);
		
		//Add some branding text
		var brandRect2:FlxSprite = new FlxSprite(0, 50);
		brandRect2.makeGraphic(FlxG.width, 50, 0xFF000033);
		add(brandRect2);
		var brandText:FlxText = new FlxText(0, 60, FlxG.width, "Smoothie TD", 24);
		brandText.alignment = "center";
		brandText.color = 0xFF00DDAA;
		add(brandText);
		
		var startBtn:FlxButton = new FlxButton(50, 120, "Start Game!", startGame);
		startBtn.x = FlxG.width / 2 - startBtn.width / 2;
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
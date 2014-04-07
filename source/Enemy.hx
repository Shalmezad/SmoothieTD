package ;
import flixel.FlxSprite;

/**
 * ...
 * @author Shalmezad
 */
class Enemy extends FlxSprite
{

	public function new() 
	{
		super();
		loadGraphic("assets/images/strawberry.png", true, true, 16, 12);
		this.animation.add("walk", [0, 1], 5, true);
		this.animation.play("walk");
		
	}
	
}
package ;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.FlxG;

/**
 * ...
 * @author Shalmezad
 */
class GUI extends FlxGroup
{
	private var scoreText:FlxText;
	private var waveText:FlxText;
	private var moneyText:FlxText;
	private var livesText:FlxText;
	private var guiRect:FlxSprite;
	
	public function new() 
	{
		super();
		
		guiRect = new FlxSprite(0, 0);
		guiRect.makeGraphic(FlxG.width, 20, 0xFF000033);
		add(guiRect);
		
		waveText = new FlxText(5, 5, 50, "Wave: 0");
		waveText.color = 0xFF00DDAA;
		add(waveText);
		
		livesText = new FlxText(55, 5, 50, "Lives: 3");
		livesText.color = 0xFF00DDAA;
		add(livesText);
		
		moneyText = new FlxText(110, 5, 50, "Money: 0");
		moneyText.color = 0xFF00DDAA;
		add(moneyText);
		
		scoreText = new FlxText(165, 5, 200, "Score: 0");
		scoreText.color = 0xFF00DDAA;
		add(scoreText);
		
	}
	
	override public function update():Void
	{
		super.update();
		waveText.text = "Wave: " + Reg.PS.currentWave;
		livesText.text = "Lives: " + Reg.PS.lives;
		moneyText.text = "Money: " + Reg.PS.money;
		scoreText.text = "Score: " + Reg.PS.currentScore;
	}
}
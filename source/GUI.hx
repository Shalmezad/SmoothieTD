package ;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.ui.FlxButton;

/**
 * ...
 * @author Shalmezad
 */
class GUI extends FlxGroup
{
	//Background rectangles
	private var topRect:FlxSprite;
	private var bottomRect:FlxSprite;
	
	//Misc stat text
	private var scoreText:FlxText;
	private var waveText:FlxText;
	private var moneyText:FlxText;
	private var livesText:FlxText;
	private var costText:FlxText;
	
	//Branding (so if it's stolen, at least my name's on it somewhere).
	private var branding:FlxText;
	
	private var buildButton:FlxButton;
	private var selector:FlxSprite;
	
	public function new() 
	{
		super();
		
		addRects();
		addText();
		addButtons();
		addOther();
	}
	
	private function addRects():Void
	{
		topRect = new FlxSprite(0, 0);
		topRect.makeGraphic(FlxG.width, 20, 0xFF000033);
		add(topRect);
		
		bottomRect = new FlxSprite(0, FlxG.height - 20);
		bottomRect.makeGraphic(FlxG.width, 20, 0xFF000033);
		add(bottomRect);
	}
	
	private function addText():Void
	{
		waveText = new FlxText(5, 5, 70, "Wave: 0");
		waveText.color = 0xFF00DDAA;
		add(waveText);
		
		livesText = new FlxText(75, 5, 70, "Lives: 3");
		livesText.color = 0xFF00DDAA;
		add(livesText);
		
		moneyText = new FlxText(150, 5, 70, "Money: 0");
		moneyText.color = 0xFF00DDAA;
		add(moneyText);
		
		scoreText = new FlxText(225, 5, 200, "Score: 0");
		scoreText.color = 0xFF00DDAA;
		add(scoreText);
		
		branding = new FlxText(5, FlxG.height - 15, 60, "Shalmezad");
		branding.color = 0xFF00DDAA;
		add(branding);
		
		costText = new FlxText(70, FlxG.height - 15, 60, "Cost: 0");
		costText.color = 0xFF00DDAA;
		add(costText);
	}
	
	private function addButtons():Void
	{
		buildButton = new FlxButton(70, FlxG.height - 20, "Build Tower", switchToBuild);
		buildButton.scale.x = .8;
		buildButton.scale.y = .8;
		add(buildButton);
	}
	
	private function addOther():Void
	{
		selector = new FlxSprite();
		selector.loadGraphic("assets/images/selector.png");
		selector.visible = false;
		add(selector);
	}
	
	override public function update():Void
	{
		super.update();
		updateText();
		
		if (Reg.PS.mouse_mode == MODE_BUILD)
		{
			costText.visible = true;
			buildButton.visible = false;
			selector.visible = false;
		}
		else if (Reg.PS.mouse_mode == MODE_SELECTED)
		{
			costText.visible = false;
			buildButton.visible = false;
			selector.visible = true;
			selector.x = Reg.PS.selectedTower.x;
			selector.y = Reg.PS.selectedTower.y;
		}
		else
		{
			costText.visible = false;
			buildButton.visible = true;
			selector.visible = false;
		}

	}
	
	private function updateText():Void
	{
		waveText.text = "Wave: " + Reg.PS.currentWave;
		livesText.text = "Lives: " + Reg.PS.lives;
		moneyText.text = "Money: " + Reg.PS.money;
		scoreText.text = "Score: " + Reg.PS.currentScore;
		costText.text = "Cost: " + GameCalculations.towerCost();
	}
	
	
	private function switchToBuild():Void
	{
		Reg.PS.mouse_mode = MODE_BUILD;
	}
}
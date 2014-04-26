package ;

/**
 * ...
 * @author Shalmezad
 */
class GameCalculations
{
	public static function towerCost():Int
	{
		return Std.int(Math.pow(2, Reg.PS.towers.countLiving()));
	}
	
}
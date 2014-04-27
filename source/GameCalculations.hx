package ;

/**
 * This handles all the math related calculations for the game,
 *   such as money, score, health, etc.
 * By changing the calculations here, you change how the game plays over time.
 * @author Shalmezad
 */
class GameCalculations
{
	/** 
	 * How much a tower costs 
	 * (currently 2^(number of towers))
	 * @return The cost for the tower
	 */
	public static function towerCost():Int
	{
		return Std.int(Math.pow(2, Reg.PS.towers.countLiving()));
	}
	
	/**
	 * How much health a mob spawns with
	 * (currently the wave #)
	 * @return The health of a new mob
	 */
	public static function mobSpawnHealth():Int
	{
		return Reg.PS.currentWave;
	}
	
	/**
	 * How much points a mob gives you on death
	 * (currently the wave # * 100)
	 * @return The points a mob kill will yield
	 */
	public static function mobScore():Int
	{
		return Reg.PS.currentWave * 100;
	}
	
	/**
	 * How much money a mob gives on death
	 * (currently the wave #)
	 * @return The money a mob will give on death
	 */
	public static function mobMoney():Int
	{
		return Reg.PS.currentWave;
	}
	
	/**
	 * How many mobs should spawn for a wave
	 * (currently set to 12)
	 * @return Number of mobs to spawn
	 */
	public static function mobsToSpawn():Int
	{
		return 12;
	}
	
	/**
	 * How much range a tower has
	 * @return Range in pixels for a tower
	 */
	public static function towerRange(tower:Tower):Int
	{
		return 25 * (tower.rangeLevel+1);
	}
	
}
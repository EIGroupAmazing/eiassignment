import java.util.*;
public class GetCookingTimeKFC {
	public String generate(String restaurantName, String packageName) {
		Random rand = new Random();
		return Integer.toString(rand.nextInt(60 - 20 + 1) + 20);
	}
}
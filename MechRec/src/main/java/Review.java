
public class Review {

	String userID;
	String postMessage;
	String postTimestamp;
	double rating;
	String carModel;
	String carMake;
	int carYear;
	String img;
	
	public Review(String userID, String postMessage, String postTimestamp, 
			double rating, String carModel, String carMake, int carYear,
			String img)
	{
		this.userID = userID;
		this.postMessage = postMessage;
		this.postTimestamp = postTimestamp;
		this.rating = rating;
		this.carModel = carModel;
		this.carMake = carMake;
		this.carYear = carYear;
		this.img = img;
	}
}

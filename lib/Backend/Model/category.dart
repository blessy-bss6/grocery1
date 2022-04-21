class Category {
  String? id;
  String? name;
  String? url;

  Category();

  Category.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['Id'].toString();
      name = jsonMap['Name'] ?? '';
      url = jsonMap['Url'] ?? '';
    } catch (e) {
      print(e);
    }
  }
}

class Deal {
  String? id;
  String? name;
  String? url;
  String? dealDetails;

  Deal();

  // {
  // "Id": 1,
  // "Name": "Tuesday Deals",
  // "Url": "https://lh3.googleusercontent.com/proxy/RJWMcus2-e6T9bY1bGxMkaik6lKgBvRpj97xYG9CZnpGlXackaQx8jQG4aaF8kjfyD7OmsO4EGbuGQcPgNVgldwIZl2nbUwZeH2KptgcfPg",
  // "DealDetails": "https://capetownadvisor.com/wp-content/uploads/2016/03/blowfish-monday-special-cta-350x233.jpg"
  // }

  Deal.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['Id'].toString();
      name = jsonMap['Name'] ?? '';
      url = jsonMap['Url'] ?? '';
      dealDetails = jsonMap['DealDetails'] ?? '';
    } catch (e) {
      print(e);
    }
  }
}

class Food {
  String? dishId;
  String? sellerId;
  String? dishName;
  String? url;
  String? price;
  String? modeOfDelivery;

  Food();

  // {
  // "SellerId": 200,
  // "DishId": 65,
  // "DishStatus": 2,
  // "ApprovedByName": "Asif Khan",
  // "ApprovedByEmail": "aakhan2021@gmail.com",
  // "DateCreated": "2021-10-21T05:40:38.000Z",
  // "DateUpdated": "2021-10-21T07:28:21.000Z",
  // "DishName": "Fish Curry",
  // "Description": "Fish Curry description",
  // "Price": "30.00",
  // "DiscountPercentage": "0.00",
  // "DiscountPrice": "0.00",
  // "Cuisine": "Punjabi",
  // "Dietary": "Non Veg",
  // "Spicy": "Hot",
  // "Allergen": "Nuts",
  // "Marking": "Halaal",
  // "Category": "Dinner",
  // "PreperationTime": 3,
  // "OtherHighlight": "give hot food",
  // "ServingDateFrom": "1899-11-30T00:00:00.000Z",
  // "ServingDateTo": "1899-11-30T00:00:00.000Z",
  // "ServingTimeFrom": "00:00:11",
  // "ServingTimeTo": "00:00:01",
  // "ServingsAvailable": 25,
  // "OrderLimit": 5,
  // "ModeOfDelivery": "Delivery",
  // "DishImageUrl1": "https://bvuploadbucket.s3.amazonaws.com/Test/dishImageUrl1-1634800089768.JPG",
  // "DishImageUrl2": "",
  // "DishImageUrl3": "",
  // "DishImageUrl4": "",
  // "MoreFoodInfo": 1,
  // "OnOff": 0
  // },

  Food.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      dishId = jsonMap['DishId'].toString();
      sellerId = jsonMap['SellerId'].toString();
      dishName = jsonMap['DishName'] ?? '';
      url = jsonMap['DishImageUrl1'] ?? '';
      price = jsonMap['Price'] ?? '';
      modeOfDelivery = jsonMap['ModeOfDelivery'] ?? '';
    } catch (e) {
      print(e);
    }
  }
}

class Seller {
  String? sellerId;
  String? kitchenName;
  String? url;
  String? price;

  Seller();

  // {
  // "SellerId": 200,
  // "FirstName": "Ravi ",
  // "LastName": "Kumar",
  // "Phone": "7894962006",
  // "TimeToContact": "01:00:00",
  // "Street": "Uttam Nagar Bus Terminal, Najafgarh Rd, Uttam Nagar",
  // "City": "Delhi",
  // "State": "Delhi",
  // "ZipCode": 110059,
  // "Country": "India",
  // "FoodPermit": 1,
  // "FoodPermitImageUrl": "https://bvuploadbucket.s3.us-east-2.amazonaws.com/Test/foodPermitImage-1634792822655.pdf",
  // "GovtIdImageUrl": "https://bvuploadbucket.s3.us-east-2.amazonaws.com/Test/govtIdImage-1634792822655.PNG",
  // "DisplayUrl": null,
  // "CuisineSpecialize": "Biryani",
  // "CookDay": "7",
  // "CookTimeFrom": "01:00:00",
  // "CookTimeTo": "03:00:00",
  // "ModeOfDelivery": "Delivery",
  // "Experience": 7,
  // "HearAboutUs": "Google.com",
  // "Interests": "Cooking",
  // "SellerReference": "",
  // "Latitude": "28.527582",
  // "Longitude": "77.0688951",
  // "Device": "All",
  // "KitchenName": "Homemade Cook",
  // "KitchenImageUrl": "https://i.ibb.co/zXCkfzR/Homemade-Cook.png",
  // "photoUrl": "",
  // "googleId": "",
  // "facebookId": "",
  // "gender": "",
  // "phone": ""
  // },

  Seller.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      sellerId = jsonMap['SellerId'].toString();
      kitchenName = jsonMap['KitchenName'] ?? '';
      url = jsonMap['KitchenImageUrl'] ?? '';
    } catch (e) {
      print(e);
    }
  }
}

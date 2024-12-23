# **Price Comparison System for Household Products**

## **Overview**

This project is a price comparison tool for household products, designed to allow users to efficiently compare prices from different supermarkets. It was developed as part of an integrative project for my Computer Engineering degree. The system provides daily updated price information and allows users to view prices by category, select products, and compare prices across supermarkets in their locality.

The platform is designed to be intuitive and responsive, adapting to both mobile and desktop devices. It also supports multilingual functionality, available in both Spanish and English.

## **Features**

- **Price Comparison**: Users can compare prices of household products across different supermarkets in their locality, with data updated daily.
- **Category Navigation**: Users can browse products by category and add them to a virtual shopping cart for comparison.
- **Price Filtering**: Users can enter their province and locality to compare prices, with a table showing the supermarket with the lowest prices.
- **Store Locations**: Users can view the locations of supermarket branches in their selected locality.
- **Multilingual Support**: Available in both Spanish and English.
- **Security**: The system ensures secure data transmission between the platform and the supermarkets, with token-based authentication for accessing supermarket data.

## **Technical Details**

### **Backend (Java)**

- **Web Services**: The backend is built using Java and integrates SOAP and REST web services to fetch price data from various supermarkets. This ensures flexibility and reusability of the system.
- **Security**: The system implements robust security measures, including token-based authentication to ensure that only authorized entities (INDEC) can access the supermarket data.
- **Batch Processing**: The system uses daily batch processes to fetch updated price and store information from the supermarket services.

### **Frontend (Angular)**

- **Responsive Design**: The frontend is built using Angular and is designed to be responsive, ensuring a seamless experience on both mobile and desktop devices.
- **User Interface**: The platform allows users to navigate product categories, add items to a shopping cart, and view price comparisons across supermarkets.
- **Localization**: The frontend supports both Spanish and English languages, ensuring accessibility for a wide range of users.

## **How It Works**

1. **User Interaction**: Users can navigate through product categories, select products of interest, and add them to their shopping cart.
2. **Price Comparison**: After entering their province and locality, users can compare prices across different supermarkets, with the system displaying the supermarket with the lowest price for each product.
3. **Store Location**: Users can view the location of supermarket branches within their selected locality.
4. **Data Fetching**: The system fetches price and store data daily from supermarket web services via batch processes.
5. **Security**: The system ensures that only authorized users (INDEC) can access the supermarket data by using token-based authentication.

## **Technologies Used**

- **Backend**: Java, SOAP, REST
- **Frontend**: Angular
- **Security**: Token-based Authentication
- **Multilingual Support**: Spanish, English
- **Batch Processing**: Daily updates for price and store information

## **Demo Video**
Haz clic en la imagen para ver la demostración del sistema:
[![Demo Video](https://img.youtube.com/vi/EpfEFaBTbxA/maxresdefault.jpg)](https://youtu.be/EpfEFaBTbxA)

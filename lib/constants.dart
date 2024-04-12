const bool isProduction = false; // !!!! false for local, true for production !!!!
const String productionUrl = 'https://dylannolan.com';
const String localUrl = 'http://localhost:8000';

const String apiUrl = isProduction ? productionUrl : localUrl;
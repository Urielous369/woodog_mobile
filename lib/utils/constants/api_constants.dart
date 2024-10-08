const baseUrl = "http://192.168.26.235:3000/"; // l'adresse ipv4 peut changer
// const baseUrl = "http://localhost:3000/";

const registerUrl = "${baseUrl}register";
const loginUrl = "${baseUrl}login";
const walkersUrl = "${baseUrl}walkers";
const suggestedWalkerUrl = "${baseUrl}suggested_walkers";

//---------- error ------------
const serverError = 'Server error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something went wrong, try again';
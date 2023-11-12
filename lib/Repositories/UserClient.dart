import 'package:crud_app/Models/AuthResponse.dart';
import 'package:crud_app/Models/LoginStructure.dart';
import 'package:crud_app/Models/User.dart';
import 'package:dio/dio.dart';
import 'DataService.dart';

const String BaseUrl = "https://cmsc2204-mobile-api.onrender.com/Auth";

class UserClient {
  final _dio = Dio(BaseOptions(baseUrl: BaseUrl));
  DataService _dataService = DataService();

  // Added functionality
  Future<bool> createUser(String username, String password, String email, String authLevel) async {
    try {
      var token = await _dataService.TryGetItem("token");
      if (token != null) {
        var response = await _dio.post("/AddUser",
          options: Options(
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
              "Authorization": "Bearer $token"
            },
          ),
          data: {
            'username': username,'password': password,'email': email,'authLevel': authLevel,
          },
        );

        return response.data['success'];
      } else {
        return false;
      }
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> deleteUser(String id) async {
    try {
      var token = await _dataService.TryGetItem("token");
      if (token != null) {
        var response = await _dio.post("/DeleteUserById",options: Options(
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
              "Authorization": "Bearer $token"
            },
          ),
          data: {
            'id': id
          },
        );
        return response.data['success'];
      }
      else {
        return false;
      }
    } catch (error) {
      print(error);
      return false;
    }
  }

  

  Future<AuthResponse?> Login(LoginStructure user) async {
    try {
      var response = await _dio.post("/login",
          data: {'username': user.username, 'password': user.password});

      var data = response.data['data'];

      var authResponse = new AuthResponse(data['userId'], data['token']);

      if (authResponse.token != null) {
        await _dataService.AddItem("token", authResponse.token);
      }

      return authResponse;
    } catch (error) {
      return null;
    }
  }

  Future<String> GetApiVersion() async {
    var response = await _dio.get("/ApiVersion");
    return response.data;
  }

  Future<List<User>?> GetUsersAsync() async {
    try {
      var token = await _dataService.TryGetItem("token");
      if (await _dataService.TryGetItem("token") != null) {
        var response = await _dio.get("/GetUsers",
            options: Options(headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
              "Authorization": "Bearer $token"
            }));
        List<User> users = new List.empty(growable: true);
        if (response != null) {
          for (var user in response.data) {
            users.add(User(user["Username"], user["Password"], user["Email"],
                user["AuthLevel"]));
          }
          return users;
        }
      } else {
        return null;
      }
    } catch (error) {
      print(error);
      return null;
    }
  }
}

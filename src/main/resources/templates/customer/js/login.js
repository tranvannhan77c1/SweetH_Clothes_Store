var app = angular.module('loginApp', []);

app.controller('loginController', ['$scope', '$http', function($scope, $http) {
    $scope.cart = [];
    $scope.username = '';
    $scope.password = '';
    $scope.errorMessage = '';  // Biến để lưu thông báo lỗi

    // Load giỏ hàng từ local storage khi trang được tải
    var storedCart = localStorage.getItem('cart');
    if (storedCart) {
        $scope.cart = JSON.parse(storedCart);
    }

    $scope.login = function() {
        var loginData = {
            username: $scope.username,
            password: $scope.password
        };

        $http.post('http://localhost:8080/api/v1/auth/login', loginData)
            .then(function(response) {
                // Handle success
                console.log('Login successful:', response.data);

                // Store the JWT token
                var token = response.data.accessToken;
                localStorage.setItem('jwtToken', JSON.stringify(token));
                var accountDetail = response.data.account;
                localStorage.setItem('accountDetail', JSON.stringify(accountDetail));

                // Redirect to a secure page or perform other actions
                window.location.href = '../index.html';
            })
            .catch(function(error) {
                // Handle error
                console.error('Login failed:', error);
                $scope.errorMessage = 'Tài khoản hoặc mật khẩu không đúng.';
            });
    };
}]);

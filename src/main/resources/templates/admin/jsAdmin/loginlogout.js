angular.module('app').controller('loginlogoutController', ['$scope', '$http', function ($scope, $http) {
    $scope.username = '';
    $scope.password = '';
    $scope.errorMessage = '';
    $scope.message = 'Đăng xuất thành công.';

    $scope.login = function () {
        var loginData = {
            username: $scope.username,
            password: $scope.password
        };

        $http.post('http://localhost:8080/api/v1/auth/login', loginData)
            .then(function (response) {
                // Handle success
                console.log('Login successful:', response.data);

                // Store the JWT token
                var token = response.data.accessToken;
                localStorage.setItem('jwtToken', JSON.stringify(token));
                var accountDetail = response.data.account;
                localStorage.setItem('accountDetail', JSON.stringify(accountDetail));
                if (accountDetail.role == "Customer"){
                    $scope.errorMessage = 'Bạn không có quyền truy cập.';
                }else {
                    window.location.href = '../index.html';
                }
            })
            .catch(function (error) {
                // Handle error
                console.error('Login failed:', error);
                $scope.errorMessage = 'Tài khoản hoặc mật khẩu không đúng.';
            });
    };

    $scope.logout = function() {
        localStorage.removeItem('jwtToken');
        localStorage.removeItem('accountDetail');
        $scope.isLogin = false;
        // redirect to login page or reload the page
        window.location.href = '../pages/login.html';
    };
}]);

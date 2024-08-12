var app = angular.module('profileApp', []);

app.controller('ProfileController', ['$scope', '$http', '$window', function($scope, $http) {
    $scope.cart = [];
    $scope.userInfo = null;
    
    // Load giỏ hàng từ local storage khi trang được tải
    var storedCart = localStorage.getItem('cart');
    if (storedCart) {
        $scope.cart = JSON.parse(storedCart);
    }
    var loginToken = localStorage.getItem('jwtToken');
    $scope.isLogin = loginToken !== null && loginToken.length > 0;

    var storedUserInfo = localStorage.getItem('accountDetail');
    if (storedUserInfo) {
        $scope.userInfo = JSON.parse(storedUserInfo);
    }

    $scope.userOrders = [];
    $scope.fetchOrder = function() {
        // Get the token and remove double quotes
        const token = loginToken.replace(/"/g, '').trim();
    
        $http({
            method: 'GET',
            url: "http://localhost:8080/api/v1/customer/orders/userOrder",
            params: { userID: $scope.userInfo.id },
            headers: {
                'Authorization': 'Bearer ' + token
            }
        })
        .then(function(response) {
            // Success callback
            $scope.userOrders = response.data; // Assign response data
        })
        .catch(function(error) {
            // Error callback
            console.error('Error fetching orders:', error);
            $scope.userOrders = null;
        });
    };

    $scope.fetchOrder();

    $scope.logout = function() {
        localStorage.removeItem('jwtToken');
        localStorage.removeItem('accountDetail')
        $scope.isLogin = false;
        // redirect to login page or reload the page
        window.location.href = '../index.html';
    };
    
}]);
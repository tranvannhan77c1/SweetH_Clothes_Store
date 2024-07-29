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

    $scope.logout = function() {
        localStorage.removeItem('jwtToken');
        $scope.isLogin = false;
        // redirect to login page or reload the page
        window.location.href = '../index.html';
    };
    
}]);
var app = angular.module('singleProductApp', []);

app.controller('SingleProductController', ['$scope', '$http', '$location', function ($scope, $http, $location) {
    $scope.cart = [];
    $scope.showSuccessAlert = false;

    $scope.addToCart = function (product) {
        let existingProductIndex = $scope.cart.findIndex(item => item.id === product.id);

        if (existingProductIndex !== -1) {
            $scope.cart[existingProductIndex].quantity++;
        } else {
            product.quantity = 1;
            $scope.cart.push(product);
        }

        localStorage.setItem('cart', JSON.stringify($scope.cart));
        $('#successModal').modal('show');
    };

    $scope.increaseQuantity = function (item) {
        let index = $scope.cart.findIndex(product => product.id === item.id);

        if (index !== -1) {
            $scope.cart[index].quantity++;
            localStorage.setItem('cart', JSON.stringify($scope.cart));
        }
    };

    var storedCart = localStorage.getItem('cart');
    if (storedCart) {
        $scope.cart = JSON.parse(storedCart);
    }

    var loginToken = localStorage.getItem('jwtToken');
    $scope.isLogin = loginToken !== null && loginToken.length > 0;

    function getQueryParams() {
        var params = {};
        var parts = $location.absUrl().split('?')[1].split('&');
        for (var i = 0; i < parts.length; i++) {
            var param = parts[i].split('=');
            params[param[0]] = param[1];
        }
        return params;
    }

    var params = getQueryParams();
    var productId = params['id'];

    $http.get('http://localhost:8080/api/v1/product/public/' + productId)
        .then(function (response) {
            $scope.product = response.data;

            // Ảnh chính mặc định
            $scope.mainImage = $scope.product.thumbnailImage;
        })
        .catch(function (error) {
            console.error('Error fetching product data:', error);
        });

    // Phương thức để thay đổi ảnh chính
    $scope.setMainImage = function(image) {
        $scope.mainImage = image;
    };
}]);

var app = angular.module('singleProductApp', []);

app.controller('SingleProductController', ['$scope', '$http', '$location', function($scope, $http, $location) {
    $scope.cart = [];
    $scope.quantity = 1; // Số lượng mặc định
    $scope.showSuccessMessage = false;

    $scope.addToCart = function(product) {
        let existingProductIndex = $scope.cart.findIndex(item => item.id === product.id);

        if (existingProductIndex !== -1) {
            $scope.cart[existingProductIndex].quantity += $scope.quantity;
        } else {
            product.quantity = $scope.quantity;
            $scope.cart.push(product);
        }

        localStorage.setItem('cart', JSON.stringify($scope.cart));

        // Hiển thị toast thông báo thành công
        $scope.showSuccessMessage = true;

        // Ẩn toast sau 3 giây
        setTimeout(function() {
            $scope.$apply(function() {
                $scope.showSuccessMessage = false;
            });
        }, 3000); // Thay đổi thời gian nếu cần
    };

    $scope.increaseQuantity = function(product) {
        $scope.quantity++;
        saveQuantity(); // Lưu số lượng vào localStorage
    };

    $scope.decreaseQuantity = function(product) {
        if ($scope.quantity > 1) {
            $scope.quantity--;
            saveQuantity(); // Lưu số lượng vào localStorage
        }
    };

    function saveQuantity() {
        localStorage.setItem('productQuantity', $scope.quantity);
    }

    function loadQuantity() {
        var savedQuantity = localStorage.getItem('productQuantity');
        if (savedQuantity) {
            $scope.quantity = parseInt(savedQuantity, 10);
        }
    }

    loadQuantity();

    var storedCart = localStorage.getItem('cart');
    if (storedCart) {
        $scope.cart = JSON.parse(storedCart);
    }

    var loginToken = localStorage.getItem('jwtToken');
    $scope.isLogin = loginToken !== null && loginToken.length > 0;

    function getQueryParams() {
        var params = {};
        var queryString = $location.absUrl().split('?')[1];
        if (queryString) {
            var parts = queryString.split('&');
            for (var i = 0; i < parts.length; i++) {
                var param = parts[i].split('=');
                params[param[0]] = decodeURIComponent(param[1]);
            }
        }
        return params;
    }

    var params = getQueryParams();
    var productId = params['id'];

    $http.get('http://localhost:8080/api/v1/product/public/' + productId)
        .then(function(response) {
            $scope.product = response.data;

            // Ảnh chính mặc định
            $scope.mainImage = $scope.product.thumbnailImage;
        })
        .catch(function(error) {
            console.error('Error fetching product data:', error);
        });

    // Phương thức để thay đổi ảnh chính
    $scope.setMainImage = function(image) {
        $scope.mainImage = image;
    };
}]);
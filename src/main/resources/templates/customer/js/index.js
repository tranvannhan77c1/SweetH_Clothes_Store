var app = angular.module('indexApp', []);

app.controller('ProductController', ['$scope', '$http', function($scope, $http) {
    $scope.products = [];
    $scope.cart = [];
    $scope.showSuccessAlert = false;

    $http.get('http://localhost:8080/api/v1/product/public/landing?page=1&limit=8')
        .then(function(response) {
            $scope.products = response.data.content;
            console.log(response.data.content[0].thumbnailImage)
        })
        .catch(function(error) {
            console.error('Error fetching products:', error);
        });
    $scope.addToCart = function(product) {
        // Kiểm tra xem sản phẩm đã có trong giỏ hàng chưa
        let existingProductIndex = $scope.cart.findIndex(item => item.id === product.id);

        if (existingProductIndex !== -1) {
            // Nếu sản phẩm đã có trong giỏ hàng, tăng số lượng lên 1
            $scope.cart[existingProductIndex].quantity++;
        } else {
            // Nếu sản phẩm chưa có trong giỏ hàng, thêm sản phẩm vào giỏ hàng với số lượng là 1
            product.quantity = 1;
            $scope.cart.push(product);
        }

        // Lưu giỏ hàng mới vào local storage
        localStorage.setItem('cart', JSON.stringify($scope.cart));
        $('#successModal').modal('show');
    };
    $scope.removeFromCart = function(item) {
        // Tìm index của sản phẩm trong giỏ hàng
        let index = $scope.cart.findIndex(product => product.id === item.id);

        // Nếu tìm thấy sản phẩm trong giỏ hàng
        if (index !== -1) {
            // Giảm số lượng của sản phẩm đi 1
            $scope.cart[index].quantity--;

            // Nếu số lượng giảm xuống 0 hoặc dưới 0, loại bỏ sản phẩm khỏi giỏ hàng
            if ($scope.cart[index].quantity <= 0) {
                $scope.cart.splice(index, 1);
            }

            // Cập nhật lại local storage
            localStorage.setItem('cart', JSON.stringify($scope.cart));
        }
    };


    // Load giỏ hàng từ local storage khi trang được tải
    var storedCart = localStorage.getItem('cart');
    if (storedCart) {
        $scope.cart = JSON.parse(storedCart);
    }
}]);
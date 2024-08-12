var app = angular.module('indexApp', []);

app.controller('ProductController', ['$scope', '$http', function ($scope, $http) {
    $scope.products = [];
    $scope.cart = [];
    $scope.showSuccessMessage = false;
    $scope.modalQuantity = 1;
    $scope.selectedProduct = null;
    $scope.showSizeAlert = false;


    // Lấy danh sách sản phẩm từ backend
    $http.get('http://localhost:8080/api/v1/product/public/landing?page=1&limit=8')
        .then(function (response) {
            $scope.products = response.data.content;
        })
        .catch(function (error) {
            console.error('Error fetching products:', error);
        });

    // Hàm hiển thị modal thành công
    $scope.showSuccessModal = function (product) {
        $scope.selectedProduct = product;
        $('#successModal').modal('show');
    };
    $scope.increaseModalQuantity = function () {
        $scope.modalQuantity++;
    };

    $scope.decreaseModalQuantity = function () {
        if ($scope.modalQuantity > 1) {
            $scope.modalQuantity--;
        }
    };
    $scope.selectedSize = null;
    $scope.selectSize = function(size) {
        console.log('Size selected:', size); // Log selected size
        $scope.selectedSize = size;
    };
    // Hàm thêm sản phẩm vào giỏ hàng và lưu vào local storage
    $scope.addToCart = function (product, quantity) {
        // Kiểm tra nếu chưa chọn kích thước
        if (!$scope.selectedSize) {
            // Hiển thị thông báo yêu cầu chọn kích thước
            $scope.showSizeAlert = true;

            // Ẩn thông báo sau 3 giây
            setTimeout(() => {
                $scope.showSizeAlert = false;
                $scope.$apply(); // Cập nhật scope sau khi thay đổi
            }, 3000);
            return; // Kết thúc hàm nếu chưa chọn kích thước
        }

        // Tìm sản phẩm với kích thước đã chọn trong giỏ hàng
        let existingProductAndSizeIndex = $scope.cart.findIndex(item =>
            item.id === product.id && item.size === $scope.selectedSize
        );

        if (existingProductAndSizeIndex !== -1) {
            // Nếu sản phẩm đã có trong giỏ hàng, tăng số lượng
            $scope.cart[existingProductAndSizeIndex].quantity += quantity;
        } else {
            // Nếu sản phẩm chưa có, thêm sản phẩm mới vào giỏ hàng
            let productToAdd = {
                ...product, // Sao chép thông tin sản phẩm
                quantity: quantity,
                size: $scope.selectedSize
            };
            $scope.cart.push(productToAdd);
        }

        // Lưu giỏ hàng vào localStorage
        localStorage.setItem('cart', JSON.stringify($scope.cart));

        // Hiển thị thông báo thành công
        $scope.showSuccessMessage = true;

        // Ẩn thông báo thành công sau 3 giây
        setTimeout(() => {
            $scope.showSuccessMessage = false;
            $scope.$apply();
        }, 3000);
    };


    // Load giỏ hàng từ local storage khi trang được tải
    var storedCart = localStorage.getItem('cart');
    if (storedCart) {
        $scope.cart = JSON.parse(storedCart);
    }

    var loginToken = localStorage.getItem('jwtToken');
    $scope.isLogin = loginToken !== null && loginToken.length > 0;

    // Đặt hình ảnh chính của sản phẩm
    $scope.setMainImage = function (image) {
        $scope.selectedProduct.thumbnailImage = image;
    };
}]);

var app = angular.module('categoryApp', []);

app.controller('ProductController', ['$scope', '$http', function ($scope, $http) {
    $scope.products = [];
    $scope.cart = [];
    $scope.showSuccessAlert = false;
    $scope.query = '';
    $scope.currentPage = 1;
    $scope.totalPages = 1;
    $scope.pageSize = 9;
    $scope.productAmount = 0;
    $scope.colors = [];
    $scope.colorsWithQuantity = [];
    $scope.selectedColor = null;
    $scope.items = [];
    $scope.itemsWithQuantity = [];
    $scope.selectedItem = null;
    $scope.visibleColors = [];
    $scope.maxVisibleColors = 5;
    $scope.showAllColors = false;
    $scope.selectedProduct = null;

    // Function to log the search query
    $scope.searching = function () {
        console.log($scope.query);
    };

    // Lấy data sản phẩm từ backend
    $scope.getProducts = function (page) {
        const apiUrl = `http://localhost:8080/api/v1/product/public/landing?page=${page}&limit=${$scope.pageSize}`;

        $http.get(apiUrl)
            .then(response => {
                $scope.products = response.data.content;
                $scope.productAmount = response.data.totalElements;
                $scope.totalPages = Math.ceil($scope.productAmount / $scope.pageSize);
            })
            .catch(error => {
                console.error('Error fetching products:', error);
            });
    };

    // Gọi sản phẩm 
    $scope.getProducts($scope.currentPage - 1);

    // Lấy màu để làm filter
    $scope.fetchColors = function () {
        $http.get("http://localhost:8080/api/v1/product/public/allColor")
            .then(response => {
                $scope.colors = response.data;
                $scope.colors.forEach(color => {
                    $scope.calculateColorQuantity(color);
                });
            })
            .catch(error => {
                console.error('Error fetching colors:', error);
            });
    };

    // Tính số lượng sản phẩm mỗi màu
    $scope.calculateColorQuantity = function (color) {
        const apiUrl = `http://localhost:8080/api/v1/product/public/color/${color}?page=${0}&limit=${1000000}`;

        $http.get(apiUrl)
            .then(response => {
                const quantity = response.data.totalElements;
                $scope.colorsWithQuantity.push({ color: color, quantity: quantity });
                $scope.updateVisibleColors();
            })
            .catch(error => {
                console.error('Error fetching products by color:', error);
            });
    };

    // Cập nhật danh sách màu hiển thị dựa trên trạng thái "Xem tất cả màu"
    $scope.updateVisibleColors = function () {
        if ($scope.showAllColors) {
            $scope.visibleColors = $scope.colorsWithQuantity;
        } else {
            $scope.visibleColors = $scope.colorsWithQuantity.slice(0, $scope.maxVisibleColors);
        }
    };
    $scope.toggleShowAllColors = function () {
        $scope.showAllColors = !$scope.showAllColors;
        $scope.updateVisibleColors();
    };
    // Lọc sản phẩm dựa trên màu đã chọn
    $scope.filterProductsByColor = function (color) {
        $scope.selectedColor = color;
        $scope.currentPage = 1; // Reset to first page
        $scope.filterProducts($scope.currentPage - 1);
        smoothRoll();
    };

    // Lấy item để làm filter
    $scope.fetchItems = function () {
        $http.get("http://localhost:8080/api/v1/product/public/allItem")
            .then(response => {
                $scope.items = response.data;
                $scope.items.forEach(item => {
                    $scope.calculateItemQuantity(item);
                });
            })
            .catch(error => {
                console.error('Error fetching items:', error);
            });
    };

    // Tính số lượng sản phẩm mỗi item
    $scope.calculateItemQuantity = function (item) {
        const apiUrl = `http://localhost:8080/api/v1/product/public/item/${item.id}?page=${0}&limit=${1000000}`;

        $http.get(apiUrl)
            .then(response => {
                const quantity = response.data.totalElements;
                $scope.itemsWithQuantity.push({ id: item.id, name: item.name.trim(), quantity: quantity });
            })
            .catch(error => {
                console.error('Error fetching products by item:', error);
            });
    };

    // Lọc sản phẩm dựa trên item đã chọn
    $scope.filterProductsByItem = function (item) {
        $scope.selectedItem = item;
        $scope.filterProducts($scope.currentPage - 1);
        smoothRoll();
    };

    $scope.filterProducts = function (page) {
        let apiUrl = "http://localhost:8080/api/v1/product/public";
        if ($scope.selectedColor && $scope.selectedItem) {
            apiUrl += `/color/${$scope.selectedColor}/item/${$scope.selectedItem}?page=${page}&limit=${$scope.pageSize}`;
        } else if ($scope.selectedColor) {
            apiUrl += `/color/${$scope.selectedColor}?page=${page}&limit=${$scope.pageSize}`;
        } else if ($scope.selectedItem) {
            apiUrl += `/item/${$scope.selectedItem}?page=${page}&limit=${$scope.pageSize}`;
        } else {
            $scope.getProducts($scope.currentPage - 1);
        }

        $http.get(apiUrl)
            .then(response => {
                $scope.products = response.data.content;
                $scope.productAmount = response.data.totalElements;
                $scope.totalPages = Math.ceil($scope.productAmount / $scope.pageSize);
            })
            .catch(error => {
                console.error('Error fetching products by item:', error);
            });
    };

    // Hàm chuyển trang
    $scope.changePage = function (page) {
        if (page >= 1 && page <= $scope.totalPages) {
            $scope.currentPage = page;

            $scope.filterProducts($scope.currentPage - 1);
        }

        smoothRoll();
    };

    // Gọi màu sản phẩm
    $scope.fetchColors();
    // Gọi item sản phẩm
    $scope.fetchItems();

    $scope.showSuccessModal = function (product) {
        $scope.selectedProduct = product;
        $('#successModal').modal('show');
    };

    // Hàm thêm sản phẩm vào giỏ hàng và lưu vào local storage
    $scope.addToCart = function (product) {
        let existingProductIndex = $scope.cart.findIndex(item => item.id === product.id);

        if (existingProductIndex !== -1) {
            $scope.cart[existingProductIndex].quantity++;
        } else {
            product.quantity = 1;
            $scope.cart.push(product);
        }

        localStorage.setItem('cart', JSON.stringify($scope.cart));
    };

    $scope.increaseQuantity = function (item) {
        let index = $scope.cart.findIndex(product => product.id === item.id);

        if (index !== -1) {
            $scope.cart[index].quantity++;
            localStorage.setItem('cart', JSON.stringify($scope.cart));
        }
    };

    $scope.decreaseQuantity = function (item) {
        let index = $scope.cart.findIndex(product => product.id === item.id);

        if (index !== -1) {
            if ($scope.cart[index].quantity > 1) {
                $scope.cart[index].quantity--;
            } else {
                $scope.cart.splice(index, 1);
            }
            localStorage.setItem('cart', JSON.stringify($scope.cart));
        }
    };

    $scope.clearCart = function () {
        $scope.cart = [];
        localStorage.removeItem('cart');
    };

    $scope.calculateTotal = function () {
        return $scope.cart.reduce((total, item) => {
            return total + item.price * item.quantity;
        }, 0);
    };

    var storedCart = localStorage.getItem('cart');
    if (storedCart) {
        $scope.cart = JSON.parse(storedCart);
    }

}]);

// Làm chẵn số tiền trong giỏ hàng
app.filter('floor', function () {
    return function (input) {
        if (isNaN(input)) {
            console.log("string");
            return input;
        }
        return Math.floor(input * 100) / 100;
    };
});

// Tạo hiệu ứng lướt mượt hơn
function smoothRoll() {
    window.scrollTo({
        top: 0,
        behavior: "smooth"
    });
}

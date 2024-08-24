angular.module('app')
    .controller('ProductController', ['$scope', '$timeout', 'ProductService', 'CategoryService', 'ItemService', function ($scope, $timeout, ProductService, CategoryService, ItemService) {

        $scope.pageSize = 294;
        $scope.paginationButtons = [];
        $scope.totalPages = 1;
        $scope.currentPage = 0;
        $scope.items = [];
        $scope.categories = [];
        $scope.products = [];
        $scope.product = {};
        $scope.isEditMode = false;

        $scope.clothingSizes = [
            { size: 'S', selected: false, quantity: 0 },
            { size: 'M', selected: false, quantity: 0 },
            { size: 'L', selected: false, quantity: 0 },
            { size: 'XL', selected: false, quantity: 0 }
        ];

        $scope.shoeSizes = [
            { size: '36', selected: false, quantity: 0 },
            { size: '37', selected: false, quantity: 0 },
            { size: '38', selected: false, quantity: 0 },
            { size: '39', selected: false, quantity: 0 }
        ];

        $scope.freeSize = { selected: false, quantity: 0 };

        function getProductsPage(page, size) {
            return ProductService.getProductsPage(page, size)
                .then(function (data) {
                    $scope.products = data.content;
                    $scope.totalPages = data.totalPages;
                    initializePagination();
                })
                .catch(function (error) {
                    console.error('Error fetching products', error);
                });
        };

        function getAllItems() {
            ItemService.getAllItems()
                .then(function (data) {
                    $scope.items = data;
                })
                .catch(function (error) {
                    console.error('Error fetching items', error);
                });
        }


        $scope.onItemChange = function(itemId) {
            if (itemId) {
                CategoryService.getCategoriesByItemId(itemId)
                    .then(function (data) {
                        $scope.categories = data;
                    })
                    .catch(function (error) {
                        console.error('Error fetching categories', error);
                    });

                // Cập nhật các size dựa trên itemId
                if (itemId == 1) {
                    $scope.productSizes = $scope.clothingSizes;
                } else if (itemId == 2 || itemId == 3 || itemId == 5) {
                    $scope.productSizes = [$scope.freeSize];
                } else if (itemId == 4) {
                    $scope.productSizes = $scope.shoeSizes;
                }
            } else {
                $scope.categories = [];
                $scope.productSizes = [];
            }
        };

        function loadData() {
            getProductsPage($scope.currentPage, $scope.pageSize);
            getAllItems();
        }

        $scope.editProduct = function (id) {
            ProductService.getProductById(id)
                .then(function (data) {
                    $scope.product = data;
                    $scope.isEditMode = true;
                    $('#addProductModal').modal('show');
                    $scope.onItemChange($scope.product.itemId);
                    console.log($scope.product);
                    // Cập nhật trạng thái size
                    if ($scope.product.productSizes) {
                        $scope.productSizes.forEach(size => {
                            let productSize = $scope.product.productSizes.find(ps => ps.size == size.size);
                            if (productSize) {
                                size.selected = true;
                                size.quantity = productSize.quantity;
                            }
                        });
                    }
                })
                .catch(function (error) {
                    console.error('Error fetching product', error);
                });
        };

        $scope.createProduct = function () {
            ProductService.createProduct($scope.product)
                .then(function (data) {
                    getProductsPage($scope.currentPage, $scope.pageSize)
                        .then(function () {
                            $scope.goToPage($scope.totalPages - 1);
                            $scope.product = data;
                        });
                })
                .catch(function (error) {
                    console.error('Error creating product', error);
                });
        };

        $scope.updateProduct = function () {
            ProductService.updateProduct($scope.product.id, $scope.product)
                .then(function (data) {
                    $scope.product = data;
                    getProductsPage($scope.currentPage, $scope.pageSize);
                })
                .catch(function (error) {
                    console.error('Error updating product', error);
                });
        };

        $scope.deleteProduct = function (id) {
            ProductService.deleteProduct(id)
                .then(function () {
                    getProductsPage($scope.currentPage, $scope.pageSize);
                })
                .catch(function (error) {
                    console.error('Error deleting product', error);
                });
        };

        $scope.resetForm = function (){
            $scope.product = {};
            $scope.isEditMode = false;
        };

        var initializePagination = function () {
            $scope.paginationButtons = [];
            var start = Math.max(0, $scope.currentPage - 1);
            var end = Math.min($scope.totalPages - 1, start + 2);
            for (var i = start; i <= end; i++) {
                $scope.paginationButtons.push(i);
            }
        };

        $scope.goToPage = function (page) {
            if (page >= 0 && page < $scope.totalPages) {
                $scope.currentPage = page;
                getProductsPage($scope.currentPage, $scope.pageSize);
            }
        };

        $scope.nextPage = function () {
            if ($scope.currentPage < $scope.totalPages - 1) {
                $scope.currentPage++;
                getProductsPage($scope.currentPage, $scope.pageSize);
                if ($scope.currentPage > 1) {
                    initializePagination();
                }
            }
        };

        $scope.previousPage = function () {
            if ($scope.currentPage > 0) {
                $scope.currentPage--;
                getProductsPage($scope.currentPage, $scope.pageSize);
                if ($scope.currentPage < $scope.totalPages - 2) {
                    initializePagination();
                }
            }
        };

        loadData();
    }]);

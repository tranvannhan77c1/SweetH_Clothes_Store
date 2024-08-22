angular.module('app')
    .controller('ProductController', ['$scope', '$timeout', 'ProductService', 'CategoryService', 'ItemService', function ($scope, $timeout, ProductService, CategoryService, ItemService) {

        $scope.pageSize = 4;
        $scope.paginationButtons = [];
        $scope.totalPages = 1;
        $scope.currentPage = 0;
        $scope.items = [];
        $scope.categories = [];
        $scope.products = [];
        $scope.product = {};
        $scope.isEditMode = false;
        $scope.showSizeGroup = {
            sizes: false,
            shoes: false,
            freesize: false
        };

        $scope.sizeQuantities = {};

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

        $scope.initializeSizeQuantities = function(productSizes) {
            $scope.sizeQuantities = {
                S: { checked: false, quantity: '' },
                M: { checked: false, quantity: '' },
                L: { checked: false, quantity: '' },
                XL: { checked: false, quantity: '' },
                size36: { checked: false, quantity: '' },
                size37: { checked: false, quantity: '' },
                size38: { checked: false, quantity: '' },
                size39: { checked: false, quantity: '' },
                Freesize: { checked: false, quantity: '' }
            };
            productSizes.forEach(function(size) {
                if ($scope.sizeQuantities[size.size]) {
                    $scope.sizeQuantities[size.size].checked = true;
                    console.log($scope.sizeQuantities[size.size].checked = true);
                    $scope.sizeQuantities[size.size].quantity = size.quantity;
                }
                console.log(size)
            });
        };
        $scope.onItemChange = function(itemId) {
            if (itemId) {
                CategoryService.getCategoriesByItemId(itemId)
                    .then(function (data) {
                        $scope.categories = data;
                    })
                    .catch(function (error) {
                        console.error('Error fetching categories', error);
                    });
            } else {
                $scope.categories = [];
            }

            switch (itemId) {
                case 1: // QUẦN ÁO
                    $scope.showSizeGroup.sizes = true;
                    $scope.showSizeGroup.freesize = false;
                    $scope.showSizeGroup.shoes = false;
                    break;
                case 2: // PHỤ KIỆN
                    $scope.showSizeGroup.freesize = true;
                    $scope.showSizeGroup.shoes = false;
                    $scope.showSizeGroup.sizes = false;
                    break;
                case 3: // TÚI
                    $scope.showSizeGroup.freesize = true;
                    $scope.showSizeGroup.shoes = false;
                    $scope.showSizeGroup.sizes = false;
                    break;
                case 4: // GIÀY
                    $scope.showSizeGroup.shoes = true;
                    $scope.showSizeGroup.freesize = false;
                    $scope.showSizeGroup.sizes = false;
                    break;
                case 5: // BỘ SƯU TẬP
                    $scope.showSizeGroup.freesize = true;
                    $scope.showSizeGroup.shoes = false;
                    $scope.showSizeGroup.sizes = false;
                    break;
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
                    $scope.initializeSizeQuantities($scope.product.productSizes);
                    $scope.isEditMode = true;
                    $(document).ready(function () {
                        $('#addProductModal').modal('show');
                    });
                })
                .catch(function (error) {
                    console.error('Error fetching product', error);
                });
        };

        $scope.createProduct = function () {
            console.log($scope.product)
            ProductService.createProduct($scope.product)
                .then(function (data) {
                    getProductsPage($scope.currentPage, $scope.pageSize)
                        .then(function () {
                            $scope.goToPage($scope.totalPages - 1);
                            $scope.product = data;
                            console.log($scope.product)
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
                .then(function (data) {
                    getProductsPage($scope.currentPage, $scope.pageSize);
                })
                .catch(function (error) {
                    console.error('Error deleting product', error);
                });
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

angular.module('app')
    .controller('ProductController', ['$scope', '$timeout', 'ProductService', 'CategoryService', 'ItemService', function ($scope, $timeout, ProductService, CategoryService, ItemService) {

        $scope.pageSize = 5;
        $scope.paginationButtons = [];
        $scope.totalPages = 1;
        $scope.currentPage = 0;
        $scope.items = [];
        $scope.categories = [];
        $scope.products = [];
        $scope.isEditMode = false;
        $scope.message = '';
        $scope.isSuccess = false;
        $scope.highlightedProductId = null;
        $scope.itemnofi = '';
        $scope.categorynofi = '';
        $scope.thumbnailImagenofi = '';
        $scope.namenofi = '';
        $scope.pricenofi = '';
        $scope.brandnofi = '';
        $scope.madeInnofi = '';
        $scope.colornofi = '';
        $scope.materialnofi = '';
        $scope.descriptionnofi = '';
        $scope.sizenofi = '';
        $scope.imagesnofi = '';
        $scope.product = {
            otherImages: ["", "", ""]
        };
        $scope.clothingSizes = [
            {size: 'S', selected: false, quantity: 0},
            {size: 'M', selected: false, quantity: 0},
            {size: 'L', selected: false, quantity: 0},
            {size: 'XL', selected: false, quantity: 0}
        ];
        $scope.shoeSizes = [
            {size: '36', selected: false, quantity: 0},
            {size: '37', selected: false, quantity: 0},
            {size: '38', selected: false, quantity: 0},
            {size: '39', selected: false, quantity: 0}
        ];
        $scope.freeSize = {selected: false, quantity: 0};
        $scope.isNameSuccess = false;
        $scope.nameEdit = '';

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

        function loadData() {
            getProductsPage($scope.currentPage, $scope.pageSize);
            getAllItems();
        }

        $scope.editProduct = function (id) {
            $scope.resetForm();
            ProductService.getProductById(id)
                .then(function (data) {
                    $scope.product = data;
                    $scope.isEditMode = true;
                    $('#addProductModal').modal('show');
                    $scope.onItemChange($scope.product.itemId);
                    $scope.nameEdit = $scope.product.name;
                    $scope.product.otherImages = $scope.product.productImages.map(img => img.imageUrl);
                    console.log($scope.product);
                    if ($scope.product.productSizes) {
                        if ($scope.product.itemId == 2 || $scope.product.itemId == 3) {
                            let productSize = $scope.product.productSizes[0];
                            if (productSize && productSize.size === 'Freesize') {
                                $scope.freeSize.selected = true;
                                $scope.freeSize.quantity = productSize.quantity;
                            }
                        } else {
                            $scope.productSizes.forEach(size => {
                                let productSize = $scope.product.productSizes.find(ps => ps.size == size.size);
                                if (productSize) {
                                    size.selected = true;
                                    size.quantity = productSize.quantity;
                                }
                            });
                        }
                    }
                })
                .catch(function (error) {
                    console.error('Error fetching product', error);
                });
        };

        $scope.createProduct = function () {
            $scope.checkItem($scope.product.itemId);
            $scope.checkCategory($scope.product.categoryId);
            $scope.checkThumbnailImage($scope.product.thumbnailImage);
            $scope.checkName($scope.product.name);
            $scope.checkPrice($scope.product.price);
            $scope.checkBrand($scope.product.brand);
            $scope.checkMadeIn($scope.product.madeIn);
            $scope.checkColor($scope.product.color);
            $scope.checkMaterial($scope.product.material);
            $scope.checkDescription($scope.product.description);
            $scope.checkProductSizes();
            $scope.checkProductImages($scope.product.otherImages);
            if ($scope.codenofi != 'Tên sản phẩm hợp lệ.') {
                if ($scope.itemnofi || $scope.categorynofi || $scope.thumbnailImagenofi || $scope.namenofi || $scope.pricenofi || $scope.brandnofi || $scope.madeInnofi || $scope.colornofi || $scope.materialnofi || $scope.descriptionnofi || $scope.sizenofi || $scope.imagesnofi) {
                    handleError('Vui lòng sửa lỗi trước khi thêm sản phẩm!');
                    return;
                }
            }

            // Chuẩn bị dữ liệu sản phẩm để gửi
            $scope.product.productSizes = [];

            // Nếu là itemId = 4 (Giày)
            if ($scope.product.itemId == 4) {
                $scope.product.productSizes = $scope.shoeSizes.filter(size => size.selected && size.quantity > 0).map(size => {
                    return {
                        size: size.size,
                        quantity: size.quantity
                    };
                });
            }

            // Nếu là itemId = 1 (Quần Áo)
            if ($scope.product.itemId == 1) {
                $scope.product.productSizes = $scope.clothingSizes.filter(size => size.selected && size.quantity > 0).map(size => {
                    return {
                        size: size.size,
                        quantity: size.quantity
                    };
                });
            }

            // Nếu là itemId = 2, 3, 5 (Phụ Kiện, Túi, Bộ Sưu Tập)
            if ($scope.product.itemId == 2 || $scope.product.itemId == 3) {
                if ($scope.freeSize.selected && $scope.freeSize.quantity > 0) {
                    $scope.product.productSizes.push({
                        size: 'Freesize',
                        quantity: $scope.freeSize.quantity
                    });
                }
            }

            $scope.product.quantity = $scope.product.productSizes.reduce((total, size) => total + size.quantity, 0);

            $scope.product.productImages = $scope.product.otherImages.filter(imageUrl => imageUrl).map(imageUrl => ({imageUrl}));

            console.log("Tổng quantity:", $scope.product.quantity);

            console.log($scope.product);

            ProductService.createProduct($scope.product)
                .then(function (data) {
                    getProductsPage($scope.currentPage, $scope.pageSize)
                        .then(function () {
                            $scope.goToPage($scope.totalPages - 1);
                            $scope.highlightProduct(data.id);
                            $('#addProductModal').modal('hide');
                            // $scope.editProduct($scope.product.id);
                        });
                })
                .catch(function (error) {
                    console.error('Lỗi khi tạo sản phẩm', error);
                });
        };

        $scope.updateProduct = function () {
            // Kiểm tra các trường cần thiết
            $scope.checkItem($scope.product.itemId);
            $scope.checkCategory($scope.product.categoryId);
            $scope.checkThumbnailImage($scope.product.thumbnailImage);
            $scope.checkName($scope.product.name);
            $scope.checkPrice($scope.product.price);
            $scope.checkBrand($scope.product.brand);
            $scope.checkMadeIn($scope.product.madeIn);
            $scope.checkColor($scope.product.color);
            $scope.checkMaterial($scope.product.material);
            $scope.checkDescription($scope.product.description);
            $scope.checkProductSizes();
            $scope.checkProductImages($scope.product.otherImages);

            // Nếu có bất kỳ thông báo lỗi nào, không tiếp tục và hiển thị thông báo lỗi
            if ($scope.itemnofi || $scope.categorynofi || $scope.thumbnailImagenofi || $scope.namenofi ||
                $scope.pricenofi || $scope.brandnofi || $scope.madeInnofi || $scope.colornofi ||
                $scope.materialnofi || $scope.descriptionnofi || $scope.sizenofi || $scope.imagesnofi) {
                handleError('Vui lòng sửa lỗi trước khi cập nhật sản phẩm!');
                return;
            }

            // Chuẩn bị dữ liệu sản phẩm để gửi
            $scope.product.productSizes = [];

            // Xử lý các kích thước sản phẩm
            if ($scope.product.itemId == 4) {
                $scope.product.productSizes = $scope.shoeSizes.filter(size => size.selected && size.quantity > 0).map(size => {
                    return {
                        size: size.size,
                        quantity: size.quantity
                    };
                });
            } else if ($scope.product.itemId == 1) {
                $scope.product.productSizes = $scope.clothingSizes.filter(size => size.selected && size.quantity > 0).map(size => {
                    return {
                        size: size.size,
                        quantity: size.quantity
                    };
                });
            } else if ($scope.product.itemId == 2 || $scope.product.itemId == 3) {
                if ($scope.freeSize.selected && $scope.freeSize.quantity > 0) {
                    $scope.product.productSizes.push({
                        size: 'Freesize',
                        quantity: $scope.freeSize.quantity
                    });
                }
            }

            $scope.product.quantity = $scope.product.productSizes.reduce((total, size) => total + size.quantity, 0);

            $scope.product.productImages = $scope.product.otherImages.filter(imageUrl => imageUrl).map(imageUrl => ({imageUrl}));
            console.log($scope.product);
            // Gửi yêu cầu cập nhật
            ProductService.updateProduct($scope.product.id, $scope.product)
                .then(function (data) {
                    $scope.product = data;
                    getProductsPage($scope.currentPage, $scope.pageSize);
                    $('#addProductModal').modal('hide');
                    $scope.highlightProduct(data.id);
                    handleSuccess('Cập nhật sản phẩm thành công!');
                    alert("Cập nhật sản phẩm thành công!");
                })
                .catch(function (error) {
                    console.error('Lỗi khi cập nhật sản phẩm', error);
                });
        };


        $scope.deleteProduct = function (id) {
            ProductService.deleteProduct(id)
                .then(function () {
                    getProductsPage($scope.currentPage, $scope.pageSize);
                    $('#addProductModal').modal('hide');
                    $scope.product = {
                        otherImages: ["", "", ""]
                    };
                    alert("Xoá sản phẩm thành công!");
                })
                .catch(function (error) {
                    handleError('Xoá sản phẩm không thành công!');
                    console.error('Error deleting product', error);
                });
        };

        $scope.onItemChange = function (itemId) {
            if (itemId) {
                CategoryService.getCategoriesByItemId(itemId)
                    .then(function (data) {
                        $scope.categories = data;
                    })
                    .catch(function (error) {
                        console.error('Error fetching categories', error);
                    });

                if (itemId == 1) {
                    $scope.productSizes = $scope.clothingSizes;
                } else if (itemId == 2 || itemId == 3) {
                    $scope.productSizes = [$scope.freeSize];
                } else if (itemId == 4) {
                    $scope.productSizes = $scope.shoeSizes;
                }
            } else {
                $scope.categories = [];
                $scope.productSizes = [];
            }
        };

        $scope.checkItem = function (item) {
            if (!item) {
                $scope.itemnofi = 'Chọn danh mục để chọn chủng loại.';
            } else {
                $scope.itemnofi = '';
            }
        };

        $scope.checkCategory = function (category) {
            if (!category) {
                $scope.categorynofi = 'Chủng loại không được bỏ trống.';
            } else {
                $scope.categorynofi = '';
            }
        };

        $scope.checkThumbnailImage = function (thumbnailImage) {
            if (!thumbnailImage) {
                $scope.thumbnailImagenofi = 'Hình chính không được bỏ trống.';
            } else {
                $scope.thumbnailImagenofi = '';
            }
        };

        $scope.checkName = function (name) {
            if (!name) {
                $scope.namenofi = 'Tên không được không được bỏ trống.';
                $scope.isNameSuccess = false;
                return;
            }

            if ($scope.isEditMode && name === $scope.nameEdit) {
                $scope.namenofi = '';
                $scope.isNameSuccess = true;
                return;
            }

            if (name.length > 255) {
                $scope.namenofi = 'Mã khuyến mãi không được vượt quá 10 ký tự.';
                $scope.isNameSuccess = false;
                return;
            }

            if (/[^a-zA-Z0-9\s\u00C0-\u024F\u1E00-\u1EFF]/.test(name)) {
                $scope.namenofi = 'Tên không được chứa ký tự đặc biệt.';
                $scope.isNameSuccess = false;
                return;
            }

            ProductService.checkProductName(name, $scope.isEditMode ? $scope.product.id : null)
                .then(function (exists) {
                    if (exists && (!($scope.isEditMode && name === $scope.nameEdit))) {
                        $scope.namenofi = 'Tên sản phẩm đã tồn tại!';
                        $scope.isNameSuccess = false;
                    } else {
                        $scope.namenofi = 'Tên sản phẩm hợp lệ.';
                        $scope.isNameSuccess = true;
                        $timeout(function () {
                            $scope.namenofi = '';
                        }, 5000);
                    }
                })
                .catch(function (error) {
                    console.error('Error checking voucher code', error);
                    $scope.namenofi = 'Đã xảy ra lỗi khi kiểm tra tên sản phẩm.';
                    $scope.isCodeSuccess = false;
                });
        };

        $scope.checkPrice = function (price) {
            if (!price) {
                $scope.pricenofi = 'Giá không được bỏ trống.';
            } else if (price <= 0) {
                $scope.pricenofi = 'Giá không được nhỏ hơn 0.';
            } else if (price > 99999999.99) {
                $scope.pricenofi = 'Giá không được vượt quá 99.999.999.';
            } else {
                $scope.pricenofi = '';
            }
        };

        $scope.checkBrand = function (brand) {
            if (!brand) {
                $scope.brandnofi = 'Thương hiệu không được bỏ trống.';
            } else {
                $scope.brandnofi = '';
            }
        }

        $scope.checkMadeIn = function (madeIn) {
            if (!madeIn) {
                $scope.madeInnofi = 'Nguồn gốc không được bỏ trống.';
            } else {
                $scope.madeInnofi = '';
            }
        }

        $scope.checkColor = function (color) {
            if (!color) {
                $scope.colornofi = 'Màu không được bỏ trống.';
            } else {
                $scope.colornofi = '';
            }
        }

        $scope.checkMaterial = function (material) {
            if (!material) {
                $scope.materialnofi = 'Chất liệu không được bỏ trống.';
            } else {
                $scope.materialnofi = '';
            }
        }

        $scope.checkDescription = function (description) {
            if (!description) {
                $scope.descriptionnofi = 'Mô tả không được bỏ trống.';
            } else {
                $scope.descriptionnofi = '';
            }
        }

        $scope.checkProductSizes = function () {
            if ($scope.product.itemId == 4 && $scope.shoeSizes) {  // Kiểm tra cho shoeSizes nếu itemId là 4 (Giày)
                const selectedSizes = $scope.shoeSizes.filter(size => size.selected);
                const invalidSizes = selectedSizes.filter(size => size.quantity <= 0);
                if (selectedSizes.length === 0) {
                    $scope.sizenofi = 'Vui lòng chọn ít nhất một kích thước và nhập số lượng hợp lệ.';
                } else if (invalidSizes.length > 0) {
                    $scope.sizenofi = 'Tất cả các kích thước được chọn phải có số lượng lớn hơn 0.';
                } else {
                    $scope.sizenofi = '';
                }
            } else if ($scope.product.itemId == 1 && $scope.clothingSizes) {  // Kiểm tra cho clothingSizes nếu itemId là 1 (Quần Áo)
                const selectedSizes = $scope.clothingSizes.filter(size => size.selected);
                const invalidSizes = selectedSizes.filter(size => size.quantity <= 0);
                if (selectedSizes.length === 0) {
                    $scope.sizenofi = 'Vui lòng chọn ít nhất một kích thước và nhập số lượng hợp lệ.';
                } else if (invalidSizes.length > 0) {
                    $scope.sizenofi = 'Tất cả các kích thước được chọn phải có số lượng lớn hơn 0.';
                } else {
                    $scope.sizenofi = '';
                }
            } else if ($scope.product.itemId == 2 || $scope.product.itemId == 3) {  // Kiểm tra cho Freesize nếu itemId là 2 hoặc 3
                if (!$scope.freeSize.selected || $scope.freeSize.quantity <= 0) {
                    $scope.sizenofi = 'Vui lòng chọn Freesize và nhập số lượng hợp lệ.';
                } else {
                    $scope.sizenofi = '';
                }
            }
        };

        $scope.checkProductSizeQuantity = function (size) {
            if (!size.selected) {
                return;
            }
            if (size.quantity <= 0 || size.quantity >= 1000000) {
                $scope.sizenofi = 'Số lượng cho mỗi kích thước phải lớn hơn 0 và nhỏ hơn 1,000,000.';
            } else {
                $scope.sizenofi = '';
            }
            $scope.checkProductSizes();  // Gọi lại để kiểm tra toàn bộ kích thước
        };

        $scope.checkProductImages = function (otherImages) {
            // Kiểm tra xem có đủ 3 ảnh khác và không có ảnh nào là chuỗi rỗng
            if (otherImages.length !== 3 || otherImages.some(imageUrl => !imageUrl.trim())) {
                $scope.imagesnofi = 'Vui lòng nhập đầy đủ và hợp lệ đường dẫn của ba hình ảnh khác.';
            } else {
                $scope.imagesnofi = '';
            }
        };

        $scope.resetForm = function () {
            $scope.product = {
                otherImages: ["", "", ""]
            };
            $scope.isEditMode = false;
            $scope.message = '';
            $scope.itemnofi = '';
            $scope.categorynofi = '';
            $scope.thumbnailImagenofi = '';
            $scope.namenofi = '';
            $scope.pricenofi = '';
            $scope.brandnofi = '';
            $scope.madeInnofi = '';
            $scope.colornofi = '';
            $scope.materialnofi = '';
            $scope.descriptionnofi = '';
            $scope.sizenofi = '';
            $scope.imagesnofi = '';

        };

        function handleSuccess(message) {
            $scope.message = message;
            $scope.isSuccess = true;
        }

        function handleError(message) {
            $scope.message = message;
            $scope.isSuccess = false;
        }

        $scope.highlightProduct = function (productId) {
            $scope.highlightedProductId = productId;
            $timeout(function () {
                $scope.highlightedProductId = null;
            }, 5000);
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
        console.clear();
    }]);
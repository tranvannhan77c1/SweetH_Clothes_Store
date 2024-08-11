angular.module('app')
    .controller('CategoryController', ['$scope', '$timeout', 'CategoryService', 'ItemService', function ($scope, $timeout, CategoryService, ItemService) {
        $scope.currentPage = 0;
        $scope.pageSize = 8;
        $scope.totalPages = 1;
        $scope.categories = [];
        $scope.paginationButtons = [];
        $scope.category = {};
        $scope.isEditMode = false;
        $scope.highlightedCategoryId = null;
        $scope.items = [];
        $scope.message = '';
        $scope.isSuccess = false;

        function getCategories(page, size) {
            return CategoryService.getAllCategories(page, size)
                .then(function (data) {
                    $scope.categories = data.content;
                    $scope.totalPages = data.totalPages;
                    initializePagination();
                })
                .catch(function (error) {
                    console.error('Error fetching categories', error);
                });
        }

        function getItems() {
            ItemService.getAllItems()
                .then(function (data) {
                    $scope.items = data;
                })
                .catch(function (error) {
                    console.error('Error fetching items', error);
                });
        }

        $scope.editCategory = function (id) {
            CategoryService.getCategoryById(id)
                .then(function (data) {
                    $scope.category = data;
                    $scope.isEditMode = true;
                    $scope.message = '';
                })
                .catch(function (error) {
                    console.error('Error fetching category', error);
                });
        };

        $scope.createCategory = function () {
            $scope.validateCategory(function (isValid) {
                if (isValid) {
                    CategoryService.createCategory($scope.category)
                        .then(function (data) {
                            getCategories($scope.currentPage, $scope.pageSize)
                                .then(function () {
                                    $scope.goToPage($scope.totalPages - 1);
                                    $scope.highlightCategory(data.id);
                                    $scope.editCategory(data.id);
                                    handleSuccess('Thêm chủng loại thành công!');
                                });
                        })
                        .catch(function (error) {
                            console.error('Error creating category', error);
                            handleError('Có lỗi xảy ra khi thêm chủng loại.');
                        });
                }
            });
        };

        $scope.updateCategory = function () {
            $scope.validateCategory(function (isValid) {
                if (isValid) {
                    CategoryService.updateCategory($scope.category.id, $scope.category)
                        .then(function (data) {
                            getCategories($scope.currentPage, $scope.pageSize);
                            $scope.highlightCategory(data.id);
                            $scope.editCategory(data.id);
                            handleSuccess('Cập nhật chủng loại thành công!');
                        })
                        .catch(function (error) {
                            console.error('Error updating category', error);
                            handleError('Có lỗi xảy ra khi cập nhật chủng loại.');
                        });
                }
            });
        };

        $scope.deleteCategory = function (id) {
            CategoryService.deleteCategory(id)
                .then(function () {
                    getCategories($scope.currentPage, $scope.pageSize);
                    $scope.resetForm();
                    handleSuccess('Xoá chủng loại thành công!');
                })
                .catch(function (error) {
                    console.error('Error deleting category', error);
                    handleError('Không thể xoá chủng loại có chứa sản phẩm.');
                });
        };

        function loadData() {
            getCategories($scope.currentPage, $scope.pageSize);
            getItems();
        }

        $scope.resetForm = function () {
            $scope.category = {};
            $scope.isEditMode = false;
            $scope.message = '';
        };

        function handleSuccess(message) {
            $scope.message = message;
            $scope.isSuccess = true;
        }

        function handleError(message) {
            $scope.message = message;
            $scope.isSuccess = false;
        }

        $scope.validateCategory = function (callback) {
            $scope.message = '';

            if (!$scope.category.name || $scope.category.name.trim() === '') {
                handleError('Tên chủng loại không được bỏ trống.');
                callback(false);
                return;
            }

            if (!$scope.category.itemId) {
                handleError('Bạn phải chọn danh mục.');
                callback(false);
                return;
            }

            CategoryService.checkCategoryName($scope.category.name, $scope.category.id)
                .then(function (exists) {
                    if (exists) {
                        handleError('Tên chủng loại đã tồn tại.');
                        callback(false);
                    } else {
                        callback(true);
                    }
                })
                .catch(function (error) {
                    console.error('Error checking category name', error);
                    handleError('Có lỗi xảy ra khi kiểm tra tên chủng loại.');
                    callback(false);
                });
        };

        $scope.highlightCategory = function (categoryId) {
            $scope.highlightedCategoryId = categoryId;
            $timeout(function () {
                $scope.highlightedCategoryId = null;
            }, 5000);
        };

        function initializePagination() {
            $scope.paginationButtons = [];
            var start = Math.max(0, $scope.currentPage - 1);
            var end = Math.min($scope.totalPages - 1, start + 2);
            for (var i = start; i <= end; i++) {
                $scope.paginationButtons.push(i);
            }
        }

        $scope.goToPage = function (page) {
            if (page >= 0 && page < $scope.totalPages) {
                $scope.currentPage = page;
                getCategories($scope.currentPage, $scope.pageSize);
            }
        };

        $scope.nextPage = function () {
            if ($scope.currentPage < $scope.totalPages - 1) {
                $scope.currentPage++;
                getCategories($scope.currentPage, $scope.pageSize);
                if ($scope.currentPage > 1) {
                    initializePagination();
                }
            }
        };

        $scope.previousPage = function () {
            if ($scope.currentPage > 0) {
                $scope.currentPage--;
                getCategories($scope.currentPage, $scope.pageSize);
                if ($scope.currentPage < $scope.totalPages - 2) {
                    initializePagination();
                }
            }
        };

        loadData();
    }]);
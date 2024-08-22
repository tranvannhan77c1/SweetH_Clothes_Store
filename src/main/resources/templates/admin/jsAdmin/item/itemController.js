angular.module('app')
    .controller('ItemController', ['$scope', '$timeout', 'ItemService', function ($scope, $timeout, ItemService) {

        $scope.currentPage = 0;
        $scope.pageSize = 8;
        $scope.totalPages = 1;
        $scope.items = [];
        $scope.paginationButtons = [];
        $scope.item = {};
        $scope.isEditMode = false;
        $scope.highlightedItemId = null;
        $scope.message = '';
        $scope.isSuccess = false;

        function getItemsPage(page, size) {
            return ItemService.getItemsPage(page, size)
                .then(function (data) {
                    $scope.items = data.content;
                    $scope.totalPages = data.totalPages;
                    initializePagination();
                })
                .catch(function (error) {
                    console.error('Error fetching items', error);
                });
        };

        $scope.editItem = function (id) {
            ItemService.getItemById(id)
                .then(function (data) {
                    $scope.item = data;
                    $scope.isEditMode = true;
                    $scope.message = '';
                })
                .catch(function (error) {
                    console.error('Error fetching item', error);
                });
        };

        $scope.createItem = function () {
            $scope.validateItem(function (isValid) {
                if (isValid) {
                    ItemService.createItem($scope.item)
                        .then(function (data) {
                            getItemsPage($scope.currentPage, $scope.pageSize)
                                .then(function () {
                                    $scope.goToPage($scope.totalPages - 1);
                                    $scope.highlightItem(data.id);
                                    $scope.item = data;
                                    $scope.isEditMode = true;
                                    handleSuccess('Thêm danh mục thành công!');
                                });
                        })
                        .catch(function (error) {
                            console.error('Error creating item', error);
                        });
                }
            });
        };

        $scope.updateItem = function () {
            $scope.validateItem(function (isValid) {
                if (isValid) {
                    ItemService.updateItem($scope.item.id, $scope.item)
                        .then(function (data) {
                            $scope.item = data;
                            getItemsPage($scope.currentPage, $scope.pageSize);
                            $scope.highlightItem(data.id);
                            handleSuccess('Cập nhập danh mục thành công!');
                        })
                        .catch(function (error) {
                            console.error('Error updating item', error);
                        });
                }
            });
        };

        $scope.deleteItem = function (id) {
            ItemService.deleteItem(id)
                .then(function (data) {
                    getItemsPage($scope.currentPage, $scope.pageSize);
                    $scope.item = {};
                    $scope.isEditMode = false;
                    handleSuccess('Xoá danh mục thành công!');
                })
                .catch(function (error) {
                    handleError('Không thể xoá danh mục có chứa chủng loại.');
                    console.error('Error deleting item', error);
                });
        };

        $scope.resetForm = function () {
            $scope.item = {};
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

        $scope.validateItem = function (callback) {
            $scope.message = '';

            if (!$scope.item.name || $scope.item.name.trim() === '') {
                handleError('Tên danh mục không được bỏ trống.');
                callback(false);
                return;
            }

            if (/\d/.test($scope.item.name)) {
                handleError('Tên danh mục không được chứa số.');
                callback(false);
                return;
            }

            ItemService.checkName($scope.item.name)
                .then(function (exists) {
                    if (exists) {
                        handleError('Tên danh mục đã tồn tại.');
                        callback(false);
                    } else {
                        callback(true);
                    }
                })
                .catch(function (error) {
                    console.error('Error checking category name', error);
                    handleError('Có lỗi xảy ra khi kiểm tra tên danh mục.');
                    callback(false);
                });
        };

        $scope.highlightItem = function (itemId) {
            $scope.highlightedItemId = itemId;
            $timeout(function () {
                $scope.highlightedItemId = null;
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
                getItemsPage($scope.currentPage, $scope.pageSize);
            }
        };

        $scope.nextPage = function () {
            if ($scope.currentPage < $scope.totalPages - 1) {
                $scope.currentPage++;
                getItemsPage($scope.currentPage, $scope.pageSize);
                if ($scope.currentPage > 1) {
                    initializePagination();
                }
            }
        };

        $scope.previousPage = function () {
            if ($scope.currentPage > 0) {
                $scope.currentPage--;
                getItemsPage($scope.currentPage, $scope.pageSize);
                if ($scope.currentPage < $scope.totalPages - 2) {
                    initializePagination();
                }
            }
        };

        getItemsPage($scope.currentPage, $scope.pageSize);
    }]);

angular.module('app')
    .controller('ItemController', ['$scope', '$timeout', 'ItemService', function($scope, $timeout, ItemService) {

        $scope.currentPage = 0; // Trang hiện tại
        $scope.pageSize = 8; // Kích thước mỗi trang
        $scope.totalPages = 1; // Tổng số trang
        $scope.items = []; // Mảng lưu trữ items
        $scope.paginationButtons = []; // Mảng lưu trữ các nút phân trang hiển thị
        $scope.item = {}; // Đối tượng item để lưu trữ dữ liệu form
        $scope.isEditMode = false; // Biến xác định trạng thái chỉnh sửa
        $scope.highlightedItemId = null; // ID của mục được đánh dấu

        $scope.getItems = function(page, size) {
            ItemService.getAllItemsPage(page, size)
                .then(function(data) {
                    $scope.items = data.content;
                    console.log(data.content);
                    $scope.totalPages = data.totalPages;
                    initializePagination();
                })
                .catch(function(error) {
                    console.error('Error fetching items', error);
                });
        };

        $scope.viewItemDetails = function(id) {
            ItemService.getItemById(id)
                .then(function(data) {
                    $scope.item = data;
                    $scope.isEditMode = true; // Bật chế độ chỉnh sửa khi xem chi tiết
                })
                .catch(function(error) {
                    console.error('Error fetching item', error);
                });
        };

        $scope.createItem = function() {
            ItemService.createItem($scope.item)
                .then(function(data) {
                    $scope.item = data; // Giữ item vừa thêm trong form
                    $scope.getItems($scope.currentPage, $scope.pageSize);
                    $scope.highlightItem(data.id);
                    $scope.isEditMode = false; // Tắt chế độ chỉnh sửa sau khi thêm
                })
                .catch(function(error) {
                    console.error('Error creating item', error);
                });
        };

        $scope.updateItem = function() {
            ItemService.updateItem($scope.item.id, $scope.item)
                .then(function(data) {
                    $scope.item = data; // Giữ item vừa cập nhật trong form
                    $scope.getItems($scope.currentPage, $scope.pageSize);
                    $scope.highlightItem(data.id);
                })
                .catch(function(error) {
                    console.error('Error updating item', error);
                });
        };

        $scope.deleteItem = function(id) {
            ItemService.deleteItem(id)
                .then(function(data) {
                    $scope.getItems($scope.currentPage, $scope.pageSize);
                    $scope.item = {}; // Làm mới form sau khi xoá
                    $scope.isEditMode = false; // Tắt chế độ chỉnh sửa sau khi xoá
                })
                .catch(function(error) {
                    console.error('Error deleting item', error);
                });
        };

        $scope.resetForm = function() {
            $scope.item = {};
            $scope.isEditMode = false;
        };

        $scope.getItems($scope.currentPage, $scope.pageSize);

        var initializePagination = function() {
            $scope.paginationButtons = [];
            var start = Math.max(0, $scope.currentPage - 1);
            var end = Math.min($scope.totalPages - 1, start + 2);
            for (var i = start; i <= end; i++) {
                $scope.paginationButtons.push(i);
            }
        };

        $scope.goToPage = function(page) {
            if (page >= 0 && page < $scope.totalPages) {
                $scope.currentPage = page;
                $scope.getItems($scope.currentPage, $scope.pageSize);
            }
        };

        $scope.nextPage = function() {
            if ($scope.currentPage < $scope.totalPages - 1) {
                $scope.currentPage++;
                $scope.getItems($scope.currentPage, $scope.pageSize);
                if ($scope.currentPage > 1) {
                    initializePagination();
                }
            }
        };

        $scope.previousPage = function() {
            if ($scope.currentPage > 0) {
                $scope.currentPage--;
                $scope.getItems($scope.currentPage, $scope.pageSize);
                if ($scope.currentPage < $scope.totalPages - 2) {
                    initializePagination();
                }
            }
        };

        // Hàm để đánh dấu mục được thêm hoặc cập nhật
        $scope.highlightItem = function(itemId) {
            $scope.highlightedItemId = itemId;
            $timeout(function() {
                $scope.highlightedItemId = null; // Bỏ đánh dấu sau 2 giây
            }, 5000);
        };
    }]);

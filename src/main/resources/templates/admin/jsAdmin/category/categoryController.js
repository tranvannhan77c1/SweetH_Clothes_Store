angular.module('app')
    .controller('CategoryController', ['$scope', '$timeout', 'CategoryService', 'ItemService', function($scope, $timeout, CategoryService, ItemService) {

        $scope.currentPage = 0; // Trang hiện tại
        $scope.pageSize = 8; // Kích thước mỗi trang
        $scope.totalPages = 1; // Tổng số trang
        $scope.categories = []; // Mảng lưu trữ categories
        $scope.paginationButtons = []; // Mảng lưu trữ các nút phân trang hiển thị
        $scope.category = {}; // Đối tượng category để lưu trữ dữ liệu form
        $scope.isEditMode = false; // Biến xác định trạng thái chỉnh sửa
        $scope.highlightedCategoryId = null; // ID của mục được đánh dấu
        $scope.items = []; // Mảng lưu trữ items

        // Lấy danh sách categories và items khi controller khởi chạy
        $scope.loadData = function() {
            $scope.getCategories($scope.currentPage, $scope.pageSize);
            $scope.getItems();
        };

        // Lấy danh sách categories
        $scope.getCategories = function(page, size) {
            CategoryService.getAllCategories(page, size)
                .then(function(data) {
                    $scope.categories = data.content;
                    $scope.totalPages = data.totalPages;
                    initializePagination();
                })
                .catch(function(error) {
                    console.error('Error fetching categories', error);
                });
        };

        // Lấy danh sách items
        $scope.getItems = function() {
            ItemService.getAllItems()
                .then(function(data) {
                    $scope.items = data;
                    console.log($scope.items)
                })
                .catch(function(error) {
                    console.error('Error fetching items', error);
                });
        };

        // Gọi hàm loadData khi controller khởi chạy
        $scope.loadData();

        // Xử lý khi người dùng chọn chỉnh sửa một category
        $scope.editCategory = function(id) {
            CategoryService.getCategoryById(id)
                .then(function(data) {
                    $scope.category = data;
                    console.log(data)
                    // Thiết lập categoryId để nó trỏ đến itemId của item
                    $scope.item.id = $scope.category;
                    $scope.isEditMode = true; // Bật chế độ chỉnh sửa khi xem chi tiết
                })
                .catch(function(error) {
                    console.error('Error fetching category', error);
                });
        };


        // Xử lý khi người dùng thêm hoặc cập nhật category
        $scope.createOrUpdateCategory = function() {
            if ($scope.isEditMode) {
                CategoryService.updateCategory($scope.category.id, $scope.category)
                    .then(function(data) {
                        $scope.category = data; // Giữ category vừa cập nhật trong form
                        $scope.getCategories($scope.currentPage, $scope.pageSize);
                        $scope.highlightCategory(data.id);
                    })
                    .catch(function(error) {
                        console.error('Error updating category', error);
                    });
            } else {
                CategoryService.createCategory($scope.category)
                    .then(function(data) {
                        $scope.category = data; // Giữ category vừa thêm trong form
                        $scope.getCategories($scope.currentPage, $scope.pageSize);
                        $scope.highlightCategory(data.id);
                    })
                    .catch(function(error) {
                        console.error('Error creating category', error);
                    });
            }
        };

        // Xử lý khi người dùng xoá một category
        $scope.deleteCategory = function(id) {
            CategoryService.deleteCategory(id)
                .then(function(data) {
                    $scope.getCategories($scope.currentPage, $scope.pageSize);
                    $scope.category = {}; // Làm mới form sau khi xoá
                    $scope.isEditMode = false; // Tắt chế độ chỉnh sửa sau khi xoá
                })
                .catch(function(error) {
                    console.error('Error deleting category', error);
                });
        };

        // Hàm để đánh dấu mục được thêm hoặc cập nhật
        $scope.highlightCategory = function(categoryId) {
            $scope.highlightedCategoryId = categoryId;
            $timeout(function() {
                $scope.highlightedCategoryId = null; // Bỏ đánh dấu sau 2 giây
            }, 5000);
        };

        // Hàm để làm mới form
        $scope.resetForm = function() {
            $scope.category = {};
            $scope.isEditMode = false;
        };

        // Hàm để phân trang
        var initializePagination = function() {
            $scope.paginationButtons = [];
            var start = Math.max(0, $scope.currentPage - 1);
            var end = Math.min($scope.totalPages - 1, start + 2);
            for (var i = start; i <= end; i++) {
                $scope.paginationButtons.push(i);
            }
        };

        // Hàm để chuyển đến trang cụ thể
        $scope.goToPage = function(page) {
            if (page >= 0 && page < $scope.totalPages) {
                $scope.currentPage = page;
                $scope.getCategories($scope.currentPage, $scope.pageSize);
            }
        };

        // Hàm để đi tới trang kế tiếp
        $scope.nextPage = function() {
            if ($scope.currentPage < $scope.totalPages - 1) {
                $scope.currentPage++;
                $scope.getCategories($scope.currentPage, $scope.pageSize);
                if ($scope.currentPage > 1) {
                    initializePagination();
                }
            }
        };

        // Hàm để quay lại trang trước đó
        $scope.previousPage = function() {
            if ($scope.currentPage > 0) {
                $scope.currentPage--;
                $scope.getCategories($scope.currentPage, $scope.pageSize);
                if ($scope.currentPage < $scope.totalPages - 2) {
                    initializePagination();
                }
            }
        };

    }]);


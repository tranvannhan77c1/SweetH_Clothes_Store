angular.module('app')
    .controller('VoucherController', ['$scope', '$timeout', 'VoucherService', function($scope, $timeout, VoucherService) {

        $scope.currentPage = 0; // Trang hiện tại
        $scope.pageSize = 8; // Kích thước mỗi trang
        $scope.totalPages = 1; // Tổng số trang
        $scope.vouchers = []; // Mảng lưu trữ vouchers
        $scope.paginationButtons = []; // Mảng lưu trữ các nút phân trang hiển thị
        $scope.voucher = {}; // Đối tượng voucher để lưu trữ dữ liệu form
        $scope.isEditMode = false; // Biến xác định trạng thái chỉnh sửa
        $scope.highlightedVoucherId = null; // ID của mục được đánh dấu

        $scope.getVouchers = function(page, size) {
            VoucherService.getAllVouchersPage(page, size)
                .then(function(data) {
                    $scope.vouchers = data.content;
                    $scope.totalPages = data.totalPages;
                    initializePagination();
                })
                .catch(function(error) {
                    console.error('Error fetching vouchers', error);
                });
        };

        $scope.createVoucher = function() {
            $scope.voucher.createDate = new Date(); // Tự động thêm ngày tạo
            VoucherService.createVoucher($scope.voucher)
                .then(function(data) {
                    $scope.voucher = data; // Giữ voucher vừa thêm trong form
                    $scope.getVouchers($scope.currentPage, $scope.pageSize);
                    $scope.highlightVoucher(data.id);
                    $scope.resetForm(); // Làm mới form sau khi thêm
                })
                .catch(function(error) {
                    console.error('Error creating voucher', error);
                });
        };

        $scope.updateVoucher = function() {
            VoucherService.updateVoucher($scope.voucher.id, $scope.voucher)
                .then(function(data) {
                    $scope.voucher = data; // Giữ voucher vừa cập nhật trong form
                    $scope.getVouchers($scope.currentPage, $scope.pageSize);
                    $scope.highlightVoucher(data.id);
                    $scope.resetForm(); // Làm mới form sau khi cập nhật
                })
                .catch(function(error) {
                    console.error('Error updating voucher', error);
                });
        };

        $scope.viewVoucherDetails = function(id) {
            VoucherService.getVoucherById(id)
                .then(function(data) {
                    $scope.voucher = data;
                    $scope.voucher.validFrom = new Date(data.validFrom); // Chuyển đổi thành đối tượng Date
                    $scope.voucher.validTo = new Date(data.validTo); // Chuyển đổi thành đối tượng Date
                    $scope.isEditMode = true; // Bật chế độ chỉnh sửa khi xem chi tiết
                })
                .catch(function(error) {
                    console.error('Error fetching voucher', error);
                });
        };

        $scope.deleteVoucher = function(id) {
            VoucherService.deleteVoucher(id)
                .then(function(data) {
                    $scope.getVouchers($scope.currentPage, $scope.pageSize);
                    $scope.voucher = {}; // Làm mới form sau khi xoá
                    $scope.isEditMode = false; // Tắt chế độ chỉnh sửa sau khi xoá
                })
                .catch(function(error) {
                    console.error('Error deleting voucher', error);
                });
        };

        $scope.resetForm = function() {
            $scope.voucher = {};
            $scope.isEditMode = false;
        };

        $scope.getVouchers($scope.currentPage, $scope.pageSize);

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
                $scope.getVouchers($scope.currentPage, $scope.pageSize);
            }
        };

        $scope.nextPage = function() {
            if ($scope.currentPage < $scope.totalPages - 1) {
                $scope.currentPage++;
                $scope.getVouchers($scope.currentPage, $scope.pageSize);
                if ($scope.currentPage > 1) {
                    initializePagination();
                }
            }
        };

        $scope.previousPage = function() {
            if ($scope.currentPage > 0) {
                $scope.currentPage--;
                $scope.getVouchers($scope.currentPage, $scope.pageSize);
                if ($scope.currentPage < $scope.totalPages - 2) {
                    initializePagination();
                }
            }
        };

        // Hàm để đánh dấu mục được thêm hoặc cập nhật
        $scope.highlightVoucher = function(voucherId) {
            $scope.highlightedVoucherId = voucherId;
            $timeout(function() {
                $scope.highlightedVoucherId = null; // Bỏ đánh dấu sau 2 giây
            }, 5000);
        };
    }]);

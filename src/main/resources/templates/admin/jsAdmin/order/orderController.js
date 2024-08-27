angular.module('app')
    .controller('OrderController', ['$scope', '$timeout', 'OrderService', function($scope, $timeout, OrderService) {

        $scope.currentPage = 0;
        $scope.pageSize = 8;
        $scope.totalPages = 1;
        $scope.orders = [];
        $scope.paginationButtons = [];
        $scope.orderDetails = [];
        $scope.orderId = null;
        $scope.selectedStatus = '';
        $scope.message = '';

        $scope.getOrdersPage = function(page, size) {
            OrderService.getOrdersPage(page, size)
                .then(function(data) {
                    $scope.orders = data.content;
                    $scope.totalPages = data.totalPages;
                    initializePagination();
                })
                .catch(function(error) {
                    console.error('Error fetching orders', error);
                });
        };

        $scope.updateOrderStatus = function(orderId, status) {
            OrderService.updateOrderStatus(orderId, status)
                .then(function(updatedOrder) {
                    var order = $scope.orders.find(o => o.id === orderId);
                    if (order) {
                        order.status = updatedOrder.status;
                    }

                    // Cập nhật lại trạng thái sau khi cập nhật
                    $scope.selectedStatus = updatedOrder.status;
                    $scope.message = 'Đã Cập Nhập Trạng Thái Đơn Hàng!';

                    // Áp dụng điều kiện vô hiệu hóa sau khi cập nhật
                    if ($scope.selectedStatus === 'Delivered') {
                        $scope.disableCancelledOption = true;
                    } else if ($scope.selectedStatus === 'Cancelled') {
                        $scope.disableAllOptions = true;
                    } else {
                        $scope.disableCancelledOption = false;
                        $scope.disableAllOptions = false;
                    }
                    $timeout(function() {
                        $scope.message = '';
                    }, 4000);
                })
                .catch(function(error) {
                    console.error('Error updating order status', error);
                });
        };

        $scope.getOrderDetails = function(orderId) {
            OrderService.getOrderDetails(orderId)
                .then(function(orderDetails) {
                    $scope.orderId = orderDetails.id;
                    $scope.orderDetails = orderDetails;
                    $scope.selectedStatus = orderDetails.status;

                    if ($scope.selectedStatus === 'Cancelled') {
                        $scope.disableAllOptions = true;
                    } else if ($scope.selectedStatus === 'Delivered') {
                        $scope.disableCancelledOption = true;
                    } else {
                        $scope.disableAllOptions = false;
                        $scope.disableCancelledOption = false;
                    }

                    $('#orderDetailModal').modal('show');
                })
                .catch(function(error) {
                    console.error('Error fetching order details', error);
                });
        };

        // Khởi tạo phân trang
        $scope.getOrdersPage($scope.currentPage, $scope.pageSize);

        // Hàm phân trang
        var initializePagination = function() {
            $scope.paginationButtons = [];
            var start = Math.max(0, $scope.currentPage - 1);
            var end = Math.min($scope.totalPages - 1, start + 2);
            for (var i = start; i <= end; i++) {
                $scope.paginationButtons.push(i);
            }
        };

        // Hàm chuyển trang
        $scope.goToPage = function(page) {
            if (page >= 0 && page < $scope.totalPages) {
                $scope.currentPage = page;
                $scope.getOrdersPage($scope.currentPage, $scope.pageSize);
            }
        };

        $scope.nextPage = function() {
            if ($scope.currentPage < $scope.totalPages - 1) {
                $scope.currentPage++;
                $scope.getOrdersPage($scope.currentPage, $scope.pageSize);
                if ($scope.currentPage > 1) {
                    initializePagination();
                }
            }
        };

        $scope.previousPage = function() {
            if ($scope.currentPage > 0) {
                $scope.currentPage--;
                $scope.getOrdersPage($scope.currentPage, $scope.pageSize);
                if ($scope.currentPage < $scope.totalPages - 2) {
                    initializePagination();
                }
            }
        };

    }]);

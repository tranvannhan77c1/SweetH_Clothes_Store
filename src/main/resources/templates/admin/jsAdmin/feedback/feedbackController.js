angular.module('app')
    .controller('FeedbackController', ['$scope', 'FeedbackService', function ($scope, FeedbackService) {
        $scope.currentPage = 0;
        $scope.pageSize = 8;
        $scope.totalPages = 1;
        $scope.feedbacks = [];
        $scope.paginationButtons = [];

        $scope.accountInfo = null;
        var storedAccountInfo = localStorage.getItem('accountDetail');
        if (storedAccountInfo) {
            $scope.accountInfo = JSON.parse(storedAccountInfo);
        }


        $scope.getFeedbacksPage = function (page, size) {
            FeedbackService.getFeedbacksPage(page, size)
                .then(function (data) {
                    $scope.feedbacks = data.content;
                    $scope.totalPages = data.totalPages;
                    initializePagination();
                })
                .catch(function (error) {
                    console.error('Error fetching feedbacks', error);
                });
        };

        $scope.toggleStatus = function (feedback) {
            feedback.status = !feedback.status;
            FeedbackService.updateFeedback(feedback.id, feedback)
                .then(function (updatedFeedback) {
                    feedback = updatedFeedback;
                })
                .catch(function (error) {
                    console.error('Error updating feedback status', error);
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
                $scope.getFeedbacksPage($scope.currentPage, $scope.pageSize);
            }
        };

        $scope.nextPage = function () {
            if ($scope.currentPage < $scope.totalPages - 1) {
                $scope.currentPage++;
                $scope.getFeedbacksPage($scope.currentPage, $scope.pageSize);
                if ($scope.currentPage > 1) {
                    initializePagination();
                }
            }
        };

        $scope.previousPage = function () {
            if ($scope.currentPage > 0) {
                $scope.currentPage--;
                $scope.getFeedbacksPage($scope.currentPage, $scope.pageSize);
                if ($scope.currentPage < $scope.totalPages - 2) {
                    initializePagination();
                }
            }
        };

        $scope.getFeedbacksPage($scope.currentPage, $scope.pageSize);
    }]);
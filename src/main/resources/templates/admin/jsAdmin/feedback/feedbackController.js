
angular.module('app')
    .controller('FeedbackController', ['$scope', 'FeedbackService', function($scope, FeedbackService) {
    $scope.currentPage = 0;
    $scope.pageSize = 8;
    $scope.totalPages = 1;
    $scope.feedbacks = [];
    $scope.paginationButtons = [];

    $scope.getFeedbacks = function(page, size) {
        FeedbackService.getAllFeedbacksPage(page, size)
            .then(function(data) {
                $scope.feedbacks = data.content;
                console.log(data.content);
                $scope.totalPages = data.totalPages;
                initializePagination();
            })
            .catch(function(error) {
                console.error('Error fetching feedbacks', error);
            });
    };

    $scope.toggleStatus = function(feedback) {
        feedback.status = !feedback.status;
        FeedbackService.updateFeedback(feedback.id, feedback)
            .then(function(updatedFeedback) {
                feedback = updatedFeedback;
            })
            .catch(function(error) {
                console.error('Error updating feedback status', error);
            });
    };

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
            $scope.getFeedbacks($scope.currentPage, $scope.pageSize);
        }
    };

    $scope.nextPage = function() {
        if ($scope.currentPage < $scope.totalPages - 1) {
            $scope.currentPage++;
            $scope.getFeedbacks($scope.currentPage, $scope.pageSize);
            if ($scope.currentPage > 1) {
                initializePagination();
            }
        }
    };

    $scope.previousPage = function() {
        if ($scope.currentPage > 0) {
            $scope.currentPage--;
            $scope.getFeedbacks($scope.currentPage, $scope.pageSize);
            if ($scope.currentPage < $scope.totalPages - 2) {
                initializePagination();
            }
        }
    };

    $scope.getFeedbacks($scope.currentPage, $scope.pageSize);
}]);
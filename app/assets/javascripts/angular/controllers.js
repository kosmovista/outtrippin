var planApp = angular.module('planApp', ['planServices']);

planApp.controller('PlanCtrl', ['$scope', '$http', 'Plan', function($scope, $http, Plan) {
  $scope.plan = Plan.query();
  $scope.days = $scope.plan.days;
  $scope.day = {"title": "lorem", "body": "ipsum"};

  // ADD DAY
  $scope.save_day = function() {
    $http.put('plan/day.json', {"title": $scope.day.title, "body": $scope.day.body }).
      success(function(data, status, headers, config) {
        $scope.plan = Plan.query();
      }).
      error(function(data, status, headers, config) {
        alert("error while creating");
      });
  }

  // UPDATE DAY
  $scope.update_day = function(id, title, body) {
    // alert("lol");
    $http.post('plan/day/' + id + '.json', {"title": title, "body": body }).
      success(function(data, status, headers, config) {
        $scope.plan = Plan.query();
      }).
      error(function(data, status, headers, config) {
        alert("error while deleting");
      });
  }



  // DELETE DAY
  $scope.delete_day = function(id) {
    $http.delete('plan/day/' + id + '.json').
      success(function(data, status, headers, config) {
        $scope.plan = Plan.query();
      }).
      error(function(data, status, headers, config) {
        alert("error while deleting");
      });
  }
}]);
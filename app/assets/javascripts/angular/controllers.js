var planApp = angular.module('planApp', ['planServices', 'angularFileUpload', 'textAngular']);

planApp.controller('PlanCtrl', ['$scope', '$http', 'Plan', '$upload', function($scope, $http, Plan, $upload) {
  $scope.plan = Plan.query();
  $scope.days = $scope.plan.days;
  $scope.day = {"title": "A title for the day", "body": "Write your story for this day..."};

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

  // UPLOAD PICTURE
  $scope.onFileSelect = function($files) {
    //$files: an array of files selected, each file has name, size, and type.
    for (var i = 0; i < $files.length; i++) {
      var file = $files[i];
      $scope.upload = $upload.upload({
        url: 'plan/picture.json', //upload.php script, node.js route, or servlet url
        method: "PUT",
        // headers: {'headerKey': 'headerValue'}, withCredential: true,
        data: { myObj: $scope.myModelObj },
        file: file,
        // file: $files, //upload multiple files, this feature only works in HTML5 FromData browsers
        /* set file formData name for 'Content-Desposition' header. Default: 'file' */
        //fileFormDataName: myFile,
        /* customize how data is added to formData. See #40#issuecomment-28612000 for example */
        //formDataAppender: function(formData, key, val){}
      }).progress(function(evt) {
        console.log('percent: ' + parseInt(100.0 * evt.loaded / evt.total));
      }).success(function(data, status, headers, config) {
        $scope.plan = Plan.query();
      });
      //.error(...)
      //.then(success, error, progress);
    }
  };

  // DELETE PICTURE
  $scope.delete_picture = function(id) {
    $http.delete('plan/picture/' + id + '.json').
      success(function(data, status, headers, config) {
        $scope.plan = Plan.query();
      }).
      error(function(data, status, headers, config) {
        alert("error while deleting picutre");
      });
  }


}]);
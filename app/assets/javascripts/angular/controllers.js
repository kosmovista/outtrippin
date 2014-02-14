var planApp = angular.module('planApp', ['planServices', 'angularFileUpload', 'textAngular']);

planApp.controller('PlanCtrl', ['$scope', '$http', 'Plan', '$upload', function($scope, $http, Plan, $upload) {
  $scope.plan = Plan.query();
  $scope.days = $scope.plan.days;
  $scope.tips_tricks = $scope.plan.tips_tricks;

  $scope.day = {"title": "", "body": "Start typing a description of the day... To save, click the green button on your right. To cancel, click the yellow button. You can add pictures after you've hit save."};
  $scope.tip_trick = {"title": "", "body": ""};

  // ADD DAY
  $scope.save_day = function() {
    $http.put('plan/day.json', {"title": $scope.day.title, "body": $scope.day.body }).
      success(function(data, status, headers, config) {
        $scope.plan = Plan.query();
        $scope.add_day = false;
        $scope.day = {"title": "", "body": "This is some text"};
      }).
      error(function(data, status, headers, config) {
        alert("error while creating");
      });
  }

  // UPDATE DAY
  $scope.update_day = function(id, title, body) {
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

  // CANCEL DAY EDITING
  $scope.cancel = function() {
    //this is a bit of an hack
    $scope.plan = Plan.query();
  };

  // ADD TIP_TRICK
  $scope.save_tip_trick = function() {
    $http.put('plan/tip_trick.json', {"title": $scope.tip_trick.title, "body": $scope.tip_trick.body }).
      success(function(data, status, headers, config) {
        $scope.plan = Plan.query();
        $scope.add_tip_trick = false;
        $scope.tip_trick = {"title": "", "body": ""};

      }).
      error(function(data, status, headers, config) {
        alert("error while creating");
      });
  }

  // UPDATE TIP_TRICK
  $scope.update_tip_trick = function(id, title, body) {
    $http.post('plan/tip_trick/' + id + '.json', {"title": title, "body": body }).
      success(function(data, status, headers, config) {
        $scope.plan = Plan.query();
      }).
      error(function(data, status, headers, config) {
        alert("error while deleting");
      });
  }

  // DELETE TIP_TRICK
  $scope.delete_tip_trick = function(id) {
    $http.delete('plan/tip_trick/' + id + '.json').
      success(function(data, status, headers, config) {
        $scope.plan = Plan.query();
      }).
      error(function(data, status, headers, config) {
        alert("error while deleting");
      });
  }

  // UPLOAD PICTURE
  $scope.onFileSelect = function($files, cover, day) {
    //$files: an array of files selected, each file has name, size, and type.
    for (var i = 0; i < $files.length; i++) {
      var file = $files[i];
      $scope.upload = $upload.upload({
        url: 'plan/picture.json', //upload.php script, node.js route, or servlet url
        method: "PUT",
        // headers: {'headerKey': 'headerValue'}, withCredential: true,
        data: { myObj: $scope.myModelObj, cover: cover, day: day },
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
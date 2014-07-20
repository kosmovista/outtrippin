var planApp = angular.module('planApp', ['planServices', 'angularFileUpload', 'textAngular']);

planApp.controller('PlanCtrl', ['$scope', '$http', 'Plan', '$upload', '$sanitize', function($scope, $http, Plan, $upload, $sanitize) {
  $scope.plan = Plan.query();
  $scope.days = $scope.plan.days;
  $scope.tips_tricks = $scope.plan.tips_tricks;
  $scope.bookings = $scope.plan.bookings;

  $scope.booking_order = ["Hotel", "Activity", "Other"]

  $scope.booking_types = [
    { id: 0, name: "hotel" },
    { id: 1, name: "activity" },
    { id: 2, name: "other" }
  ];

  $scope.day = {"title": "", "body": "Start typing a description of the day... To save, click the green button on your right. To cancel, click the yellow button. You can add pictures after you've hit save.", "cost": "", "reccomendation": ""};
  $scope.tip_trick = {"title": "", "body": ""};
  $scope.booking = {"title": "", "body": "", "price": "", "location": "", "link": "", "type": "other", "zuji": true};

  // ADD DAY
  $scope.save_day = function() {
    $http.put('plan/day.json', {"title": $scope.day.title, "body": $sanitize($scope.day.body), "cost": $scope.day.cost, "reccomendation": $scope.day.reccomendation }).
      success(function(data, status, headers, config) {
        $scope.plan = Plan.query();
        $scope.add_day = false;
        $scope.day = {"title": "", "body": "Start typing a description of the day... To save, click the green button on your right. To cancel, click the yellow button. You can add pictures after you've hit save." , "cost": "", "reccomendation": "" };
      }).
      error(function(data, status, headers, config) {
        alert("error while creating");
      });
  }

  // UPDATE DAY
  $scope.update_day = function(id, title, body, cost, reccomendation) {
    $http.post('plan/day/' + id + '.json', {"title": title, "body": $sanitize(body), "cost": cost, "reccomendation": reccomendation }).
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
        alert("An error occurred while deleting this day. Please try again.");
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
        alert("An error occurred while adding this day. Please try again.");
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

  // ADD BOOKING
  $scope.save_booking = function() {
    $http.put('plan/booking.json', {"title": $scope.booking.title, "body": $scope.booking.body, "price": $scope.booking.price, "location": $scope.booking.location, "link": $scope.booking.link, "type": $scope.booking.type, "zuji": $scope.booking.zuji }).
      success(function(data, status, headers, config) {
        $scope.plan = Plan.query();
        $scope.add_booking = false;
        $scope.booking = {"title": "", "body": "", "price": "", "location": "", "link": "", "type": "other", "zuji": true };
      }).
      error(function(data, status, headers, config) {
        alert("error while creating");
      });
  }

  // UPDATE BOOKING
  $scope.update_booking = function(id, title, body, link, loc, price, type, zuji) {
    $http.post('plan/booking/' + id + '.json', {"title": title, "body": body, "link": link, "price": price, "location": loc, "type": type, "zuji": zuji}).
      success(function(data, status, headers, config) {
        $scope.plan = Plan.query();
      }).
      error(function(data, status, headers, config) {
        alert("error while deleting");
      });
  }

  // DELETE BOOKING
  $scope.delete_booking = function(id) {
    $http.delete('plan/booking/' + id + '.json').
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
        url: 'plan/picture.json',
        method: "PUT",
        data: { myObj: $scope.myModelObj, cover: cover, day: day },
        file: file
      }).progress(function(evt) {
        console.log('percent: ' + parseInt(100.0 * evt.loaded / evt.total));
      }).success(function(data, status, headers, config) {
        $scope.plan = Plan.query();
      });
    }
  };

  // UPLOAD PICTURE TO BOOKING
  $scope.onFileSelectBooking = function($files, booking) {
    for (var i = 0; i < $files.length; i++) {
      var file = $files[i];
      $scope.upload = $upload.upload({
        url: 'plan/booking/' + booking + '.json',
        method: "PUT",
        data: { myObj: $scope.myModelObj, booking: booking },
        file: file
      }).progress(function(evt) {
        console.log('percent: ' + parseInt(100.0 * evt.loaded / evt.total));
      }).success(function(data, status, headers, config) {
        $scope.plan = Plan.query();
      });
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
  };

  $scope.ready_for_review = function(id) {
    $http.post('plan/ready.json').
      success(function(data, status, headers, config) {
        $('#done-modal').foundation('reveal', 'open');
      }).
      error(function(data, status, headers, config) {
        alert("error while processing your request");
      });
  }
}]);
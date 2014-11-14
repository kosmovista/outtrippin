itineraryApp = angular
  .module('itineraryApp', [
    'itineraryServices',
    'ngAnimate' 
  ])

  .config(["$httpProvider", (provider) ->
    provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
  ])
  .config(['$locationProvider', ($locationProvider) ->
    $locationProvider.html5Mode(true)
  ])

  .controller('ItineraryCtrl', ['$scope', '$http', 'Itinerary', '$timeout', '$location', '$window', ($scope, $http, Itinerary, $timeout, $location, $window) ->
    $http.get("gp.json").then (res) ->
      $scope.itinerary = res.data
      $scope.duration = $scope.itinerary.duration || 3
      $scope.extra_info = $scope.itinerary.extra_info || []
      $scope.checked_types = $scope.itinerary.extra_info.type || []
      $scope.activity_budget = $scope.itinerary.extra_info.activity_budget || $scope.budgetOptions[1]
      $scope.food_budget = $scope.itinerary.extra_info.food_budget || $scope.budgetOptions[1]
      $scope.age_group = $scope.itinerary.extra_info.age_group || $scope.ageOptions[1]
      $scope.checked_styles = $scope.itinerary.extra_info.styles || []
      $scope.subscription_id = $scope.itinerary.extra_info.subscription_id || 0
      $scope.plan = $scope.pricing[$scope.subscription_id].plan || $scope.pricing[0].plan
    $scope.winHeight = $window.innerHeight + 'px'
    $scope.showstyles = 'list'
    $scope.setStyles = (showstyles) ->
      $scope.showstyles = showstyles
      return
    
    $scope.step = $location.hash() || 1
    $scope.setStep = (step) ->
      $scope.step = step
      return
    
    $scope.types = [
      "domestic"
      "international"
    ]

    $scope.pricing = [
      {
        "personas": 1
        "fee": 499
        "plan": "Single"
      }
      {
        "personas": 2
        "fee": 799
        "plan": "Double"
      }
      {
        "personas": 3
        "fee": 999
        "plan": "Triple"
      }
    ]

    $scope.addPersona =  ->
      $scope.subscription_id++ if $scope.subscription_id < $scope.pricing.length - 1
      $scope.plan = $scope.pricing[$scope.subscription_id].plan
      return


    $scope.remPersona = ->
      $scope.subscription_id-- if $scope.subscription_id > 0 
      $scope.plan = $scope.pricing[$scope.subscription_id].plan
      return

    $scope.nextbudgetitem = (item) ->
      i = $scope.budgetOptions.indexOf(item)
      if i < $scope.budgetOptions.length - 1 
        return $scope.budgetOptions[i+1] 
      else
        return $scope.budgetOptions[0] 

    $scope.nextagegroup = (age_group) ->
      i = $scope.ageOptions.indexOf(age_group)
      if i < $scope.ageOptions.length - 1 
        return $scope.ageOptions[i+1] 
      else
        return $scope.ageOptions[0] 

    $scope.budgetOptions = [
      "$0-50"
      "$50-100"
      "$100-200"
      "$200+"
    ]      

    $scope.ageOptions = [
      "15-24"
      "25-39"
      "39-50"
      "55+"
    ]

    $scope.subTypes = [
      "Digital Only"
      "Digital + Print"
    ]

    $scope.printTypes = [
      "In House"
      "Delivered"
    ]

    $scope.personas = [
      "Business Travelers"
      "Family Travelers"
      "Leisure Couples"
      "Leisure Solo"
    ]

    $scope.styles = [
      "Art"
      "Museums"
      "Fine Dining"
      "Cafes"
      "Sports"
      "Shopping"
      "Day Trips"
      "Film"
      "Theatre"
      "Nightlife"
      "Spa & Wellbeing"
      "Music"
      "Festivals"
      "City Tours"
      "Nature"
      "Neighbourhoods"
    ]

    $scope.duration = 3

    $scope.addDuration = ->
      $scope.duration++   
      return

    $scope.subtractDuration = ->
      $scope.duration--
      return

    $scope.addType = (types) ->
      return  unless $scope.checked_types.indexOf(type) is -1
      $scope.checked_types.push type
      return

    
    $scope.save = ->
     console.log($scope.itinerary)
     $http.post('gp.json', $scope.itinerary)
     return true
    

    handler = StripeCheckout.configure(
      key: "pk_live_0qczMRuqwWxJ243elqtJzrx8"
      token: (token) ->
        $("div.hold").show()
        $input1 = $("<input type=hidden name=stripeToken />").val(token.id)
        $input2 = $("<input type=hidden name=plan />").val($scope.plan)
        $("form").append($input1, $input2).submit()
    )

    $scope.checkout = ->
      handler.open
        name: "OutTrippin"
        email: $scope.itinerary.user.email
        description: $scope.plan
      event.preventDefault()
      return
  ])


  .directive "checkList", ->
    scope:
      list: "=checkList"
      value: "@"

    link: (scope, elem, attrs) ->
      handler = (setup) ->
        checked = elem.prop("checked")
        index = scope.list.indexOf(scope.value)
        if checked and index is -1
          if setup
            elem.prop "checked", false
          else
            scope.list.push scope.value
        else if not checked and index isnt -1
          if setup
            elem.prop "checked", true
          else
            scope.list.splice index, 1
        return

      setupHandler = handler.bind(null, true)
      changeHandler = handler.bind(null, false)
      elem.on "change", ->
        scope.$apply changeHandler
        return

      scope.$watch "list", setupHandler, true
      return
  
  .directive "animateOnChange", (['$animate', ($animate) ->
    (scope, elem, attr) ->
      scope.$watch attr.animateOnChange, (nv, ov) ->
        unless nv is ov
          c = "change-up"
          $animate.addClass elem, c, ->
            $animate.removeClass elem, c
            return
        return
      return
  ])

  






  
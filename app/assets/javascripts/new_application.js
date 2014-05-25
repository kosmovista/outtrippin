//= require foundation/foundation.js
//= require foundation/foundation.reveal.js

$(document).foundation();

function imgLoaded(img) {
  var $img = $(img);
  $img.parent().parent().addClass('loaded');
};

$.get("/api/v1/plans")
// after receiving the data (plan headers)
  .done(function(data) {
    // will iterate and display each one of them
    var container = $("#plans-container");
    $.each(data, function(i, item) {
      // append the newly loaded plan to the list
      container.append('<li><a class="go-to-itinerary" href="/itineraries/' + item.id + '/plan "><p class="title">' + item.title + '</p><img src="' + item.cover + '" onload="imgLoaded(this)"><a class="author" href="/users/' + item.author.id + '"><img src="' + item.author.avatar + '" onload="imgLoaded(this)"><p class="author-name">Recommended by '+ item.author.name + '</p></a></a></li>');
    });
  });
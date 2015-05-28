// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap.min
//= require dropzone
//= require jquery.tokeninput

//= require_tree .

Dropzone.autoDiscover = false;

$(function() {
  var dropdiv = $("#entries");

  if (dropdiv.length) {
    var dropzone = new Dropzone(dropdiv[0], {
      paramName: "entry[image]",
      previewsContainer: "#dropzone-queue",
      dictDefaultMessage: "",
      clickable: "#clickable"
    });
  }

  $(document).on("click", ".select-text", function() {
    $(this).select();
  });

  $(".token-input").tokenInput("/tags", {
    theme: "mac",
    tokenValue: "name",
    preventDuplicates: true
  });
  
  var tokenList = $(".token-input-list-mac").addClass("form-control")
  $(".token-input-dropdown-mac").width(tokenList.width() - 5);

  // I wanted to animate the width of the search box on focus but couldn't
  // get it to work with css - it only worked on hover.
  var searchForm = $("#search-form");
  $("#search").on("focus", function() {
    searchForm.stop().animate({ width: "16em" }, 100);
  }).on("blur", function() {
    searchForm.stop().animate({ width: "12em" }, 100);
  })
});
// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require respond.min.js
//= require excanvas.min.js
//= require jquery.min.js
//= require jquery-migrate.min.js
//= require jquery-ui.min.js
//= require jquery.sparkline.min.js
//= require js/bootstrap.min.js
//= require raphael-min.js
//= require amcharts/amcharts.js
//= require amcharts/pie.js
//= require amcharts/serial.js
//= require amcharts/themes/light.js
//= require jquery.slimscroll.min.js
//= require jquery.blockui.min.js
//= require jquery.cokie.min.js
//= require jquery.uniform.min.js
//= require admin4/metronic.js
//= require admin4/layout.js
//= require admin4/demo.js
//= require admin4/tasks.js
  

  jQuery(document).ready(function() {
    Metronic.init();
    Layout.init();
    Demo.init();
    Index.init();
    
    // dropdown notifications
    $('#header_notification_bar').on('show.bs.dropdown', function() {
      var notifElement;
      notifElement = $(this);
      $.ajax({
        url: '/tdashboard/tipsters/view_notifications',
        type: 'PUT',
        beforeSend: function(xhr) {
          xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
        },
        success: function(response) {
          notifElement.find('.notif-num').text(response);
        }
      });
    });
    
    // Possible-winnings slip

    
    $(".possible-winning").text(0);
    $('#key_stake').keyup(function() {
      var totalodds = $("#total_odds").text() * $(this).val();
      $(".possible-winning").text((totalodds).toFixed(2));
      $(".possible-winning").val((totalodds).toFixed(2));
    });
    
    // Chart
    

  });
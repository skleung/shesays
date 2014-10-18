 // Initialize varibles
  var $window = $(window);
  var $companyInput = $('#company'); // Input for username

  var $loginPage = $('.login.page'); // The login page
  var $chatPage = $('.chat.page'); // The chatroom page

  // Prompt for setting a username
  var companyName;
  var clearedCompany = false;

  // Sets the client's companyName
  function setCompanyName() {
    companyName = cleanInput($companyInput.html().trim());
          console.log("sf");

    // If the companyName is valid
    if (companyName) {
      $loginPage.fadeOut();
      $chatPage.show();
      $loginPage.off('click');
      // Tell the server your username
      //TODO: query the server here for companyName
      $("#selected-company").html(companyName);
    }
  }

  // Prevents input from having injected markup
  function cleanInput (input) {
    return $('<div/>').text(input).text();
  }

  // Keyboard events

  $window.keydown(function (event) {
    // Auto-focus the current input when a key is typed
    if (!(event.ctrlKey || event.metaKey || event.altKey)) {
      $companyInput.focus();
    }
    if (!clearedCompany) {
      $companyInput.html("");
      clearedCompany = true;
    }
    // When the client hits ENTER on their keyboard
    if (event.which === 13) {
      if (companyName) {
        typing = false;
      } else {
        setCompanyName();
      }
    }
  });

  window.onload = function() {
    $("#company").focus();
  };
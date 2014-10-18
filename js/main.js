 // Initialize varibles
  var $window = $(window);
  var $usernameInput = $('.usernameInput'); // Input for username

  var $loginPage = $('.login.page'); // The login page
  var $chatPage = $('.chat.page'); // The chatroom page

  // Prompt for setting a username
  var username;
  var connected = false;
  var typing = false;
  var lastTypingTime;
  var $currentInput = $usernameInput.focus();

  // Sets the client's username
  function setUsername () {
    username = cleanInput($usernameInput.val().trim());

    // If the username is valid
    if (username) {
      $loginPage.fadeOut();
      $chatPage.show();
      $loginPage.off('click');
      $currentInput = $inputMessage.focus();

      // Tell the server your username
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
      $currentInput.focus();
    }
    console.log("event1");
    // When the client hits ENTER on their keyboard
    if (event.which === 13) {
      if (username) {
        typing = false;
      } else {
        setUsername();
      }
    }
  });

  window.onload = function() {
    $("#company").focus();
  };
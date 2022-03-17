// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.


const button = document.querySelector("h1")
  button.addEventListener("click", () => {
    button.classList.toggle("plus-minus-button-toggle")
})


const channels = require.context('.', true, /_channel\.js$/)
channels.keys().forEach(channels)
